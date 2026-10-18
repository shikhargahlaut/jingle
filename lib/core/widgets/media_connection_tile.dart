import 'package:flutter/material.dart';
import '../../data/models/media_connection_model.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import 'neon_button.dart';

/// Reusable tile component displaying external media and social connections.
class MediaConnectionTile extends StatelessWidget {
  final MediaConnectionModel connection;
  final VoidCallback onToggleConnect;
  final bool isLoading;

  const MediaConnectionTile({
    super.key,
    required this.connection,
    required this.onToggleConnect,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final platform = connection.platform;
    final isConnected = connection.status == ConnectionStatus.connected;
    final brandColor = _getBrandColor(platform);
    final iconData = _getBrandIcon(platform);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isConnected ? brandColor.withValues(alpha: 0.6) : AppColors.divider,
          width: isConnected ? 1.5 : 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: brandColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: brandColor.withValues(alpha: 0.4),
                width: 1,
              ),
            ),
            child: Center(
              child: Icon(
                iconData,
                color: brandColor,
                size: 22,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      platform.displayName,
                      style: AppTextStyles.body.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.chipSurface,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        platform.category,
                        style: AppTextStyles.caption.copyWith(
                          fontSize: 9,
                          color: AppColors.secondaryText,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  isConnected
                      ? connection.accountUsername ?? 'Connected'
                      : 'Connect your ${platform.displayName} account',
                  style: AppTextStyles.caption.copyWith(
                    color: isConnected
                        ? AppColors.primary
                        : AppColors.secondaryText,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          if (isLoading)
            const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: AppColors.primary,
              ),
            )
          else if (isConnected)
            GestureDetector(
              onTap: onToggleConnect,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.cardSurface,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.primary, width: 1),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.check,
                      size: 14,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Linked',
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            NeonButton(
              text: 'Connect',
              height: 28,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              backgroundColor: AppColors.primary,
              textColor: Colors.black,
              onPressed: onToggleConnect,
            ),
        ],
      ),
    );
  }

  Color _getBrandColor(MediaPlatform platform) {
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

  IconData _getBrandIcon(MediaPlatform platform) {
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
