import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/neon_button.dart';
import '../../../core/widgets/dating_badge_chip.dart';
import '../../../core/widgets/photo_grid_picker.dart';
import '../../../data/models/dating_preference_model.dart';
import '../../profile/controllers/dating_profile_controller.dart';

/// Dating Preferences, Photos (up to 6), and Bio setup screen.
class DatingProfileSetupPage extends GetView<DatingProfileController> {
  final bool isEditMode;

  const DatingProfileSetupPage({
    super.key,
    this.isEditMode = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.white),
          onPressed: () => Get.back(),
        ),
        title: Text(
          isEditMode ? 'Edit Dating Profile' : 'Dating Preferences',
          style: AppTextStyles.heading.copyWith(fontSize: 18),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.screenPaddingHorizontal,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isEditMode ? 'Your Profile & Vibe' : 'Match Preferences',
                      style: AppTextStyles.display.copyWith(fontSize: 22),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Tell us who you are and what you are looking for in the music dating scene.',
                      style: AppTextStyles.subtitle,
                    ),
                    const SizedBox(height: 20),

                    // 1. Gender / Identity Selection
                    Text(
                      'I Am A',
                      style: AppTextStyles.sectionTitle.copyWith(fontSize: 15),
                    ),
                    const SizedBox(height: 8),
                    Obx(
                      () => Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: GenderIdentity.values.map((gender) {
                          final isSelected =
                              controller.selectedGender.value == gender;
                          return DatingBadgeChip(
                            label: gender.label,
                            icon: _getGenderIcon(gender),
                            backgroundColor: isSelected
                                ? AppColors.primary
                                : AppColors.chipSurface,
                            textColor:
                                isSelected ? Colors.black : AppColors.white,
                            borderColor: isSelected
                                ? AppColors.primary
                                : AppColors.border,
                            onTap: () => controller.setGender(gender),
                          );
                        }).toList(),
                      ),
                    ),

                    const Divider(color: AppColors.divider, height: 28),

                    // 2. Looking For Selection
                    Text(
                      'Looking For',
                      style: AppTextStyles.sectionTitle.copyWith(fontSize: 15),
                    ),
                    const SizedBox(height: 8),
                    Obx(
                      () => Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: LookingFor.values.map((lookingFor) {
                          final isSelected =
                              controller.selectedLookingFor.value == lookingFor;
                          return DatingBadgeChip(
                            label: lookingFor.label,
                            icon: Icons.favorite,
                            backgroundColor: isSelected
                                ? AppColors.primary
                                : AppColors.chipSurface,
                            textColor:
                                isSelected ? Colors.black : AppColors.white,
                            borderColor: isSelected
                                ? AppColors.primary
                                : AppColors.border,
                            onTap: () => controller.setLookingFor(lookingFor),
                          );
                        }).toList(),
                      ),
                    ),

                    const Divider(color: AppColors.divider, height: 28),

                    // 3. Relationship Status
                    Text(
                      'Relationship Status',
                      style: AppTextStyles.sectionTitle.copyWith(fontSize: 15),
                    ),
                    const SizedBox(height: 8),
                    Obx(
                      () => Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: RelationshipStatus.values.map((status) {
                          final isSelected =
                              controller.selectedStatus.value == status;
                          return DatingBadgeChip(
                            label: status.label,
                            icon: Icons.circle_outlined,
                            backgroundColor: isSelected
                                ? AppColors.primary
                                : AppColors.chipSurface,
                            textColor:
                                isSelected ? Colors.black : AppColors.white,
                            borderColor: isSelected
                                ? AppColors.primary
                                : AppColors.border,
                            onTap: () => controller.setStatus(status),
                          );
                        }).toList(),
                      ),
                    ),

                    const Divider(color: AppColors.divider, height: 28),

                    // 4. Relationship Intent
                    Text(
                      'Relationship Intent',
                      style: AppTextStyles.sectionTitle.copyWith(fontSize: 15),
                    ),
                    const SizedBox(height: 8),
                    Obx(
                      () => Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: RelationshipIntent.values.map((intent) {
                          final isSelected =
                              controller.selectedIntent.value == intent;
                          return DatingBadgeChip(
                            label: intent.label,
                            icon: Icons.explore_outlined,
                            backgroundColor: isSelected
                                ? AppColors.primary
                                : AppColors.chipSurface,
                            textColor:
                                isSelected ? Colors.black : AppColors.white,
                            borderColor: isSelected
                                ? AppColors.primary
                                : AppColors.border,
                            onTap: () => controller.setIntent(intent),
                          );
                        }).toList(),
                      ),
                    ),

                    const Divider(color: AppColors.divider, height: 28),

                    // 5. Photos Management (Up to 6 photos from phone gallery)
                    Obx(
                      () => PhotoGridPicker(
                        photos: controller.photos.toList(),
                        maxPhotos: DatingProfileController.maxPhotosAllowed,
                        onPickFromGallery: () =>
                            controller.pickPhotosFromGallery(),
                        onPickFromCamera: () =>
                            controller.pickPhotoFromCamera(),
                        onRemovePhoto: (id) => controller.removePhoto(id),
                        onSetPrimary: (id) => controller.setPrimaryPhoto(id),
                      ),
                    ),

                    const Divider(color: AppColors.divider, height: 28),

                    // 6. Bio / About Me
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Bio / About Me',
                          style: AppTextStyles.sectionTitle.copyWith(fontSize: 15),
                        ),
                        Obx(
                          () => Text(
                            '${controller.bioCharCount.value}/${DatingProfileController.maxBioLength}',
                            style: AppTextStyles.caption.copyWith(
                              color: controller.bioCharCount.value >
                                      DatingProfileController.maxBioLength
                                  ? const Color(0xFFFF5252)
                                  : AppColors.secondaryText,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: controller.bioTextController,
                      maxLines: 4,
                      maxLength: DatingProfileController.maxBioLength,
                      style: AppTextStyles.body,
                      decoration: InputDecoration(
                        hintText:
                            'Share your music taste, favorite festivals, soundscapes, or what makes you tick...',
                        hintStyle: AppTextStyles.bodySecondary.copyWith(
                          color: AppColors.secondaryText.withValues(alpha: 0.6),
                        ),
                        counterText: '',
                        filled: true,
                        fillColor: AppColors.surface,
                        contentPadding: const EdgeInsets.all(14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: AppColors.border),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: AppColors.primary,
                            width: 1.5,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),

            // Bottom CTA Bar
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: const BoxDecoration(
                color: AppColors.surface,
                border: Border(top: BorderSide(color: AppColors.divider)),
              ),
              child: NeonButton(
                width: double.infinity,
                height: 48,
                text: isEditMode
                    ? 'Save Changes'
                    : 'Continue to Media Connections',
                backgroundColor: AppColors.primary,
                textColor: Colors.black,
                onPressed: () {
                  if (isEditMode) {
                    controller.saveProfileAndReturn();
                  } else {
                    controller.saveAndProceedToMedia();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getGenderIcon(GenderIdentity gender) {
    switch (gender) {
      case GenderIdentity.man:
        return Icons.male;
      case GenderIdentity.woman:
        return Icons.female;
      case GenderIdentity.other:
        return Icons.transgender;
    }
  }
}
