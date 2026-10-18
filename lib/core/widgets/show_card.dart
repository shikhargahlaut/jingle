import 'package:flutter/material.dart';
import '../../data/models/favorite_show_model.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import 'app_image.dart';

/// Reusable Show / Movie card widget for swipe detail & user profile.
class ShowCard extends StatelessWidget {
  final FavoriteShowModel show;
  final VoidCallback? onTap;

  const ShowCard({
    super.key,
    required this.show,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isNetflix = show.platform.toLowerCase().contains('netflix');

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.divider),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 0.9,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: AppImage(
                      url: show.posterUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 6,
                    left: 6,
                    child: Container(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: isNetflix
                            ? const Color(0xFFE50914)
                            : const Color(0xFF00A8E1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        show.platform,
                        style: AppTextStyles.caption.copyWith(
                          color: Colors.white,
                          fontSize: 8,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    show.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.body.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  if (show.genre != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      show.genre!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.secondaryText,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
