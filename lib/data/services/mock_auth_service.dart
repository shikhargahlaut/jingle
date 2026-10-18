import '../models/user_model.dart';
import '../mock/mock_data.dart';
import '../repositories/auth_repository.dart';

/// Concrete mock authentication service with in-memory session persistence.
class MockAuthService implements AuthRepository {
  UserModel? _currentUser;

  @override
  Future<UserModel?> getCurrentUser() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _currentUser;
  }

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(milliseconds: 1000));

    if (email.trim().toLowerCase() == 'priya@jingle.com' ||
        email.trim().toLowerCase() == 'john@jingle.com') {
      _currentUser = MockData.userPriya.copyWith(
        email: email.trim(),
        isAuthenticated: true,
        isOnboarded: true,
      );
      return _currentUser!;
    }

    // Default mock user for any valid login attempt
    _currentUser = UserModel(
      id: 'mock_u_${DateTime.now().millisecondsSinceEpoch}',
      name: email.split('@').first.capitalize(),
      email: email.trim(),
      age: 24,
      location: 'New York, USA',
      imageUrl: MockData.imgPriya,
      bio: 'Lover of indie beats, acoustic vibes, and soundscapes.',
      musicSimilarity: 88,
      isAuthenticated: true,
      isOnboarded: false, // Triggers onboarding flow
    );

    return _currentUser!;
  }

  @override
  Future<UserModel> signup({
    required String name,
    required String email,
    required String password,
    String? dob,
    String? location,
  }) async {
    await Future.delayed(const Duration(milliseconds: 1000));

    _currentUser = UserModel(
      id: 'mock_u_${DateTime.now().millisecondsSinceEpoch}',
      name: name.trim(),
      email: email.trim(),
      age: 23,
      location: location?.trim().isNotEmpty == true
          ? location!.trim()
          : 'San Francisco, USA',
      imageUrl: MockData.imgJohnJacobs,
      bio: 'New music explorer ready to find my vibe team!',
      musicSimilarity: 85,
      isAuthenticated: true,
      isOnboarded: false, // New signup requires Interests onboarding
    );

    return _currentUser!;
  }

  @override
  Future<void> forgotPassword({required String email}) async {
    await Future.delayed(const Duration(milliseconds: 800));
  }

  @override
  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 300));
    _currentUser = null;
  }

  @override
  Future<void> completeOnboarding() async {
    if (_currentUser != null) {
      _currentUser = _currentUser!.copyWith(isOnboarded: true);
    }
  }

  @override
  Future<void> updateUserProfile(UserModel updatedUser) async {
    await Future.delayed(const Duration(milliseconds: 150));
    _currentUser = updatedUser;
  }
}

extension StringExtension on String {
  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}
