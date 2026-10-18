import '../models/media_connection_model.dart';
import '../models/music_model.dart';
import '../models/favorite_show_model.dart';
import '../repositories/media_repository.dart';
import '../mock/mock_data.dart';

/// Concrete media service managing connections and media data pipelines.
class DefaultMediaService implements MediaRepository {
  final Map<MediaPlatform, MediaConnectionModel> _connections = {
    MediaPlatform.spotify: const MediaConnectionModel(
      platform: MediaPlatform.spotify,
      status: ConnectionStatus.disconnected,
    ),
    MediaPlatform.youtube: const MediaConnectionModel(
      platform: MediaPlatform.youtube,
      status: ConnectionStatus.disconnected,
    ),
    MediaPlatform.appleMusic: const MediaConnectionModel(
      platform: MediaPlatform.appleMusic,
      status: ConnectionStatus.disconnected,
    ),
    MediaPlatform.netflix: const MediaConnectionModel(
      platform: MediaPlatform.netflix,
      status: ConnectionStatus.disconnected,
    ),
    MediaPlatform.amazonPrime: const MediaConnectionModel(
      platform: MediaPlatform.amazonPrime,
      status: ConnectionStatus.disconnected,
    ),
    MediaPlatform.instagram: const MediaConnectionModel(
      platform: MediaPlatform.instagram,
      status: ConnectionStatus.disconnected,
    ),
  };

  @override
  Future<List<MediaConnectionModel>> getMediaConnections() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _connections.values.toList();
  }

  @override
  Future<MediaConnectionModel> connectPlatform(MediaPlatform platform) async {
    // Simulates an API call handshake without pretending fake OAuth access tokens
    await Future.delayed(const Duration(milliseconds: 400));
    final updated = MediaConnectionModel(
      platform: platform,
      status: ConnectionStatus.connected,
      accountUsername: '@user_${platform.name}',
      connectedAt: DateTime.now(),
    );
    _connections[platform] = updated;
    return updated;
  }

  @override
  Future<void> disconnectPlatform(MediaPlatform platform) async {
    await Future.delayed(const Duration(milliseconds: 200));
    _connections[platform] = MediaConnectionModel(
      platform: platform,
      status: ConnectionStatus.disconnected,
    );
  }

  @override
  Future<List<MusicModel>> getTopListeningTracks({int limit = 5}) async {
    await Future.delayed(const Duration(milliseconds: 100));
    // Data pipeline: Extract tracks -> calculate/sort descending by playback frequency -> take top limit
    final tracks = List<MusicModel>.from(MockData.topListeningTracks);
    tracks.sort((a, b) => _parsePlayCount(b.plays).compareTo(_parsePlayCount(a.plays)));
    return tracks.take(limit).toList();
  }

  @override
  Future<List<FavoriteShowModel>> getFavoriteShows() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return MockData.favoriteShows;
  }

  /// Helper to convert string play counts (e.g. '88.5k', '12.4k', '4.7') into comparable doubles.
  double _parsePlayCount(String plays) {
    try {
      final clean = plays.trim().toLowerCase();
      if (clean.endsWith('k')) {
        return (double.tryParse(clean.replaceAll('k', '')) ?? 0) * 1000;
      }
      if (clean.endsWith('m')) {
        return (double.tryParse(clean.replaceAll('m', '')) ?? 0) * 1000000;
      }
      return double.tryParse(clean) ?? 0;
    } catch (_) {
      return 0;
    }
  }
}
