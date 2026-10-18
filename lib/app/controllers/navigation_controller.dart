import 'package:get/get.dart';

/// Controller managing active tab index for AppBottomNavigation.
class NavigationController extends GetxController {
  final RxInt currentIndex = 0.obs;

  void changeTab(int index) {
    currentIndex.value = index;
  }
}
