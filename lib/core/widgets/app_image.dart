import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../theme/app_colors.dart';

/// Robust image loader widget handling network URLs, local device files, local assets, and fallbacks cleanly.
class AppImage extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final Widget? errorWidget;

  const AppImage({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    Widget imageWidget;

    if (url.isEmpty) {
      imageWidget = _defaultErrorPlaceholder();
    } else if (url.startsWith('http')) {
      imageWidget = CachedNetworkImage(
        imageUrl: url,
        width: width,
        height: height,
        fit: fit,
        placeholder: (context, url) => Container(
          width: width,
          height: height,
          color: AppColors.cardSurface,
          child: const Center(
            child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: AppColors.primary,
              ),
            ),
          ),
        ),
        errorWidget: (context, url, error) =>
            errorWidget ?? _defaultErrorPlaceholder(),
      );
    } else if (url.startsWith('/') ||
        url.startsWith('file:') ||
        RegExp(r'^[a-zA-Z]:[\\/]').hasMatch(url)) {
      final cleanPath = url.startsWith('file://') ? url.replaceFirst('file://', '') : url;
      imageWidget = Image.file(
        File(cleanPath),
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) =>
            errorWidget ?? _defaultErrorPlaceholder(),
      );
    } else {
      imageWidget = Image.asset(
        url,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) =>
            errorWidget ?? _defaultErrorPlaceholder(),
      );
    }

    if (borderRadius != null) {
      return ClipRRect(
        borderRadius: borderRadius!,
        child: imageWidget,
      );
    }

    return imageWidget;
  }

  Widget _defaultErrorPlaceholder() {
    return Container(
      width: width,
      height: height,
      color: AppColors.cardSurface,
      child: const Icon(
        Icons.music_note,
        color: AppColors.secondaryText,
        size: 24,
      ),
    );
  }
}
