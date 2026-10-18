import 'package:get/get.dart';
import '../../../data/mock/mock_data.dart';
import '../../../data/models/user_model.dart';
import '../../../data/models/music_model.dart';
import '../../../data/models/playlist_model.dart';
import '../../../data/models/genre_model.dart';
import '../../../data/models/mood_model.dart';

/// GetX controller managing Feed screen state and actions.
class HomeController extends GetxController {
  final RxList<MusicModel> recentlyPlayed = <MusicModel>[].obs;
  final RxList<UserModel> peopleYouMayKnow = <UserModel>[].obs;
  final RxList<PlaylistModel> topPlaylists = <PlaylistModel>[].obs;
  final RxList<UserModel> topProfileCharts = <UserModel>[].obs;
  final RxList<GenreModel> genres = <GenreModel>[].obs;
  final RxList<MoodModel> moods = <MoodModel>[].obs;
  final RxList<UserModel> currentlyListening = <UserModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadFeedData();
  }

  void loadFeedData() {
    recentlyPlayed.assignAll([
      MockData.trackWallOfEyes,
      MockData.trackAlchemical,
      MockData.trackHozier,
    ]);

    peopleYouMayKnow.assignAll([
      MockData.userRoma,
      MockData.userPanorama,
      MockData.userPriya,
    ]);

    topPlaylists.assignAll([
      MockData.playlistIcarosModel,
      MockData.playlistManAtWorkModel,
      MockData.playlistSkateRollsModel,
    ]);

    topProfileCharts.assignAll([
      MockData.userRoma,
      MockData.userRoma,
      MockData.userRoma,
      MockData.userRoma,
    ]);

    genres.assignAll(MockData.genres.take(6).toList());
    moods.assignAll(MockData.moods.take(6).toList());

    currentlyListening.assignAll([
      MockData.userPriya,
      MockData.userPriya,
      MockData.userPriya,
      MockData.userPriya,
      MockData.userPriya,
      MockData.userPriya,
      MockData.userPriya,
      MockData.userPriya,
      MockData.userPriya,
    ]);
  }

  void toggleFollowUser(String userId) {
    final index = peopleYouMayKnow.indexWhere((u) => u.id == userId);
    if (index != -1) {
      final user = peopleYouMayKnow[index];
      peopleYouMayKnow[index] = user.copyWith(isFollowing: !user.isFollowing);
    }
  }
}
