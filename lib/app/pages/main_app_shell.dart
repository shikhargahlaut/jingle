import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/app_bottom_navigation.dart';
import '../controllers/navigation_controller.dart';
import '../../features/home/pages/home_page.dart';
import '../../features/swipe/pages/swipe_page.dart';
import '../../features/profile/pages/profile_page.dart';

/// Root shell widget hosting Feed, Swipe, and Profile under AppBottomNavigation.
class MainAppShell extends StatelessWidget {
  const MainAppShell({super.key});

  @override
  Widget build(BuildContext context) {
    final navCtrl = Get.find<NavigationController>();

    final pages = const [
      HomePage(),
      SwipePage(),
      ProfilePage(),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Obx(
        () => IndexedStack(
          index: navCtrl.currentIndex.value,
          children: pages,
        ),
      ),
      bottomNavigationBar: Obx(
        () => AppBottomNavigation(
          currentIndex: navCtrl.currentIndex.value,
          onTap: (index) => navCtrl.changeTab(index),
        ),
      ),
    );
  }
}
