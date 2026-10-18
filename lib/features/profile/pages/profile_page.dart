import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/section_title.dart';
import '../../../core/widgets/artist_avatar.dart';
import '../../../core/widgets/playlist_card.dart';
import '../../../core/widgets/app_image.dart';
import '../../../core/widgets/dating_badge_chip.dart';
import '../../../core/widgets/show_card.dart';
import '../../../core/widgets/top_track_item.dart';
import '../../../core/widgets/neon_button.dart';
import '../../authentication/controllers/auth_controller.dart';
import '../controllers/profile_controller.dart';
import '../../interests/pages/dating_profile_setup_page.dart';
import '../../interests/pages/media_connections_page.dart';

/// Logged in User Profile screen with dating preferences, photo gallery, media connections, and logout.
class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authCtrl = Get.find<AuthController>();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          'Good morning!',
          style: AppTextStyles.subtitle.copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: AppColors.primary, size: 22),
            tooltip: 'Logout',
            onPressed: () {
              Get.dialog(
                AlertDialog(
                  backgroundColor: AppColors.surface,
                  title: Text(
                    'Logout',
                    style: AppTextStyles.heading,
                  ),
                  content: Text(
                    'Are you sure you want to logout of Jingle?',
                    style: AppTextStyles.bodySecondary,
                  ),
                  actions: [
                    TextButton(
                      child: Text(
                        'Cancel',
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.secondaryText,
                        ),
                      ),
                      onPressed: () => Get.back(),
                    ),
                    TextButton(
                      child: Text(
                        'Logout',
                        style: AppTextStyles.button.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                      onPressed: () {
                        Get.back();
                        authCtrl.logout();
                      },
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(width: 8),
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
            // 1. User Header Info Card
            Obx(() {
              final user =
                  authCtrl.currentUser.value ?? controller.currentUser.value;
              final prefs = user.datingPreferences;

              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.divider),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Stack(
                          children: [
                            AppImage(
                              url: user.imageUrl,
                              width: 64,
                              height: 64,
                              borderRadius: BorderRadius.circular(32),
                            ),
                            Positioned(
                              top: 2,
                              right: 2,
                              child: Container(
                                width: 12,
                                height: 12,
                                decoration: BoxDecoration(
                                  color: AppColors.online,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: AppColors.surface,
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${user.name}, ${user.age}',
                                style: AppTextStyles.heading.copyWith(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                user.location,
                                style: AppTextStyles.caption.copyWith(
                                  color: AppColors.secondaryText,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  AppImage(
                                    url: user.currentSong?.albumArt ??
                                        user.imageUrl,
                                    width: 20,
                                    height: 20,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  const SizedBox(width: 6),
                                  Expanded(
                                    child: Text(
                                      user.currentSong != null
                                          ? '${user.currentSong!.title} • ${user.currentSong!.artist}'
                                          : 'Wall of the eyes • The Smile',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppTextStyles.body.copyWith(
                                        fontSize: 11,
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    const Divider(color: AppColors.divider),
                    const SizedBox(height: 8),

                    // Quick Actions: Edit Dating Profile & Manage Media
                    Row(
                      children: [
                        Expanded(
                          child: NeonButton(
                            text: 'Edit Dating Profile',
                            height: 32,
                            icon: Icons.edit,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            backgroundColor: AppColors.primary,
                            textColor: Colors.black,
                            onPressed: () {
                              Get.to(() => const DatingProfileSetupPage(
                                    isEditMode: true,
                                  ));
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: NeonButton(
                            text: 'Media Accounts',
                            height: 32,
                            icon: Icons.link,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            backgroundColor: AppColors.cardSurface,
                            textColor: AppColors.white,
                            onPressed: () {
                              Get.to(() => const MediaConnectionsPage(
                                    isEditMode: true,
                                  ));
                            },
                          ),
                        ),
                      ],
                    ),

                    if (prefs != null) ...[
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
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
                              label: prefs.relationshipIntent!.shortLabel,
                              icon: Icons.explore_outlined,
                              backgroundColor:
                                  AppColors.primary.withValues(alpha: 0.15),
                              textColor: AppColors.primary,
                              borderColor: AppColors.primary,
                            ),
                        ],
                      ),
                    ],
                  ],
                ),
              );
            }),

            const SizedBox(height: 20),

            // 2. Photo Gallery (up to 6 photos)
            Obx(() {
              final user =
                  authCtrl.currentUser.value ?? controller.currentUser.value;
              final photos = user.displayPhotos;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SectionTitle(
                    title: 'Your Photos (${photos.length}/6)',
                    onSeeAll: () {
                      Get.to(() => const DatingProfileSetupPage(
                            isEditMode: true,
                          ));
                    },
                  ),
                  SizedBox(
                    height: 120,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemCount: photos.length,
                      itemBuilder: (context, index) {
                        final photo = photos[index];
                        return Container(
                          width: 90,
                          margin: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: photo.isPrimary
                                  ? AppColors.primary
                                  : AppColors.border,
                              width: photo.isPrimary ? 2 : 1,
                            ),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: AppImage(
                                  url: photo.url,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              if (photo.isPrimary)
                                Positioned(
                                  bottom: 4,
                                  left: 4,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: AppColors.primary,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      'COVER',
                                      style: AppTextStyles.caption.copyWith(
                                        color: Colors.black,
                                        fontSize: 8,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }),

            const SizedBox(height: 20),

            // 3. Top 5 Frequently Listened Songs (sorted descending)
            const SectionTitle(title: 'Top 5 Frequently Listening To'),
            Obx(
              () => Column(
                children: List.generate(
                  controller.frequentlyListening.length,
                  (index) {
                    final track = controller.frequentlyListening[index];
                    return TopTrackItem(
                      track: track,
                      rank: index + 1,
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 16),

            // 4. Favorite Shows & Movies
            const SectionTitle(title: 'Favorite Shows & Movies'),
            SizedBox(
              height: 155,
              child: Obx(
                () => ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: controller.favoriteShows.length,
                  itemBuilder: (context, index) {
                    return ShowCard(show: controller.favoriteShows[index]);
                  },
                ),
              ),
            ),

            const SizedBox(height: 16),

            // 5. Favorite Playlists
            const SectionTitle(title: 'Favorite Playlists'),
            SizedBox(
              height: 200,
              child: Obx(
                () => ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: controller.favoritePlaylists.length,
                  itemBuilder: (context, index) {
                    return PlaylistCard(
                      playlist: controller.favoritePlaylists[index],
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 16),

            // 6. Favorite Artists
            const SectionTitle(title: 'Favorite Artists'),
            SizedBox(
              height: 105,
              child: Obx(
                () => ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: controller.favoriteArtists.length,
                  itemBuilder: (context, index) {
                    return ArtistAvatar(
                      artist: controller.favoriteArtists[index],
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 16),

            // 7. Favorite Genres
            const SectionTitle(title: 'Favorite Genres'),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 2.8,
              ),
              itemCount: 2,
              itemBuilder: (context, index) {
                final names = ['Classical', 'Hip-Hop'];
                return Container(
                  decoration: BoxDecoration(
                    color: AppColors.cardSurface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                        color: index == 0 ? AppColors.primary : AppColors.white,
                        width: 4,
                      ),
                    ),
                  ),
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    names[index],
                    style: AppTextStyles.body.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
