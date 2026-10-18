import 'package:flutter/material.dart';
import '../../data/models/music_model.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import 'app_image.dart';

/// Row widget displaying a top ranked song in the Top 5 list with rank badge and plays.
class TopTrackItem extends StatelessWidget {
  final MusicModel track;
  final int rank; // 1 to 5
  final VoidCallback? onTap;

  const TopTrackItem({
    super.key,
    required this.track,
    required this.rank,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isSpotify = track.platform == 'spotify';
    final isYoutube = track.platform == 'youtube';

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.divider),
        ),
        child: Row(
          children: [
            // Rank Number Badge
            Container(
              width: 24,
              height: 24,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: rank == 1
                    ? AppColors.primary
                    : AppColors.chipSurface,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                '#$rank',
                style: AppTextStyles.caption.copyWith(
                  color: rank == 1 ? Colors.black : AppColors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 10,
                ),
              ),
            ),
            const SizedBox(width: 10),

            // Album Artwork
            AppImage(
              url: track.albumArt,
              width: 44,
              height: 44,
              borderRadius: BorderRadius.circular(8),
            ),
            const SizedBox(width: 12),

            // Title & Artist
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    track.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.body.copyWith(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    track.artist,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.secondaryText,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),

            // Play count & Platform indicator
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.music_note,
                  size: 13,
                  color: AppColors.secondaryText,
                ),
                const SizedBox(width: 3),
                Text(
                  track.plays,
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.secondaryText,
                    fontWeight: FontWeight.w600,
                    fontSize: 11,
                  ),
                ),
                if (isSpotify || isYoutube) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: isSpotify
                          ? const Color(0xFF1DB954)
                          : const Color(0xFFFF0000),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isSpotify ? Icons.graphic_eq : Icons.play_arrow,
                      size: 10,
                      color: Colors.white,
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
