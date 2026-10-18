import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/section_title.dart';
import '../../../core/widgets/music_card.dart';
import '../../../core/widgets/profile_card.dart';
import '../../../core/widgets/playlist_card.dart';
import '../../../core/widgets/chart_card.dart';
import '../../../core/widgets/mood_card.dart';
import '../../../core/widgets/listening_card.dart';
import '../controllers/home_controller.dart';

/// Feed Screen faithfully reproducing the reference design screenshot.
class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Good morning!',
              style: AppTextStyles.subtitle.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'Feed',
              style: AppTextStyles.heading.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w800,
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.search,
                    color: AppColors.white,
                    size: 22,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(
                    Icons.notifications_none,
                    color: AppColors.white,
                    size: 22,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.screenPaddingHorizontal,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Recently Played
            const SectionTitle(title: 'Recently Played'),
            SizedBox(
              height: 180,
              child: Obx(
                () => ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: controller.recentlyPlayed.length,
                  itemBuilder: (context, index) {
                    return MusicCard(track: controller.recentlyPlayed[index]);
                  },
                ),
              ),
            ),

            // 2. People You May Know
            SectionTitle(title: 'People you may know', onSeeAll: () {}),
            SizedBox(
              height: 190,
              child: Obx(
                () => ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: controller.peopleYouMayKnow.length,
                  itemBuilder: (context, index) {
                    final user = controller.peopleYouMayKnow[index];
                    return ProfileCard(
                      user: user,
                      onFollowTap: () => controller.toggleFollowUser(user.id),
                    );
                  },
                ),
              ),
            ),

            // 3. Top Playlist For You
            SectionTitle(title: 'Top playlist for you', onSeeAll: () {}),
            SizedBox(
              height: 220,
              child: Obx(
                () => ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: controller.topPlaylists.length,
                  itemBuilder: (context, index) {
                    return PlaylistCard(
                      playlist: controller.topPlaylists[index],
                    );
                  },
                ),
              ),
            ),

            // 4. Top Profile Charts
            SectionTitle(title: 'Top Profile charts', onSeeAll: () {}),
            Obx(
              () => Column(
                children: controller.topProfileCharts.map((user) {
                  return ChartCard(user: user);
                }).toList(),
              ),
            ),

            // 5. Genres
            SectionTitle(title: 'Genres', onSeeAll: () {}),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 3.2,
              ),
              itemCount: 6,
              itemBuilder: (context, index) {
                final names = [
                  'Classical',
                  'Classical',
                  'Hip- Hop',
                  'Hip- Hop',
                  'Electronic',
                  'Electronic',
                ];
                return Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF333238),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    names[index],
                    style: AppTextStyles.body.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                );
              },
            ),

            // 6. Moods
            SectionTitle(title: 'Moods', onSeeAll: () {}),
            SizedBox(
              height: 110,
              child: Obx(
                () => ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: controller.moods.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: MoodCard(mood: controller.moods[index]),
                    );
                  },
                ),
              ),
            ),

            // 7. Currently Listening To
            SectionTitle(title: 'Currently listening to', onSeeAll: () {}),
            Obx(
              () => GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.85,
                ),
                itemCount: controller.currentlyListening.length,
                itemBuilder: (context, index) {
                  return ListeningCard(
                    user: controller.currentlyListening[index],
                  );
                },
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
