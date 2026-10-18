import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/mock/mock_data.dart';
import '../../../data/models/user_model.dart';
import '../../../data/models/music_model.dart';
import '../../../data/models/playlist_model.dart';
import '../../../data/models/artist_model.dart';
import '../../../data/models/genre_model.dart';
import '../../../data/models/favorite_show_model.dart';
import '../../../data/models/media_connection_model.dart';
import '../../authentication/controllers/auth_controller.dart';

/// GetX controller managing logged-in user profile statistics, dating preferences, and collections.
class ProfileController extends GetxController {
  final Rx<UserModel> currentUser = MockData.userPriya.obs;
  final RxList<MusicModel> frequentlyListening = <MusicModel>[].obs;
  final RxList<PlaylistModel> favoritePlaylists = <PlaylistModel>[].obs;
  final RxList<ArtistModel> favoriteArtists = <ArtistModel>[].obs;
  final RxList<GenreModel> favoriteGenres = <GenreModel>[].obs;
  final RxList<FavoriteShowModel> favoriteShows = <FavoriteShowModel>[].obs;
  final RxList<MediaConnectionModel> mediaConnections =
      <MediaConnectionModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadProfileData();
  }

  void loadProfileData() {
    if (Get.isRegistered<AuthController>()) {
      final authUser = Get.find<AuthController>().currentUser.value;
      if (authUser != null) {
        currentUser.value = authUser;
      }
    }

    frequentlyListening.assignAll(MockData.topListeningTracks.take(5).toList());

    favoritePlaylists.assignAll([
      MockData.playlistIcarosModel,
      MockData.playlistEdSheeranModel,
    ]);

    favoriteArtists.assignAll(MockData.artists);

    favoriteShows.assignAll(MockData.favoriteShows);

    mediaConnections.assignAll(currentUser.value.mediaConnections.isNotEmpty
        ? currentUser.value.mediaConnections
        : MockData.userPriya.mediaConnections);

    favoriteGenres.assignAll([
      const GenreModel(
        id: 'fg1',
        name: 'Classical',
        colors: [Color(0xFF333238), Color(0xFF201F26)],
      ),
      const GenreModel(
        id: 'fg2',
        name: 'Hip-Hop',
        colors: [Color(0xFF333238), Color(0xFF201F26)],
      ),
    ]);
  }
}
