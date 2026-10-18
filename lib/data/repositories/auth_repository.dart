import '../models/user_model.dart';

/// Abstract authentication repository contract allowing seamless backend replacement.
abstract class AuthRepository {
  Future<UserModel?> getCurrentUser();
  Future<UserModel> login({required String email, required String password});
  Future<UserModel> signup({
    required String name,
    required String email,
    required String password,
    String? dob,
    String? location,
  });
  Future<void> forgotPassword({required String email});
  Future<void> logout();
  Future<void> completeOnboarding();
  Future<void> updateUserProfile(UserModel updatedUser);
}

