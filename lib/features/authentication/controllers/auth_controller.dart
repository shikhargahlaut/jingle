import 'package:get/get.dart';
import '../../../data/models/user_model.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../data/services/mock_auth_service.dart';
import '../../../app/routes/app_routes.dart';

/// GetX controller managing global authentication session and user state.
class AuthController extends GetxController {
  final AuthRepository _authRepository = Get.put<AuthRepository>(
    MockAuthService(),
    permanent: true,
  );

  final Rxn<UserModel> currentUser = Rxn<UserModel>();
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  bool get isAuthenticated => currentUser.value?.isAuthenticated ?? false;
  bool get isOnboarded => currentUser.value?.isOnboarded ?? false;

  String getInitialRoute() {
    if (!isAuthenticated) {
      return AppRoutes.login;
    }
    if (!isOnboarded) {
      return AppRoutes.interests;
    }
    return AppRoutes.mainApp;
  }

  Future<void> login(String email, String password) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final user = await _authRepository.login(
        email: email,
        password: password,
      );
      currentUser.value = user;

      if (user.isOnboarded) {
        Get.offAllNamed(AppRoutes.mainApp);
      } else {
        Get.offAllNamed(AppRoutes.interests);
      }
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar(
        'Login Failed',
        'Invalid email or password. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signup({
    required String name,
    required String email,
    required String password,
    String? dob,
    String? location,
  }) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final user = await _authRepository.signup(
        name: name,
        email: email,
        password: password,
        dob: dob,
        location: location,
      );
      currentUser.value = user;

      Get.offAllNamed(AppRoutes.interests);
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar(
        'Signup Failed',
        'Could not create account. Please check your information.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> forgotPassword(String email) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      await _authRepository.forgotPassword(email: email);
      return true;
    } catch (e) {
      errorMessage.value = e.toString();
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> completeOnboarding() async {
    await _authRepository.completeOnboarding();
    if (currentUser.value != null) {
      currentUser.value = currentUser.value!.copyWith(isOnboarded: true);
    }
  }

  Future<void> updateUserProfile(UserModel updatedUser) async {
    await _authRepository.updateUserProfile(updatedUser);
    currentUser.value = updatedUser;
  }

  Future<void> logout() async {
    try {
      isLoading.value = true;
      await _authRepository.logout();
      currentUser.value = null;
      Get.offAllNamed(AppRoutes.login);
    } finally {
      isLoading.value = false;
    }
  }
}
