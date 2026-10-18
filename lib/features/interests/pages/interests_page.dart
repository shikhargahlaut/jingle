import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/interest_chip.dart';
import '../../../core/widgets/genre_chip.dart';
import '../../../core/widgets/mood_card.dart';
import '../../../core/widgets/neon_button.dart';
import '../controllers/interests_controller.dart';

/// Interests, Moods, and Genre selection onboarding screen matching screenshots.
class InterestsPage extends GetView<InterestsController> {
  const InterestsPage({super.key});

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
                      'Your Interests',
                      style: AppTextStyles.display.copyWith(fontSize: 22),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Pick minimum of 6 vibes that define you and find your people',
                      style: AppTextStyles.subtitle,
                    ),
                    const SizedBox(height: 20),

                    // Categories & Interest Chips
                    ...controller.categories.entries.map((entry) {
                      final category = entry.key;
                      final items = entry.value;

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              category,
                              style: AppTextStyles.sectionTitle.copyWith(
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Obx(
                              () => Wrap(
                                spacing: 8.0,
                                runSpacing: 10.0,
                                children: items.map((interest) {
                                  final isSelected = controller
                                      .selectedInterestIds
                                      .contains(interest.id);

                                  return InterestChip(
                                    title: interest.name,
                                    imageUrl: interest.imageUrl,
                                    isSelected: isSelected,
                                    onTap: () =>
                                        controller.toggleInterest(interest.id),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),

                    const Divider(color: AppColors.divider, height: 32),

                    // Select Moods Section
                    Text(
                      'Select Moods',
                      style: AppTextStyles.display.copyWith(fontSize: 20),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Pick minimum of 3 moods that define you',
                      style: AppTextStyles.subtitle,
                    ),
                    const SizedBox(height: 16),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 1.0,
                      ),
                      itemCount: controller.moods.length,
                      itemBuilder: (context, index) {
                        final mood = controller.moods[index];
                        return Obx(() {
                          final isSelected =
                              controller.selectedMoodIds.contains(mood.id);

                          return MoodCard(
                            mood: mood,
                            isSelected: isSelected,
                            onTap: () => controller.toggleMood(mood.id),
                          );
                        });
                      },
                    ),

                    const Divider(color: AppColors.divider, height: 32),

                    // Select Genre Section
                    Text(
                      'Select Genre',
                      style: AppTextStyles.display.copyWith(fontSize: 20),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Pick minimum of 3 genre that you listens to',
                      style: AppTextStyles.subtitle,
                    ),
                    const SizedBox(height: 16),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 2.8,
                      ),
                      itemCount: controller.genres.length,
                      itemBuilder: (context, index) {
                        final genre = controller.genres[index];
                        return Obx(() {
                          final isSelected =
                              controller.selectedGenreIds.contains(genre.id);

                          return GenreCard(
                            genre: genre,
                            isSelected: isSelected,
                            onTap: () => controller.toggleGenre(genre.id),
                          );
                        });
                      },
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
              child: Obx(
                () {
                  final count = controller.selectedInterestsCount;
                  final canContinue = controller.canContinue;

                    return NeonButton(
                      width: double.infinity,
                      height: 48,
                      text: canContinue
                          ? 'Continue to Dating Preferences ($count selected)'
                          : 'Select at least ${6 - count} more vibes',
                      backgroundColor: canContinue
                          ? AppColors.primary
                          : AppColors.cardSurface,
                      textColor:
                          canContinue ? Colors.black : AppColors.secondaryText,
                      onPressed: () => controller.proceedToDatingProfile(),
                    );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
