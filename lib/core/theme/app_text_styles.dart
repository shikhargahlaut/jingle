import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Centralized text styles using Manrope font family.
abstract class AppTextStyles {
  /// Display style for major screen headings
  static TextStyle display = GoogleFonts.manrope(
    fontSize: 24,
    fontWeight: FontWeight.w800,
    color: AppColors.white,
    letterSpacing: -0.5,
  );

  /// Heading style for card titles and section headers
  static TextStyle heading = GoogleFonts.manrope(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
  );

  /// Section title
  static TextStyle sectionTitle = GoogleFonts.manrope(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
  );

  /// Subtitle / description text
  static TextStyle subtitle = GoogleFonts.manrope(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.secondaryText,
  );

  /// Primary body text
  static TextStyle body = GoogleFonts.manrope(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.white,
  );

  /// Secondary body text
  static TextStyle bodySecondary = GoogleFonts.manrope(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.secondaryText,
  );

  /// Caption text / small metadata
  static TextStyle caption = GoogleFonts.manrope(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: AppColors.secondaryText,
  );

  /// Button CTA text style
  static TextStyle button = GoogleFonts.manrope(
    fontSize: 14,
    fontWeight: FontWeight.w800,
    color: Colors.black,
  );

  /// Chip label style
  static TextStyle chip = GoogleFonts.manrope(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );

  /// Bottom Navigation label style
  static TextStyle navLabel = GoogleFonts.manrope(
    fontSize: 11,
    fontWeight: FontWeight.w600,
    color: AppColors.secondaryText,
  );
}
