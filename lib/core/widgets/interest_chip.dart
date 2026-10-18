import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_dimensions.dart';
import '../theme/app_text_styles.dart';
import 'app_image.dart';

/// Pill-shaped selectable interest chip matching reference screenshot design.
class InterestChip extends StatelessWidget {
  final String title;
  final String imageUrl;
  final bool isSelected;
  final VoidCallback onTap;

  const InterestChip({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.cardSurface
              : AppColors.chipSurface,
          borderRadius: BorderRadius.circular(AppDimensions.radiusPill),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: isSelected ? 2.0 : 1.0,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppImage(
              url: imageUrl,
              width: 28,
              height: 28,
              borderRadius: BorderRadius.circular(14),
            ),
            const SizedBox(width: 8),
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Text(
                title,
                style: AppTextStyles.chip.copyWith(
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  color: AppColors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
