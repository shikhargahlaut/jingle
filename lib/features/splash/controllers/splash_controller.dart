import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import '../../authentication/controllers/auth_controller.dart';

/// GetX controller managing splash screen animation and initial navigation check.
class SplashController extends GetxController with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> scaleAnimation;
  late Animation<double> fadeAnimation;

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    scaleAnimation = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeOutBack,
      ),
    );

    fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeIn,
      ),
    );

    animationController.forward().then((_) {
      _checkAuthAndNavigate();
    });
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }

  void _checkAuthAndNavigate() async {
    await Future.delayed(const Duration(milliseconds: 600));

    if (Get.isRegistered<AuthController>()) {
      final authCtrl = Get.find<AuthController>();
      final nextRoute = authCtrl.getInitialRoute();
      Get.offAllNamed(nextRoute);
    } else {
      Get.offAllNamed('/login');
    }
  }
}
