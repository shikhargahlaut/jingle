import 'package:flutter/material.dart';
import '../../../data/models/user_model.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_image.dart';
import '../../../core/widgets/neon_button.dart';
import '../../../core/widgets/dating_badge_chip.dart';
import '../../../core/widgets/compatibility_badge.dart';

/// Upgraded Swipe Discovery Card supporting multi-photo browsing, dating badges, and sound wave ticker.
class SwipeProfileCard extends StatefulWidget {
  final UserModel user;
  final VoidCallback? onFollowTap;
  final VoidCallback? onTap;

  const SwipeProfileCard({
    super.key,
    required this.user,
    this.onFollowTap,
    this.onTap,
  });

  @override
  State<SwipeProfileCard> createState() => _SwipeProfileCardState();
}

class _SwipeProfileCardState extends State<SwipeProfileCard> {
  int _currentPhotoIndex = 0;

  List<String> get _photoUrls {
    if (widget.user.photos.isNotEmpty) {
      return widget.user.photos.map((p) => p.url).toList();
    }
    if (widget.user.imageUrl.isNotEmpty) {
      return [widget.user.imageUrl];
    }
    return [];
  }

  void _nextPhoto() {
    if (_photoUrls.length > 1 && _currentPhotoIndex < _photoUrls.length - 1) {
      setState(() {
        _currentPhotoIndex++;
      });
    }
  }

  void _prevPhoto() {
    if (_currentPhotoIndex > 0) {
      setState(() {
        _currentPhotoIndex--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = widget.user;
    final photos = _photoUrls;
    final currentUrl = photos.isNotEmpty && _currentPhotoIndex < photos.length
        ? photos[_currentPhotoIndex]
        : user.imageUrl;
    final prefs = user.datingPreferences;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border, width: 1.0),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          // Background Portrait Image
          Positioned.fill(
            child: AppImage(
              url: currentUrl,
              fit: BoxFit.cover,
            ),
          ),

          // Tap gesture zones for photo navigation
          if (photos.length > 1) ...[
            Positioned(
              top: 40,
              bottom: 120,
              left: 0,
              width: 100,
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: _prevPhoto,
              ),
            ),
            Positioned(
              top: 40,
              bottom: 120,
              right: 0,
              width: 100,
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: _nextPhoto,
              ),
            ),
          ],

          // Multi-photo top indicator bars
          if (photos.length > 1)
            Positioned(
              top: 8,
              left: 12,
              right: 12,
              child: Row(
                children: List.generate(photos.length, (i) {
                  final isCurrent = i == _currentPhotoIndex;
                  return Expanded(
                    child: Container(
                      height: 3,
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      decoration: BoxDecoration(
                        color: isCurrent
                            ? AppColors.primary
                            : Colors.white.withValues(alpha: 0.4),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  );
                }),
              ),
            ),

          // Bottom Gradient Overlay
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: 220,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    Color(0x99000000),
                    Color(0xFF000000),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),

          // Top Right Compatibility Similarity Badge
          Positioned(
            top: photos.length > 1 ? 18 : 14,
            right: 14,
            child: CompatibilityBadge(
              score: user.musicSimilarity,
              compatibility: user.compatibility,
              showLabel: true,
            ),
          ),

          // Bottom Info Section
          Positioned(
            left: 16,
            bottom: 16,
            right: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Name and Age
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${user.name}, ${user.age}',
                        style: AppTextStyles.display.copyWith(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    if (widget.onTap != null)
                      GestureDetector(
                        onTap: widget.onTap,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.arrow_upward,
                            size: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 6),

                // Dating Preference Badges
                if (prefs != null) ...[
                  Wrap(
                    spacing: 6,
                    runSpacing: 4,
                    children: [
                      if (prefs.relationshipIntent != null)
                        DatingBadgeChip(
                          label: prefs.relationshipIntent!.shortLabel,
                          icon: Icons.explore_outlined,
                          backgroundColor: Colors.black.withValues(alpha: 0.5),
                        ),
                      if (prefs.relationshipStatus != null)
                        DatingBadgeChip(
                          label: prefs.relationshipStatus!.label,
                          icon: Icons.circle_outlined,
                          backgroundColor: Colors.black.withValues(alpha: 0.5),
                        ),
                      if (prefs.lookingFor != null)
                        DatingBadgeChip(
                          label: 'Looking for ${prefs.lookingFor!.label}',
                          icon: Icons.favorite,
                          backgroundColor: Colors.black.withValues(alpha: 0.5),
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),
                ],

                // Current song ticker / vibe
                if (user.currentSong != null) ...[
                  Row(
                    children: [
                      const Icon(
                        Icons.graphic_eq,
                        size: 14,
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          '${user.currentSong!.title} • ${user.currentSong!.artist}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w700,
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                ],

                // Follow & View Profile Row
                Row(
                  children: [
                    NeonButton(
                      text: user.isFollowing ? 'Following' : 'Follow',
                      height: 32,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      backgroundColor: user.isFollowing
                          ? const Color(0xFFDCDCE0)
                          : AppColors.primary,
                      textColor: Colors.black,
                      onPressed: widget.onFollowTap ?? () {},
                    ),
                    const SizedBox(width: 10),
                    if (widget.onTap != null)
                      GestureDetector(
                        onTap: widget.onTap,
                        child: Container(
                          height: 32,
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          decoration: BoxDecoration(
                            color: AppColors.cardSurface,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: AppColors.border.withValues(alpha: 0.6),
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'View Details',
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.white,
                              fontWeight: FontWeight.w700,
                            ),
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
    );
  }
}
