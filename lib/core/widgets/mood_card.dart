import 'package:flutter/material.dart';
import '../../data/models/mood_model.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import 'app_image.dart';

/// Colorful sticker-style mood card widget matching screenshot grid.
class MoodCard extends StatelessWidget {
  final MoodModel mood;
  final bool isSelected;
  final VoidCallback? onTap;

  const MoodCard({
    super.key,
    required this.mood,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: isSelected ? 2.5 : 1,
          ),
        ),
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: AppImage(
                url: mood.imageUrl,
                fit: BoxFit.contain,
                errorWidget: Center(
                  child: Text(
                    _getMoodEmoji(mood.name),
                    style: const TextStyle(fontSize: 36),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              mood.name,
              style: AppTextStyles.caption.copyWith(
                color: isSelected ? AppColors.primary : AppColors.white,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  String _getMoodEmoji(String name) {
    switch (name.toLowerCase()) {
      case 'in love':
        return '😍';
      case 'devilish':
        return '😈';
      case 'exhausted':
        return '😩';
      case 'happy':
        return '😃';
      case 'relaxed':
        return '😌';
      case 'energetic':
        return '⚡';
      case 'sad':
        return '😢';
      case 'chill':
        return '😎';
      default:
        return '🎵';
    }
  }
}
