import 'package:flutter/material.dart';
import '../../data/models/user_model.dart';
import '../theme/app_colors.dart';
import '../theme/app_dimensions.dart';
import '../theme/app_text_styles.dart';
import 'app_image.dart';
import 'neon_button.dart';

/// "People You May Know" horizontal profile card matching reference screenshot.
class ProfileCard extends StatelessWidget {
  final UserModel user;
  final VoidCallback? onFollowTap;

  const ProfileCard({
    super.key,
    required this.user,
    this.onFollowTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppDimensions.profileCardWidth,
      margin: const EdgeInsets.only(right: 12.0),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border, width: 0.5),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Expanded(
            child: AppImage(
              url: user.imageUrl,
              width: double.infinity,
            ),
          ),
          Container(
            color: AppColors.white,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
            child: Column(
              children: [
                Text(
                  user.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.body.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                NeonButton(
                  text: user.isFollowing ? 'Following' : 'Follow',
                  height: 24,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  backgroundColor: user.isFollowing
                      ? const Color(0xFFDCDCE0)
                      : AppColors.primary,
                  textColor: Colors.black,
                  onPressed: onFollowTap ?? () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
