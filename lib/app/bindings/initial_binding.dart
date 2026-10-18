import 'package:get/get.dart';
import '../controllers/navigation_controller.dart';
import '../../features/authentication/controllers/auth_controller.dart';
import '../../features/interests/controllers/interests_controller.dart';
import '../../features/home/controllers/home_controller.dart';
import '../../features/swipe/controllers/swipe_controller.dart';
import '../../features/profile/controllers/profile_controller.dart';
import '../../features/profile/controllers/dating_profile_controller.dart';

/// Initial global dependency injection binding.
class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AuthController>(AuthController(), permanent: true);
    Get.lazyPut<NavigationController>(() => NavigationController(), fenix: true);
    Get.lazyPut<InterestsController>(() => InterestsController(), fenix: true);
    Get.lazyPut<DatingProfileController>(() => DatingProfileController(), fenix: true);
    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
    Get.lazyPut<SwipeController>(() => SwipeController(), fenix: true);
    Get.lazyPut<ProfileController>(() => ProfileController(), fenix: true);
  }
}

