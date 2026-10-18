import 'package:flutter/material.dart';
import '../../data/models/profile_photo_model.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import 'app_image.dart';

/// Tinder-style interactive photo grid allowing real phone gallery/camera selection,
/// deletion, and primary cover photo setting for up to 6 photos.
class PhotoGridPicker extends StatelessWidget {
  final List<ProfilePhotoModel> photos;
  final VoidCallback onPickFromGallery;
  final VoidCallback onPickFromCamera;
  final Function(String photoId) onRemovePhoto;
  final Function(String photoId)? onSetPrimary;
  final int maxPhotos;

  const PhotoGridPicker({
    super.key,
    required this.photos,
    required this.onPickFromGallery,
    required this.onPickFromCamera,
    required this.onRemovePhoto,
    this.onSetPrimary,
    this.maxPhotos = 6,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Add Your Photos',
              style: AppTextStyles.sectionTitle.copyWith(fontSize: 16),
            ),
            Text(
              '${photos.length}/$maxPhotos added',
              style: AppTextStyles.caption.copyWith(
                color: photos.length >= maxPhotos
                    ? AppColors.primary
                    : AppColors.secondaryText,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          'Add up to 6 photos from your phone gallery. Tap to set your main cover photo.',
          style: AppTextStyles.subtitle.copyWith(fontSize: 12),
        ),
        const SizedBox(height: 14),

        // Tinder-style 3x2 Grid
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.78,
          ),
          itemCount: maxPhotos,
          itemBuilder: (context, index) {
            if (index < photos.length) {
              final photo = photos[index];
              return _buildPhotoCard(context, photo, index);
            } else {
              return _buildEmptySlot(context, index);
            }
          },
        ),
      ],
    );
  }

  Widget _buildPhotoCard(
    BuildContext context,
    ProfilePhotoModel photo,
    int index,
  ) {
    final isMain = photo.isPrimary || index == 0;

    return GestureDetector(
      onTap: () {
        if (onSetPrimary != null) {
          onSetPrimary!(photo.id);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isMain ? AppColors.primary : AppColors.border,
            width: isMain ? 2.5 : 1,
          ),
          boxShadow: isMain
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.25),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            Positioned.fill(
              child: AppImage(url: photo.url, fit: BoxFit.cover),
            ),
            if (isMain)
              Positioned(
                bottom: 6,
                left: 6,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'COVER',
                    style: AppTextStyles.caption.copyWith(
                      color: Colors.black,
                      fontSize: 8,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
            Positioned(
              top: 6,
              right: 6,
              child: GestureDetector(
                onTap: () => onRemovePhoto(photo.id),
                child: Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.75),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white24, width: 0.5),
                  ),
                  child: const Icon(Icons.close, size: 14, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptySlot(BuildContext context, int index) {
    final canAdd = photos.length < maxPhotos;

    return GestureDetector(
      onTap: canAdd ? () => _showPhotoSourceBottomSheet(context) : null,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.divider, width: 1.5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 34,
              height: 34,
              decoration: const BoxDecoration(
                color: AppColors.chipSurface,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.add, size: 20, color: AppColors.primary),
            ),
            const SizedBox(height: 6),
            Text(
              'Slot ${index + 1}',
              style: AppTextStyles.caption.copyWith(
                color: AppColors.secondaryText,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showPhotoSourceBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (bottomSheetContext) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Add Profile Photos',
                    style: AppTextStyles.heading.copyWith(fontSize: 18),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: AppColors.secondaryText,
                    ),
                    onPressed: () => Navigator.pop(bottomSheetContext),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                'Select photos from your device gallery or capture with camera (max $maxPhotos photos).',
                style: AppTextStyles.subtitle.copyWith(fontSize: 12),
              ),
              const SizedBox(height: 20),

              // Gallery Option
              _buildSourceTile(
                icon: Icons.photo_library_outlined,
                title: 'Choose from Gallery',
                subtitle: 'Select one or multiple photos from phone',
                onTap: () {
                  Navigator.pop(bottomSheetContext);
                  onPickFromGallery();
                },
              ),
              const SizedBox(height: 12),

              // Camera Option
              _buildSourceTile(
                icon: Icons.camera_alt_outlined,
                title: 'Take Photo with Camera',
                subtitle: 'Capture a fresh photo now',
                onTap: () {
                  Navigator.pop(bottomSheetContext);
                  onPickFromCamera();
                },
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSourceTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.cardSurface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.divider),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: AppColors.primary, size: 22),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.body.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.secondaryText,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: AppColors.secondaryText,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
