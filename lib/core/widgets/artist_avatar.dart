import 'package:flutter/material.dart';
import '../../data/models/artist_model.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import 'app_image.dart';

/// Favorite artist circular avatar widget.
class ArtistAvatar extends StatelessWidget {
  final ArtistModel artist;

  const ArtistAvatar({
    super.key,
    required this.artist,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      margin: const EdgeInsets.only(right: 14),
      child: Column(
        children: [
          AppImage(
            url: artist.imageUrl,
            width: 70,
            height: 70,
            borderRadius: BorderRadius.circular(35),
          ),
          const SizedBox(height: 6),
          Text(
            artist.name,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.w600,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}
