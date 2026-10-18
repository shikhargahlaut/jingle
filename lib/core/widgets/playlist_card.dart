import 'package:flutter/material.dart';
import '../../data/models/playlist_model.dart';
import '../theme/app_colors.dart';
import '../theme/app_dimensions.dart';
import '../theme/app_text_styles.dart';
import 'app_image.dart';

/// Reusable Playlist Card matching reference screenshot style.
class PlaylistCard extends StatelessWidget {
  final PlaylistModel playlist;
  final VoidCallback? onTap;

  const PlaylistCard({
    super.key,
    required this.playlist,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: AppDimensions.playlistCardWidth,
        margin: const EdgeInsets.only(right: 12.0),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1.1,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: AppImage(url: playlist.coverUrl),
                  ),
                  Positioned(
                    bottom: 6,
                    right: 6,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.7),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.music_note,
                            size: 10,
                            color: AppColors.white,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            playlist.playsCount,
                            style: AppTextStyles.caption.copyWith(
                              fontSize: 9,
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (playlist.platform != null)
                    Positioned(
                      bottom: 6,
                      left: 6,
                      child: _buildPlatformBadge(playlist.platform!),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      AppImage(
                        url: playlist.ownerAvatar,
                        width: 20,
                        height: 20,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          playlist.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.body.copyWith(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    playlist.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.caption.copyWith(
                      fontSize: 10,
                      color: AppColors.secondaryText,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlatformBadge(String platform) {
    final isSpotify = platform == 'spotify';
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: isSpotify ? const Color(0xFF1DB954) : const Color(0xFFFF0000),
        shape: BoxShape.circle,
      ),
      child: Icon(
        isSpotify ? Icons.graphic_eq : Icons.play_arrow,
        size: 10,
        color: Colors.white,
      ),
    );
  }
}
