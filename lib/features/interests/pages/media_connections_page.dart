import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/neon_button.dart';
import '../../../core/widgets/media_connection_tile.dart';
import '../../../data/models/media_connection_model.dart';
import '../../profile/controllers/dating_profile_controller.dart';

/// Media & Social Accounts onboarding and management screen.
class MediaConnectionsPage extends GetView<DatingProfileController> {
  final bool isEditMode;

  const MediaConnectionsPage({
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
          isEditMode ? 'Manage Media Services' : 'Media Connections',
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
                      'Connect Your Sound',
                      style: AppTextStyles.display.copyWith(fontSize: 22),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Link your streaming & social accounts to generate deep music & show compatibility with your matches.',
                      style: AppTextStyles.subtitle,
                    ),
                    const SizedBox(height: 16),

                    // Information Note Banner
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.primary.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.info_outline,
                            color: AppColors.primary,
                            size: 20,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Your listening history & top shows will help calculate compatibility percentages.',
                              style: AppTextStyles.caption.copyWith(
                                color: AppColors.white,
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Supported Media Services
                    Text(
                      'Music & Streaming Providers',
                      style: AppTextStyles.sectionTitle.copyWith(fontSize: 15),
                    ),
                    const SizedBox(height: 12),

                    Obx(() {
                      final connections = controller.mediaConnections;

                      return Column(
                        children: MediaPlatform.values.map((platform) {
                          final conn = connections.firstWhere(
                            (c) => c.platform == platform,
                            orElse: () => MediaConnectionModel(
                              platform: platform,
                              status: ConnectionStatus.disconnected,
                            ),
                          );
                          final isConnecting =
                              controller.connectingPlatform.value == platform.name;

                          return MediaConnectionTile(
                            connection: conn,
                            isLoading: isConnecting,
                            onToggleConnect: () =>
                                controller.toggleMediaConnection(platform),
                          );
                        }).toList(),
                      );
                    }),

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
                text: isEditMode ? 'Done' : 'Complete Onboarding',
                backgroundColor: AppColors.primary,
                textColor: Colors.black,
                onPressed: () {
                  if (isEditMode) {
                    Get.back();
                  } else {
                    controller.saveAndCompleteOnboarding();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
