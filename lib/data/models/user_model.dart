import 'music_model.dart';
import 'playlist_model.dart';
import 'artist_model.dart';
import 'genre_model.dart';
import 'activity_model.dart';
import 'dating_preference_model.dart';
import 'profile_photo_model.dart';
import 'media_connection_model.dart';
import 'favorite_show_model.dart';
import 'media_compatibility_model.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  final int age;
  final String location;
  final String imageUrl;
  final String bio;
  final int musicSimilarity; // e.g. 85 for 85%
  final bool isOnline;
  final MusicModel? currentSong;
  final List<ArtistModel> favoriteArtists;
  final List<GenreModel> favoriteGenres;
  final List<ActivityModel> activities;
  final List<PlaylistModel> myPlaylists;
  final List<PlaylistModel> otherPlaylists;
  final List<MusicModel> recentTracks;
  final bool isFollowing;
  final bool isAuthenticated;
  final bool isOnboarded;

  // New Dating & Media matching extensions
  final List<ProfilePhotoModel> photos;
  final DatingPreferenceModel? datingPreferences;
  final List<MediaConnectionModel> mediaConnections;
  final List<FavoriteShowModel> favoriteShows;
  final List<MusicModel> topTracks;
  final MediaCompatibilityModel? compatibility;

  const UserModel({
    required this.id,
    required this.name,
    this.email = '',
    required this.age,
    required this.location,
    required this.imageUrl,
    required this.bio,
    required this.musicSimilarity,
    this.isOnline = true,
    this.currentSong,
    this.favoriteArtists = const [],
    this.favoriteGenres = const [],
    this.activities = const [],
    this.myPlaylists = const [],
    this.otherPlaylists = const [],
    this.recentTracks = const [],
    this.isFollowing = false,
    this.isAuthenticated = false,
    this.isOnboarded = false,
    this.photos = const [],
    this.datingPreferences,
    this.mediaConnections = const [],
    this.favoriteShows = const [],
    this.topTracks = const [],
    this.compatibility,
  });

  /// Helper getter ensuring at least the primary imageUrl is returned if photos list is empty.
  List<ProfilePhotoModel> get displayPhotos {
    if (photos.isNotEmpty) return photos;
    if (imageUrl.isNotEmpty) {
      return [
        ProfilePhotoModel(
          id: 'p_${id}_main',
          url: imageUrl,
          isPrimary: true,
          order: 0,
        ),
      ];
    }
    return const [];
  }

  /// Top 5 frequently listened songs sorted descending by playback count / priority.
  List<MusicModel> get displayTopTracks {
    if (topTracks.isNotEmpty) {
      return topTracks.take(5).toList();
    }
    if (recentTracks.isNotEmpty) {
      return recentTracks.take(5).toList();
    }
    return const [];
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    int? age,
    String? location,
    String? imageUrl,
    String? bio,
    int? musicSimilarity,
    bool? isOnline,
    MusicModel? currentSong,
    List<ArtistModel>? favoriteArtists,
    List<GenreModel>? favoriteGenres,
    List<ActivityModel>? activities,
    List<PlaylistModel>? myPlaylists,
    List<PlaylistModel>? otherPlaylists,
    List<MusicModel>? recentTracks,
    bool? isFollowing,
    bool? isAuthenticated,
    bool? isOnboarded,
    List<ProfilePhotoModel>? photos,
    DatingPreferenceModel? datingPreferences,
    List<MediaConnectionModel>? mediaConnections,
    List<FavoriteShowModel>? favoriteShows,
    List<MusicModel>? topTracks,
    MediaCompatibilityModel? compatibility,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      age: age ?? this.age,
      location: location ?? this.location,
      imageUrl: imageUrl ?? this.imageUrl,
      bio: bio ?? this.bio,
      musicSimilarity: musicSimilarity ?? this.musicSimilarity,
      isOnline: isOnline ?? this.isOnline,
      currentSong: currentSong ?? this.currentSong,
      favoriteArtists: favoriteArtists ?? this.favoriteArtists,
      favoriteGenres: favoriteGenres ?? this.favoriteGenres,
      activities: activities ?? this.activities,
      myPlaylists: myPlaylists ?? this.myPlaylists,
      otherPlaylists: otherPlaylists ?? this.otherPlaylists,
      recentTracks: recentTracks ?? this.recentTracks,
      isFollowing: isFollowing ?? this.isFollowing,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      isOnboarded: isOnboarded ?? this.isOnboarded,
      photos: photos ?? this.photos,
      datingPreferences: datingPreferences ?? this.datingPreferences,
      mediaConnections: mediaConnections ?? this.mediaConnections,
      favoriteShows: favoriteShows ?? this.favoriteShows,
      topTracks: topTracks ?? this.topTracks,
      compatibility: compatibility ?? this.compatibility,
    );
  }
}

