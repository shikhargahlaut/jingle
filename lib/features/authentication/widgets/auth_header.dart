import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_logo.dart';

/// Visually appealing header widget for authentication screens with official brand logo.
class AuthHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final double logoSize;

  const AuthHeader({
    super.key,
    required this.title,
    required this.subtitle,
    this.logoSize = 72.0,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 12),
        // Official App Brand Logo
        AppLogo(
          size: logoSize,
          borderRadius: logoSize * 0.25,
        ),
        const SizedBox(height: 20),
        Text(
          title,
          textAlign: TextAlign.center,
          style: AppTextStyles.display.copyWith(
            fontSize: 24,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: AppTextStyles.subtitle.copyWith(
            fontSize: 13,
            color: AppColors.secondaryText,
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
