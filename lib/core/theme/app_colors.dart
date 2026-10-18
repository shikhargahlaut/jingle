import 'package:flutter/material.dart';

/// Centralized app color tokens matching reference screenshot design.
abstract class AppColors {
  /// Dark background color (#09080D)
  static const Color background = Color(0xFF09080D);

  /// Surface card background color (#15141A)
  static const Color surface = Color(0xFF15141A);

  /// Primary accent color - Neon Green/Lime (#B5F23D)
  static const Color primary = Color(0xFFB5F23D);

  /// Pure white (#FFFFFF)
  static const Color white = Color(0xFFFFFFFF);

  /// Secondary text color (#A5A3AA)
  static const Color secondaryText = Color(0xFFA5A3AA);

  /// Border color (#5F5E64)
  static const Color border = Color(0xFF5F5E64);

  /// Divider color (#242229)
  static const Color divider = Color(0xFF242229);

  /// Dark grey card surface (#201F26)
  static const Color cardSurface = Color(0xFF201F26);

  /// Light grey chip border / surface
  static const Color chipSurface = Color(0xFF22202A);

  /// Online indicator dot green (#2ECC71)
  static const Color online = Color(0xFF2ECC71);

  /// Dislike / Skip button background (white)
  static const Color dislikeBtnBg = Color(0xFFFFFFFF);

  /// Transparent color
  static const Color transparent = Colors.transparent;

  /// Card gradient dark overlay
  static const List<Color> cardGradient = [
    Colors.transparent,
    Color(0x80000000),
    Color(0xFF000000),
  ];
}
