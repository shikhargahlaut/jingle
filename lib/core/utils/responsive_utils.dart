import 'package:flutter/material.dart';

/// Responsive design utility helpers for layout adaptation.
abstract class ResponsiveUtils {
  static bool isSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < 360;
  }

  static bool isMediumScreen(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= 360 && width < 600;
  }

  static bool isTabletScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= 600;
  }

  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  /// Calculates clamped horizontal padding
  static double horizontalPadding(BuildContext context) {
    final width = screenWidth(context);
    if (width > 600) return (width - 560) / 2;
    return 16.0;
  }
}
