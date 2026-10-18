import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/user_model.dart';
import '../../../data/models/media_connection_model.dart';
import '../../../data/mock/mock_data.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/section_title.dart';
import '../../../core/widgets/activity_card.dart';
import '../../../core/widgets/playlist_card.dart';
import '../../../core/widgets/artist_avatar.dart';
import '../../../core/widgets/dating_badge_chip.dart';
import '../../../core/widgets/show_card.dart';
import '../../../core/widgets/top_track_item.dart';
import '../../../core/widgets/compatibility_badge.dart';
import '../../../core/widgets/app_image.dart';
import '../widgets/swipe_profile_card.dart';
import '../controllers/swipe_controller.dart';

/// Detailed user profile breakdown screen with complete dating, media, and compatibility data.
class SwipeProfileDetailPage extends GetView<SwipeController> {
  const SwipeProfileDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final UserModel user =
        (Get.arguments as UserModel?) ?? MockData.userJohnJacobs;
    final prefs = user.datingPreferences;
    final photos = user.displayPhotos;
    final topTracks = user.displayTopTracks;
    final shows = user.favoriteShows;
    final connectedMedia = user.mediaConnections
        .where((c) => c.status == ConnectionStatus.connected)
        .toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.white),
          onPressed: () => Get.back(),
        ),
        title: Text(
          user.name,
          style: AppTextStyles.heading.copyWith(fontSize: 18),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border, color: AppColors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.chat_bubble_outline, color: AppColors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.screenPaddingHorizontal,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Top Card View with Multi-photo Navigation
            SizedBox(
              height: 380,
              child: SwipeProfileCard(
                user: user,
                onFollowTap: () => controller.toggleFollowCurrentProfile(),
              ),
            ),

            const SizedBox(height: 16),

            // 2. Compatibility Score Breakdown Card
            _buildCompatibilitySection(context, user),

            const SizedBox(height: 20),

            // 3. About Me / Bio
            const SectionTitle(title: 'About me'),
            Text(
              user.bio.isNotEmpty
                  ? user.bio
                  : 'Music explorer finding new soundscapes and rhythms.',
              style: AppTextStyles.bodySecondary.copyWith(
                height: 1.4,
                fontSize: 13,
              ),
            ),

            const SizedBox(height: 20),

            // 4. Dating Preferences & Intent Badges
            if (prefs != null) ...[
              const SectionTitle(title: 'Dating & Intent'),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  if (prefs.gender != null)
                    DatingBadgeChip(
                      label: prefs.gender!.label,
                      icon: Icons.person_outline,
                    ),
                  if (prefs.lookingFor != null)
                    DatingBadgeChip(
                      label: 'Seeking: ${prefs.lookingFor!.label}',
                      icon: Icons.favorite,
                    ),
                  if (prefs.relationshipStatus != null)
                    DatingBadgeChip(
                      label: prefs.relationshipStatus!.label,
                      icon: Icons.circle_outlined,
                    ),
                  if (prefs.relationshipIntent != null)
                    DatingBadgeChip(
                      label: prefs.relationshipIntent!.label,
                      icon: Icons.explore_outlined,
                      backgroundColor: AppColors.primary.withValues(alpha: 0.15),
                      borderColor: AppColors.primary,
                      textColor: AppColors.primary,
                    ),
                ],
              ),
              const SizedBox(height: 20),
            ],

            // 5. Photo Gallery (if multiple photos exist)
            if (photos.length > 1) ...[
              SectionTitle(
                title: 'Photo Gallery (${photos.length})',
              ),
              SizedBox(
                height: 140,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: photos.length,
                  itemBuilder: (context, index) {
                    final photo = photos[index];
                    return Container(
                      width: 105,
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: photo.isPrimary
                              ? AppColors.primary
                              : AppColors.border,
                          width: photo.isPrimary ? 2 : 1,
                        ),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: AppImage(
                        url: photo.url,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
            ],

            // 6. Connected Media & Social Services
            if (connectedMedia.isNotEmpty) ...[
              const SectionTitle(title: 'Connected Media & Socials'),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: connectedMedia.map((conn) {
                  return Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.divider),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _getPlatformIcon(conn.platform),
                          size: 16,
                          color: _getPlatformColor(conn.platform),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          conn.platform.displayName,
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        if (conn.accountUsername != null) ...[
                          const SizedBox(width: 4),
                          Text(
                            conn.accountUsername!,
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.secondaryText,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ],
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
            ],

            // 7. Top 5 Frequently Listened Songs (sorted descending)
            if (topTracks.isNotEmpty) ...[
              const SectionTitle(title: 'Top 5 Currently Listening To'),
              Column(
                children: List.generate(topTracks.length, (index) {
                  final track = topTracks[index];
                  return TopTrackItem(
                    track: track,
                    rank: index + 1,
                  );
                }),
              ),
              const SizedBox(height: 20),
            ],

            // 8. Favorite Shows / Movies
            if (shows.isNotEmpty) ...[
              const SectionTitle(title: 'Favorite Shows & Movies'),
              SizedBox(
                height: 155,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: shows.length,
                  itemBuilder: (context, index) {
                    return ShowCard(show: shows[index]);
                  },
                ),
              ),
              const SizedBox(height: 20),
            ],

            // 9. Favorite Artists
            if (user.favoriteArtists.isNotEmpty) ...[
              const SectionTitle(title: 'Favorite Artists'),
              SizedBox(
                height: 105,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: user.favoriteArtists.length,
                  itemBuilder: (context, index) {
                    return ArtistAvatar(
                      artist: user.favoriteArtists[index],
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
            ],

            // 10. Activities
            if (user.activities.isNotEmpty) ...[
              const SectionTitle(title: 'Activities'),
              SizedBox(
                height: 84,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: user.activities.length,
                  itemBuilder: (context, index) {
                    return ActivityCard(activity: user.activities[index]);
                  },
                ),
              ),
              const SizedBox(height: 20),
            ],

            // 11. Similar Genres
            if (user.favoriteGenres.isNotEmpty) ...[
              const SectionTitle(title: 'Favorite Genres'),
              SizedBox(
                height: 80,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: user.favoriteGenres.length,
                  itemBuilder: (context, index) {
                    final genre = user.favoriteGenres[index];
                    return Container(
                      width: 75,
                      margin: const EdgeInsets.only(right: 12),
                      child: Column(
                        children: [
                          Container(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(colors: genre.colors),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.music_note,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            genre.name,
                            textAlign: TextAlign.center,
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.white,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
            ],

            // 12. Playlists
            if (user.myPlaylists.isNotEmpty) ...[
              const SectionTitle(title: 'My Playlists'),
              SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: user.myPlaylists.length,
                  itemBuilder: (context, index) {
                    return PlaylistCard(playlist: user.myPlaylists[index]);
                  },
                ),
              ),
              const SizedBox(height: 20),
            ],

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildCompatibilitySection(BuildContext context, UserModel user) {
    final comp = user.compatibility;
    final score = user.musicSimilarity;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.bolt,
                      color: AppColors.primary,
                      size: 16,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Media Compatibility',
                    style: AppTextStyles.sectionTitle.copyWith(fontSize: 14),
                  ),
                ],
              ),
              CompatibilityBadge(
                score: score,
                compatibility: comp,
                showLabel: false,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            comp != null
                ? 'You and ${user.name} share a ${comp.tierLabel.toLowerCase()} with high overlap in music & streaming taste.'
                : 'Based on your shared listening history, genres, and favorite artists.',
            style: AppTextStyles.subtitle.copyWith(fontSize: 12),
          ),
          if (comp != null && comp.sharedGenres.isNotEmpty) ...[
            const SizedBox(height: 10),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: comp.sharedGenres.map((g) {
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: AppColors.chipSurface,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.4),
                      width: 0.5,
                    ),
                  ),
                  child: Text(
                    g,
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.primary,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }

  Color _getPlatformColor(MediaPlatform platform) {
    switch (platform) {
      case MediaPlatform.spotify:
        return const Color(0xFF1DB954);
      case MediaPlatform.youtube:
        return const Color(0xFFFF0000);
      case MediaPlatform.appleMusic:
        return const Color(0xFFFA243C);
      case MediaPlatform.netflix:
        return const Color(0xFFE50914);
      case MediaPlatform.amazonPrime:
        return const Color(0xFF00A8E1);
      case MediaPlatform.instagram:
        return const Color(0xFFE1306C);
    }
  }

  IconData _getPlatformIcon(MediaPlatform platform) {
    switch (platform) {
      case MediaPlatform.spotify:
        return Icons.graphic_eq;
      case MediaPlatform.youtube:
        return Icons.play_circle_filled;
      case MediaPlatform.appleMusic:
        return Icons.music_note;
      case MediaPlatform.netflix:
        return Icons.movie;
      case MediaPlatform.amazonPrime:
        return Icons.tv;
      case MediaPlatform.instagram:
        return Icons.camera_alt;
    }
  }
}
