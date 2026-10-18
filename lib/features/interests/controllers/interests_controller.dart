import 'package:get/get.dart';
import '../../../data/mock/mock_data.dart';
import '../../../data/models/interest_model.dart';
import '../../../data/models/genre_model.dart';
import '../../../data/models/mood_model.dart';
import '../../../app/routes/app_routes.dart';

/// GetX controller managing Interests, Moods, and Genre onboarding selections.
class InterestsController extends GetxController {
  // Selected IDs
  final RxSet<String> selectedInterestIds = <String>{}.obs;
  final RxSet<String> selectedMoodIds = <String>{}.obs;
  final RxSet<String> selectedGenreIds = <String>{}.obs;

  // Mock data accessors
  Map<String, List<InterestModel>> get categories => MockData.interestsByCategory;
  List<MoodModel> get moods => MockData.moods;
  List<GenreModel> get genres => MockData.genres;

  int get selectedInterestsCount => selectedInterestIds.length;
  bool get canContinue => selectedInterestsCount >= 6;

  void toggleInterest(String id) {
    if (selectedInterestIds.contains(id)) {
      selectedInterestIds.remove(id);
    } else {
      selectedInterestIds.add(id);
    }
  }

  void toggleMood(String id) {
    if (selectedMoodIds.contains(id)) {
      selectedMoodIds.remove(id);
    } else {
      selectedMoodIds.add(id);
    }
  }

  void toggleGenre(String id) {
    if (selectedGenreIds.contains(id)) {
      selectedGenreIds.remove(id);
    } else {
      selectedGenreIds.add(id);
    }
  }

  void proceedToDatingProfile() {
    if (canContinue) {
      Get.toNamed(AppRoutes.datingProfileSetup);
    } else {
      Get.snackbar(
        'Select more vibes',
        'Please select at least 6 interests to discover people with similar taste!',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}

