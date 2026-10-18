import 'package:get/get.dart';
import '../controllers/interests_controller.dart';
import '../../profile/controllers/dating_profile_controller.dart';

class InterestsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InterestsController>(() => InterestsController());
    Get.lazyPut<DatingProfileController>(() => DatingProfileController());
  }
}

