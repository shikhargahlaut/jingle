import 'package:flutter/material.dart';
import '../../data/models/user_model.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import 'app_image.dart';

/// "Top Profile Charts" compact row widget matching reference screenshot.
class ChartCard extends StatelessWidget {
  final UserModel user;

  const ChartCard({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    final song = user.currentSong;

    return Container(
      margin: const EdgeInsets.only(bottom: 8.0),
      height: 48,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      clipBehavior: Clip.antiAlias,
      child: Row(
        children: [
          AppImage(
            url: user.imageUrl,
            width: 48,
            height: 48,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  style: AppTextStyles.body.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
                Text(
                  song != null ? song.title : 'During workout',
                  style: AppTextStyles.caption.copyWith(
                    color: Colors.black54,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              const Icon(
                Icons.music_note,
                size: 14,
                color: Colors.black,
              ),
              const SizedBox(width: 2),
              Text(
                song?.plays ?? '9.5k',
                style: AppTextStyles.caption.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 18,
                height: 18,
                decoration: const BoxDecoration(
                  color: Color(0xFFFF0000),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.play_arrow,
                  size: 12,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),
          AppImage(
            url: user.imageUrl,
            width: 32,
            height: 48,
          ),
        ],
      ),
    );
  }
}
