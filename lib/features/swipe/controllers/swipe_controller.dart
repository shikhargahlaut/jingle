import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/mock/mock_data.dart';
import '../../../data/models/user_model.dart';

/// Controller managing card swipe stack, swipe animations, and user interactions.
class SwipeController extends GetxController with GetSingleTickerProviderStateMixin {
  final RxList<UserModel> userStack = <UserModel>[].obs;
  final RxInt currentIndex = 0.obs;

  late AnimationController animationController;
  late Animation<Offset> slideAnimation;
  late Animation<double> rotateAnimation;

  UserModel? get currentProfile =>
      currentIndex.value < userStack.length ? userStack[currentIndex.value] : null;

  @override
  void onInit() {
    super.onInit();
    userStack.assignAll(MockData.swipeUsers);

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    slideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeOut,
    ));

    rotateAnimation = Tween<double>(
      begin: 0.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeOut,
    ));
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }

  void swipeLeft() {
    if (currentProfile == null) return;
    slideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(-1.5, 0.2),
    ).animate(animationController);

    rotateAnimation = Tween<double>(
      begin: 0.0,
      end: -0.2,
    ).animate(animationController);

    animationController.forward().then((_) {
      animationController.reset();
      _nextCard();
    });
  }

  void swipeRight() {
    if (currentProfile == null) return;
    slideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(1.5, 0.2),
    ).animate(animationController);

    rotateAnimation = Tween<double>(
      begin: 0.0,
      end: 0.2,
    ).animate(animationController);

    animationController.forward().then((_) {
      animationController.reset();
      _nextCard();
    });
  }

  void toggleFollowCurrentProfile() {
    if (currentProfile != null) {
      final index = currentIndex.value;
      final user = userStack[index];
      userStack[index] = user.copyWith(isFollowing: !user.isFollowing);
    }
  }

  void _nextCard() {
    if (currentIndex.value < userStack.length - 1) {
      currentIndex.value++;
    } else {
      // Loop back or reset for continuous testing
      currentIndex.value = 0;
    }
  }
}
