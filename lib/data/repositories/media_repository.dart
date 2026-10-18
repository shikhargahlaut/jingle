import '../models/media_connection_model.dart';
import '../models/music_model.dart';
import '../models/favorite_show_model.dart';

/// Abstract repository for media provider integrations, top listening tracks, and favorite shows.
abstract class MediaRepository {
  /// Fetches the user's connected media and social accounts.
  Future<List<MediaConnectionModel>> getMediaConnections();

  /// Initiates a connection request to an external media provider.
  /// Returns the updated connection state without faking authentication tokens.
  Future<MediaConnectionModel> connectPlatform(MediaPlatform platform);

  /// Disconnects a connected external media provider.
  Future<void> disconnectPlatform(MediaPlatform platform);

  /// Fetches the user's top frequently listened tracks sorted in descending order (Top 5).
  Future<List<MusicModel>> getTopListeningTracks({int limit = 5});

  /// Fetches the user's favorite shows and movies.
  Future<List<FavoriteShowModel>> getFavoriteShows();
}
