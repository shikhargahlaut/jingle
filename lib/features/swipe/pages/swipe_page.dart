import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../app/routes/app_routes.dart';
import '../controllers/swipe_controller.dart';
import '../widgets/swipe_profile_card.dart';

/// Swipe Discovery Screen matching reference screenshot design & card animations.
class SwipePage extends GetView<SwipeController> {
  const SwipePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border, color: AppColors.white, size: 24),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.chat_bubble_outline,
                color: AppColors.white, size: 24),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.screenPaddingHorizontal,
          ),
          child: Column(
            children: [
              // Swipe Card Area
              Expanded(
                child: Obx(() {
                  final user = controller.currentProfile;

                  if (user == null) {
                    return const Center(
                      child: Text(
                        'No more profiles around you!',
                        style: TextStyle(color: AppColors.secondaryText),
                      ),
                    );
                  }

                  return AnimatedBuilder(
                    animation: controller.animationController,
                    builder: (context, child) {
                      final slideOffset = controller.slideAnimation.value;
                      final rotate = controller.rotateAnimation.value;

                      return Transform.translate(
                        offset: Offset(
                          slideOffset.dx * MediaQuery.of(context).size.width,
                          slideOffset.dy * MediaQuery.of(context).size.height,
                        ),
                        child: Transform.rotate(
                          angle: rotate,
                          child: GestureDetector(
                            onPanUpdate: (details) {
                              if (details.delta.dx < -10) {
                                controller.swipeLeft();
                              } else if (details.delta.dx > 10) {
                                controller.swipeRight();
                              }
                            },
                            child: SwipeProfileCard(
                              user: user,
                              onFollowTap: () =>
                                  controller.toggleFollowCurrentProfile(),
                              onTap: () => Get.toNamed(
                                AppRoutes.swipeProfileDetail,
                                arguments: user,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),

              const SizedBox(height: 20),

              // Bottom Control Buttons (X and Heart)
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.border, width: 0.5),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // X Skip Button (White)
                    Expanded(
                      child: GestureDetector(
                        onTap: () => controller.swipeLeft(),
                        child: Container(
                          height: 54,
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Icon(
                            Icons.close,
                            size: 28,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Heart Like Button (Neon Green)
                    Expanded(
                      child: GestureDetector(
                        onTap: () => controller.swipeRight(),
                        child: Container(
                          height: 54,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Icon(
                            Icons.favorite_border,
                            size: 28,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
