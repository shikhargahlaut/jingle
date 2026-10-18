import 'package:flutter/material.dart';

/// Reusable App Logo widget loading the official neon-lime brand asset.
class AppLogo extends StatelessWidget {
  final double size;
  final double? borderRadius;

  const AppLogo({
    super.key,
    this.size = 80.0,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    Widget logoWidget = Image.asset(
      'assets/branding/app_logo.png',
      width: size,
      height: size,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: const Color(0xFFB5F23D),
          borderRadius: BorderRadius.circular(borderRadius ?? (size * 0.25)),
        ),
        child: const Center(
          child: Icon(
            Icons.graphic_eq,
            color: Colors.black,
            size: 32,
          ),
        ),
      ),
    );

    if (borderRadius != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius!),
        child: logoWidget,
      );
    }

    return logoWidget;
  }
}
