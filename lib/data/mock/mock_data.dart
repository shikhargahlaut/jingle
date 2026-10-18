import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../models/music_model.dart';
import '../models/playlist_model.dart';
import '../models/artist_model.dart';
import '../models/genre_model.dart';
import '../models/mood_model.dart';
import '../models/interest_model.dart';
import '../models/activity_model.dart';
import '../models/dating_preference_model.dart';
import '../models/profile_photo_model.dart';
import '../models/media_connection_model.dart';
import '../models/favorite_show_model.dart';
import '../models/media_compatibility_model.dart';

/// Centralized realistic mock dataset matching all screens and reference screenshots.
class MockData {
  // High quality Unsplash profile images
  static const String imgJohnJacobs =
      'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&q=80&w=800';
  static const String imgPriya =
      'https://images.unsplash.com/photo-1517841905240-472988babdf9?auto=format&fit=crop&q=80&w=800';
  static const String imgRoma =
      'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&q=80&w=800';
  static const String imgPanorama =
      'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&q=80&w=800';
  static const String imgSameer =
      'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&q=80&w=800';

  // Sample Photo Library for User Photo Selection
  static const List<String> samplePhotoLibrary = [
    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&q=80&w=800',
    'https://images.unsplash.com/photo-1517841905240-472988babdf9?auto=format&fit=crop&q=80&w=800',
    'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&q=80&w=800',
    'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&q=80&w=800',
    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&q=80&w=800',
    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&q=80&w=800',
    'https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?auto=format&fit=crop&q=80&w=800',
    'https://images.unsplash.com/photo-1522075469751-3a6694fb2f61?auto=format&fit=crop&q=80&w=800',
  ];

  // Album & Playlist Artworks
  static const String albumWallOfEyes =
      'https://images.unsplash.com/photo-1614613535308-eb5fbd3d2c17?auto=format&fit=crop&q=80&w=600';
  static const String albumAlchemical =
      'https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?auto=format&fit=crop&q=80&w=600';
  static const String albumHozier =
      'https://images.unsplash.com/photo-1470225620780-dba8ba36b745?auto=format&fit=crop&q=80&w=600';
  static const String playlistIcaros =
      'https://images.unsplash.com/photo-1508700115892-45ecd05ae2ad?auto=format&fit=crop&q=80&w=600';
  static const String playlistManAtWork =
      'https://images.unsplash.com/photo-1492684223066-81342ee5ff30?auto=format&fit=crop&q=80&w=600';
  static const String playlistSkateRolls =
      'https://images.unsplash.com/photo-1520045892732-304bc3ac5d8e?auto=format&fit=crop&q=80&w=600';
  static const String playlistSkateGang =
      'https://images.unsplash.com/photo-1518609878373-06d740f60d8b?auto=format&fit=crop&q=80&w=600';
  static const String playlistEdSheeran =
      'https://images.unsplash.com/photo-1501386761578-eac5c94b800a?auto=format&fit=crop&q=80&w=600';
  static const String playlistIndianSummer =
      'https://images.unsplash.com/photo-1514525253161-7a46d19cd819?auto=format&fit=crop&q=80&w=600';

  // Artist Avatars
  static const String artistDiljit =
      'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?auto=format&fit=crop&q=80&w=600';
  static const String artistRihanna =
      'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&q=80&w=600';
  static const String artistDrake =
      'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&q=80&w=600';

  // Vector / Illustrative placeholders
  static const String iconCar =
      'https://api.iconify.design/emojione:automobile.svg';
  static const String iconHiking =
      'https://api.iconify.design/emojione:person-mountain-biking.svg';

  // Mock Tracks
  static const MusicModel trackWallOfEyes = MusicModel(
    id: 'm1',
    title: 'Wall of the eyes',
    artist: 'The Smile',
    albumArt: albumWallOfEyes,
    plays: '4.7k',
  );

  static const MusicModel trackAlchemical = MusicModel(
    id: 'm2',
    title: "DOVE CAMERON: 'ALCHEMICAL: VOL. 1'",
    artist: 'Dove Cameron',
    albumArt: albumAlchemical,
    plays: '12.4k',
    platform: 'spotify',
  );

  static const MusicModel trackHozier = MusicModel(
    id: 'm3',
    title: "HOZIER: 'UNREAL UNEARTH'",
    artist: 'Hozier',
    albumArt: albumHozier,
    plays: '8.9k',
    platform: 'spotify',
  );

  static const MusicModel trackWorkout = MusicModel(
    id: 'm4',
    title: 'During workout',
    artist: 'Roma',
    albumArt: imgRoma,
    plays: '9.5k',
    platform: 'youtube',
  );

  static const MusicModel trackStarboy = MusicModel(
    id: 'm5',
    title: 'Starboy',
    artist: 'The Weeknd',
    albumArt: 'https://images.unsplash.com/photo-1514525253161-7a46d19cd819?auto=format&fit=crop&q=80&w=600',
    plays: '34.2k',
    platform: 'spotify',
  );

  static const MusicModel trackLevitating = MusicModel(
    id: 'm6',
    title: 'Levitating',
    artist: 'Dua Lipa',
    albumArt: 'https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?auto=format&fit=crop&q=80&w=600',
    plays: '28.1k',
    platform: 'spotify',
  );

  // Top 5 Listening Tracks collection (sorted descending)
  static const List<MusicModel> topListeningTracks = [
    trackStarboy, // 34.2k
    trackLevitating, // 28.1k
    trackAlchemical, // 12.4k
    trackWorkout, // 9.5k
    trackHozier, // 8.9k
    trackWallOfEyes, // 4.7k
  ];

  // Mock Favorite Shows / Movies
  static const List<FavoriteShowModel> favoriteShows = [
    FavoriteShowModel(
      id: 'sh1',
      title: 'Stranger Things',
      posterUrl:
          'https://images.unsplash.com/photo-1536440136628-849c177e76a1?auto=format&fit=crop&q=80&w=600',
      platform: 'Netflix',
      genre: 'Sci-Fi / Horror',
      releaseYear: '2022',
    ),
    FavoriteShowModel(
      id: 'sh2',
      title: 'The Bear',
      posterUrl:
          'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?auto=format&fit=crop&q=80&w=600',
      platform: 'Amazon Prime',
      genre: 'Drama / Comedy',
      releaseYear: '2023',
    ),
    FavoriteShowModel(
      id: 'sh3',
      title: 'Breaking Bad',
      posterUrl:
          'https://images.unsplash.com/photo-1489599849927-2ee91cede3ba?auto=format&fit=crop&q=80&w=600',
      platform: 'Netflix',
      genre: 'Crime / Drama',
      releaseYear: '2013',
    ),
    FavoriteShowModel(
      id: 'sh4',
      title: 'Succession',
      posterUrl:
          'https://images.unsplash.com/photo-1470225620780-dba8ba36b745?auto=format&fit=crop&q=80&w=600',
      platform: 'Amazon Prime',
      genre: 'Drama',
      releaseYear: '2023',
    ),
  ];

  // Mock Playlists
  static const PlaylistModel playlistIcarosModel = PlaylistModel(
    id: 'p1',
    name: 'Icaros',
    ownerName: 'Sameer',
    ownerAvatar: imgSameer,
    coverUrl: playlistIcaros,
    description: 'Relax, Meditative, Peaceful, Travelling, Music, Photography',
    playsCount: '5.1k',
    likesCount: '1.2k',
    commentsCount: '180',
    songCount: 24,
  );

  static const PlaylistModel playlistManAtWorkModel = PlaylistModel(
    id: 'p2',
    name: 'Man at work',
    ownerName: 'John Jacobs',
    ownerAvatar: imgJohnJacobs,
    coverUrl: playlistManAtWork,
    description: 'Deep focus electronic beats for late night coding',
    playsCount: '5.1k',
    likesCount: '1.5k',
    commentsCount: '304',
    songCount: 18,
  );

  static const PlaylistModel playlistSkateRollsModel = PlaylistModel(
    id: 'p3',
    name: 'Skate rolls',
    ownerName: 'John Jacobs',
    ownerAvatar: imgJohnJacobs,
    coverUrl: playlistSkateRolls,
    description: 'High energy indie rock & skate punk',
    playsCount: '3.9k',
    likesCount: '1.3k',
    commentsCount: '304',
    songCount: 32,
  );

  static const PlaylistModel playlistSkateGangModel = PlaylistModel(
    id: 'p4',
    name: 'Skate gang',
    ownerName: 'John Jacobs',
    ownerAvatar: imgJohnJacobs,
    coverUrl: playlistSkateGang,
    description: 'Alternative hip hop and urban rap vibes',
    playsCount: '1.1k',
    likesCount: '1.1k',
    commentsCount: '304',
    songCount: 15,
  );

  static const PlaylistModel playlistEdSheeranModel = PlaylistModel(
    id: 'p5',
    name: 'ED Sheeran',
    ownerName: 'Spotify',
    ownerAvatar: imgPriya,
    coverUrl: playlistEdSheeran,
    description: 'Best of Ed Sheeran pop hits',
    playsCount: '88.5k',
    likesCount: '12.4k',
    commentsCount: '920',
    songCount: 40,
    platform: 'spotify',
  );

  static const PlaylistModel playlistIndianSummerModel = PlaylistModel(
    id: 'p6',
    name: 'Indian Summer',
    ownerName: 'YouTube Music',
    ownerAvatar: imgPriya,
    coverUrl: playlistIndianSummer,
    description: 'Sufi & classical acoustic fusion',
    playsCount: '42.1k',
    likesCount: '8.4k',
    commentsCount: '412',
    songCount: 22,
    platform: 'youtube',
  );

  // Mock Artists
  static const List<ArtistModel> artists = [
    ArtistModel(
      id: 'a1',
      name: 'Diljit Dosanjh',
      imageUrl: artistDiljit,
      genre: 'Punjabi Pop',
    ),
    ArtistModel(
      id: 'a2',
      name: 'Rihanna',
      imageUrl: artistRihanna,
      genre: 'R&B / Pop',
    ),
    ArtistModel(
      id: 'a3',
      name: 'Drake',
      imageUrl: artistDrake,
      genre: 'Hip Hop',
    ),
  ];

  // Mock Activities
  static const List<ActivityModel> activities = [
    ActivityModel(id: 'act1', title: 'Long Drive', iconUrl: iconCar),
    ActivityModel(id: 'act2', title: 'Hiking', iconUrl: iconHiking),
  ];

  // Mock Users with rich Dating & Media Profiles
  static final UserModel userJohnJacobs = UserModel(
    id: 'u1',
    name: 'John Jacobs',
    email: 'john@jingle.com',
    age: 26,
    location: 'New York, USA',
    imageUrl: imgJohnJacobs,
    bio:
        'Music producer & audiophile. Always chasing good sound, late night drives, and indie concert tickets. Let us trade playlists!',
    musicSimilarity: 85,
    isOnline: true,
    currentSong: trackWallOfEyes,
    activities: activities,
    photos: const [
      ProfilePhotoModel(id: 'p1', url: imgJohnJacobs, isPrimary: true, order: 0),
      ProfilePhotoModel(id: 'p2', url: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&q=80&w=800', order: 1),
      ProfilePhotoModel(id: 'p3', url: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&q=80&w=800', order: 2),
      ProfilePhotoModel(id: 'p4', url: 'https://images.unsplash.com/photo-1522075469751-3a6694fb2f61?auto=format&fit=crop&q=80&w=800', order: 3),
    ],
    datingPreferences: const DatingPreferenceModel(
      gender: GenderIdentity.man,
      lookingFor: LookingFor.woman,
      relationshipStatus: RelationshipStatus.single,
      relationshipIntent: RelationshipIntent.relationship,
      ageMin: 21,
      ageMax: 30,
    ),
    mediaConnections: [
      MediaConnectionModel(
        platform: MediaPlatform.spotify,
        status: ConnectionStatus.connected,
        accountUsername: '@john_jingle',
        connectedAt: DateTime.now(),
      ),
      MediaConnectionModel(
        platform: MediaPlatform.netflix,
        status: ConnectionStatus.connected,
        accountUsername: '@johnny_binge',
        connectedAt: DateTime.now(),
      ),
      MediaConnectionModel(
        platform: MediaPlatform.youtube,
        status: ConnectionStatus.connected,
        accountUsername: '@john_beats',
        connectedAt: DateTime.now(),
      ),
      const MediaConnectionModel(
        platform: MediaPlatform.instagram,
        status: ConnectionStatus.disconnected,
      ),
    ],
    favoriteGenres: [
      const GenreModel(
        id: 'g1',
        name: 'Rock',
        colors: [Color(0xFF1E3C72), Color(0xFF2A5298)],
      ),
      const GenreModel(
        id: 'g2',
        name: 'Dubstep',
        colors: [Color(0xFF8E2DE2), Color(0xFF4A00E0)],
      ),
    ],
    favoriteShows: favoriteShows,
    topTracks: const [
      trackStarboy,
      trackLevitating,
      trackAlchemical,
      trackHozier,
      trackWallOfEyes,
    ],
    myPlaylists: [
      playlistManAtWorkModel,
      playlistSkateRollsModel,
      playlistSkateGangModel,
    ],
    otherPlaylists: [
      playlistEdSheeranModel,
      playlistIndianSummerModel,
    ],
    recentTracks: [
      trackAlchemical,
      trackHozier,
    ],
    compatibility: const MediaCompatibilityModel(
      overallScore: 85,
      musicMatchPercentage: 88,
      showMatchPercentage: 82,
      sharedGenres: ['Rock', 'Dubstep', 'Indie'],
      sharedArtists: ['The Smile', 'Hozier'],
      sharedShows: ['Stranger Things', 'The Bear'],
      sharedInterests: ['Long Drive', 'Hiking'],
    ),
    isAuthenticated: true,
    isOnboarded: true,
  );

  static final UserModel userPriya = UserModel(
    id: 'u2',
    name: 'Priya',
    email: 'priya@jingle.com',
    age: 24,
    location: 'Mumbai, India',
    imageUrl: imgPriya,
    bio: 'Acoustic soundscapes & rooftop coffee lover. Seeking concert buddies & meaningful connections.',
    musicSimilarity: 92,
    isOnline: true,
    currentSong: trackWallOfEyes,
    favoriteArtists: artists,
    photos: const [
      ProfilePhotoModel(id: 'pp1', url: imgPriya, isPrimary: true, order: 0),
      ProfilePhotoModel(id: 'pp2', url: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&q=80&w=800', order: 1),
      ProfilePhotoModel(id: 'pp3', url: 'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&q=80&w=800', order: 2),
    ],
    datingPreferences: const DatingPreferenceModel(
      gender: GenderIdentity.woman,
      lookingFor: LookingFor.man,
      relationshipStatus: RelationshipStatus.single,
      relationshipIntent: RelationshipIntent.commitment,
      ageMin: 23,
      ageMax: 32,
    ),
    mediaConnections: [
      MediaConnectionModel(
        platform: MediaPlatform.spotify,
        status: ConnectionStatus.connected,
        accountUsername: '@priya_vibes',
        connectedAt: DateTime.now(),
      ),
      MediaConnectionModel(
        platform: MediaPlatform.instagram,
        status: ConnectionStatus.connected,
        accountUsername: '@priya.sound',
        connectedAt: DateTime.now(),
      ),
      MediaConnectionModel(
        platform: MediaPlatform.youtube,
        status: ConnectionStatus.connected,
        accountUsername: '@priya_music',
        connectedAt: DateTime.now(),
      ),
    ],
    favoriteShows: const [
      FavoriteShowModel(
        id: 'sh1',
        title: 'Stranger Things',
        posterUrl:
            'https://images.unsplash.com/photo-1536440136628-849c177e76a1?auto=format&fit=crop&q=80&w=600',
        platform: 'Netflix',
        genre: 'Sci-Fi',
      ),
      FavoriteShowModel(
        id: 'sh4',
        title: 'Succession',
        posterUrl:
            'https://images.unsplash.com/photo-1470225620780-dba8ba36b745?auto=format&fit=crop&q=80&w=600',
        platform: 'Amazon Prime',
        genre: 'Drama',
      ),
    ],
    topTracks: const [
      trackStarboy,
      trackLevitating,
      trackAlchemical,
      trackWorkout,
      trackWallOfEyes,
    ],
    myPlaylists: [playlistIcarosModel],
    recentTracks: [trackWallOfEyes, trackAlchemical],
    compatibility: const MediaCompatibilityModel(
      overallScore: 92,
      musicMatchPercentage: 95,
      showMatchPercentage: 89,
      sharedGenres: ['Punjabi Pop', 'R&B / Pop', 'Hip Hop'],
      sharedArtists: ['Diljit Dosanjh', 'Rihanna', 'Drake'],
      sharedShows: ['Stranger Things', 'Succession'],
      sharedInterests: ['Concerts', 'Nature walk'],
    ),
    isAuthenticated: true,
    isOnboarded: true,
  );

  static final UserModel userRoma = UserModel(
    id: 'u3',
    name: 'Roma',
    age: 23,
    location: 'London, UK',
    imageUrl: imgRoma,
    bio: 'Workout junkie, EDM head, synthwave lover. Looking for someone who can keep up on marathon playlist days!',
    musicSimilarity: 78,
    isOnline: true,
    currentSong: trackWorkout,
    isFollowing: true,
    photos: const [
      ProfilePhotoModel(id: 'pr1', url: imgRoma, isPrimary: true, order: 0),
      ProfilePhotoModel(id: 'pr2', url: 'https://images.unsplash.com/photo-1517841905240-472988babdf9?auto=format&fit=crop&q=80&w=800', order: 1),
    ],
    datingPreferences: const DatingPreferenceModel(
      gender: GenderIdentity.woman,
      lookingFor: LookingFor.man,
      relationshipStatus: RelationshipStatus.single,
      relationshipIntent: RelationshipIntent.casual,
    ),
    mediaConnections: [
      MediaConnectionModel(
        platform: MediaPlatform.youtube,
        status: ConnectionStatus.connected,
        accountUsername: '@roma_synth',
        connectedAt: DateTime.now(),
      ),
      MediaConnectionModel(
        platform: MediaPlatform.spotify,
        status: ConnectionStatus.connected,
        accountUsername: '@roma_edm',
        connectedAt: DateTime.now(),
      ),
    ],
    topTracks: const [
      trackWorkout,
      trackStarboy,
      trackAlchemical,
      trackLevitating,
      trackWallOfEyes,
    ],
    favoriteShows: const [
      FavoriteShowModel(
        id: 'sh2',
        title: 'The Bear',
        posterUrl:
            'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?auto=format&fit=crop&q=80&w=600',
        platform: 'Amazon Prime',
        genre: 'Drama',
      ),
    ],
    compatibility: const MediaCompatibilityModel(
      overallScore: 78,
      musicMatchPercentage: 80,
      showMatchPercentage: 76,
      sharedGenres: ['Electronic', 'Dance'],
      sharedArtists: ['The Weeknd'],
      sharedShows: ['The Bear'],
      sharedInterests: ['Fitness & Workout', 'Night club'],
    ),
  );

  static final UserModel userPanorama = UserModel(
    id: 'u4',
    name: 'Panorama',
    age: 25,
    location: 'Berlin, Germany',
    imageUrl: imgPanorama,
    bio: 'Techno nights, vinyl record shops, and indie film festivals.',
    musicSimilarity: 81,
    isOnline: false,
    isFollowing: false,
    photos: const [
      ProfilePhotoModel(id: 'pn1', url: imgPanorama, isPrimary: true, order: 0),
    ],
    datingPreferences: const DatingPreferenceModel(
      gender: GenderIdentity.other,
      lookingFor: LookingFor.everyone,
      relationshipStatus: RelationshipStatus.complicated,
      relationshipIntent: RelationshipIntent.friends,
    ),
    mediaConnections: [
      MediaConnectionModel(
        platform: MediaPlatform.spotify,
        status: ConnectionStatus.connected,
        accountUsername: '@panorama_berlin',
        connectedAt: DateTime.now(),
      ),
    ],
    topTracks: const [
      trackWallOfEyes,
      trackHozier,
      trackStarboy,
      trackAlchemical,
      trackLevitating,
    ],
    favoriteShows: favoriteShows,
    compatibility: const MediaCompatibilityModel(
      overallScore: 81,
      musicMatchPercentage: 84,
      showMatchPercentage: 78,
      sharedGenres: ['Techno', 'Indie Rock'],
      sharedArtists: ['The Smile', 'Hozier'],
      sharedShows: ['Stranger Things', 'Breaking Bad'],
      sharedInterests: ['Museum & Galleries', 'Festivals'],
    ),
  );

  static final List<UserModel> swipeUsers = [
    userJohnJacobs,
    userPriya.copyWith(isFollowing: false),
    userRoma.copyWith(isFollowing: false),
    userPanorama,
  ];

  // Mock Genres with distinct gradient colors matching reference screenshot grid
  static final List<GenreModel> genres = [
    const GenreModel(
      id: 'gn1',
      name: 'Afrobeat',
      colors: [Color(0xFF00C6FF), Color(0xFF0072FF)],
    ),
    const GenreModel(
      id: 'gn2',
      name: 'Hip Hop',
      colors: [Color(0xFF1D976C), Color(0xFF93F9B9)],
    ),
    const GenreModel(
      id: 'gn3',
      name: 'Jazz',
      colors: [Color(0xFF8E2DE2), Color(0xFF4A00E0)],
    ),
    const GenreModel(
      id: 'gn4',
      name: 'Folk Rock',
      colors: [Color(0xFFF12711), Color(0xFFF5AF19)],
    ),
    const GenreModel(
      id: 'gn5',
      name: 'Blues',
      colors: [Color(0xFFFF512F), Color(0xFFDD2476)],
    ),
    const GenreModel(
      id: 'gn6',
      name: 'Pop',
      colors: [Color(0xFF11998E), Color(0xFF38EF7D)],
    ),
    const GenreModel(
      id: 'gn7',
      name: 'Reggae',
      colors: [Color(0xFFFC466B), Color(0xFF3F5EFB)],
    ),
    const GenreModel(
      id: 'gn8',
      name: 'Indian Classical',
      colors: [Color(0xFFFF9966), Color(0xFFFF5E62)],
    ),
    const GenreModel(
      id: 'gn9',
      name: 'Funk Soul',
      colors: [Color(0xFF4568DC), Color(0xFFB06AB3)],
    ),
    const GenreModel(
      id: 'gn10',
      name: 'Heavy Metal',
      colors: [Color(0xFF434343), Color(0xFF000000)],
    ),
    const GenreModel(
      id: 'gn11',
      name: 'Alternative Rock',
      colors: [Color(0xFF654EA3), Color(0xFFEAAFC8)],
    ),
    const GenreModel(
      id: 'gn12',
      name: 'Afro Pop',
      colors: [Color(0xFFFF416C), Color(0xFFFF4B2B)],
    ),
    const GenreModel(
      id: 'gn13',
      name: 'Anime',
      colors: [Color(0xFF00B4DB), Color(0xFF0083B0)],
    ),
    const GenreModel(
      id: 'gn14',
      name: 'Bollywood',
      colors: [Color(0xFFEC6EAD), Color(0xFF3494E6)],
    ),
    const GenreModel(
      id: 'gn15',
      name: 'K-Pop',
      colors: [Color(0xFFF7971E), Color(0xFFFFD200)],
    ),
    const GenreModel(
      id: 'gn16',
      name: 'Brazilian',
      colors: [Color(0xFF56AB2F), Color(0xFFA8E063)],
    ),
    const GenreModel(
      id: 'gn17',
      name: 'Chinese',
      colors: [Color(0xFF02AABD), Color(0xFF00CDAC)],
    ),
    const GenreModel(
      id: 'gn18',
      name: 'Classical',
      colors: [Color(0xFF2C3E50), Color(0xFF4CA1AF)],
    ),
    const GenreModel(
      id: 'gn19',
      name: 'Comedy',
      colors: [Color(0xFFF09819), Color(0xFFEDDE5D)],
    ),
    const GenreModel(
      id: 'gn20',
      name: 'Country',
      colors: [Color(0xFFFF512F), Color(0xFFF09819)],
    ),
    const GenreModel(
      id: 'gn21',
      name: 'Dance',
      colors: [Color(0xFF22C1C3), Color(0xFFFDBB2D)],
    ),
    const GenreModel(
      id: 'gn22',
      name: 'Disco',
      colors: [Color(0xFFE100FF), Color(0xFF7F00FF)],
    ),
    const GenreModel(
      id: 'gn23',
      name: 'Easy Listening',
      colors: [Color(0xFFFF4E50), Color(0xFFF9D423)],
    ),
    const GenreModel(
      id: 'gn24',
      name: 'Electronic',
      colors: [Color(0xFFB92B27), Color(0xFF1565C0)],
    ),
    const GenreModel(
      id: 'gn25',
      name: 'Farsi',
      colors: [Color(0xFF3A1C71), Color(0xFFD76D77)],
    ),
    const GenreModel(
      id: 'gn26',
      name: 'Fitness & Workout',
      colors: [Color(0xFFF857A6), Color(0xFFFF5858)],
    ),
    const GenreModel(
      id: 'gn27',
      name: 'French Pop',
      colors: [Color(0xFF00B0FF), Color(0xFF00E5FF)],
    ),
    const GenreModel(
      id: 'gn28',
      name: 'Funk',
      colors: [Color(0xFF673AB7), Color(0xFF512DA8)],
    ),
    const GenreModel(
      id: 'gn29',
      name: 'House',
      colors: [Color(0xFF00E676), Color(0xFF1DE9B6)],
    ),
    const GenreModel(
      id: 'gn30',
      name: 'Hard Rock',
      colors: [Color(0xFF263238), Color(0xFF37474F)],
    ),
    const GenreModel(
      id: 'gn31',
      name: 'Indie Rock',
      colors: [Color(0xFFFF9100), Color(0xFFFF6D00)],
    ),
    const GenreModel(
      id: 'gn32',
      name: 'Instrumental',
      colors: [Color(0xFF00BFA5), Color(0xFF00897B)],
    ),
    const GenreModel(
      id: 'gn33',
      name: 'Latin',
      colors: [Color(0xFFD50000), Color(0xFFC51162)],
    ),
    const GenreModel(
      id: 'gn34',
      name: 'Metal',
      colors: [Color(0xFF212121), Color(0xFF424242)],
    ),
    const GenreModel(
      id: 'gn35',
      name: 'Oldies',
      colors: [Color(0xFFAEEA00), Color(0xFF64DD17)],
    ),
    const GenreModel(
      id: 'gn36',
      name: 'Psychedelic',
      colors: [Color(0xFFAA00FF), Color(0xFF6200EA)],
    ),
    const GenreModel(
      id: 'gn37',
      name: 'Punjabi',
      colors: [Color(0xFF76FF03), Color(0xFF64DD17)],
    ),
    const GenreModel(
      id: 'gn38',
      name: 'R&B',
      colors: [Color(0xFFFF3D00), Color(0xFFDD2C00)],
    ),
    const GenreModel(
      id: 'gn39',
      name: 'Rap',
      colors: [Color(0xFF00B0FF), Color(0xFF2979FF)],
    ),
    const GenreModel(
      id: 'gn40',
      name: 'Rock & Roll',
      colors: [Color(0xFFBF360C), Color(0xFF8D6E63)],
    ),
    const GenreModel(
      id: 'gn41',
      name: 'Sufi',
      colors: [Color(0xFF4A148C), Color(0xFF7B1FA2)],
    ),
    const GenreModel(
      id: 'gn42',
      name: 'Techno',
      colors: [Color(0xFFFFAB00), Color(0xFFFF6D00)],
    ),
    const GenreModel(
      id: 'gn43',
      name: 'Trance',
      colors: [Color(0xFF00E5FF), Color(0xFF00B0FF)],
    ),
    const GenreModel(
      id: 'gn44',
      name: 'Turkish',
      colors: [Color(0xFFFF1744), Color(0xFFD50000)],
    ),
    const GenreModel(
      id: 'gn45',
      name: 'Urbano Latino',
      colors: [Color(0xFFF50057), Color(0xFFC51162)],
    ),
    const GenreModel(
      id: 'gn46',
      name: 'Vocal Jazz',
      colors: [Color(0xFF2979FF), Color(0xFF3D5AFE)],
    ),
    const GenreModel(
      id: 'gn47',
      name: 'Worldwide',
      colors: [Color(0xFF1DE9B6), Color(0xFF00BFA5)],
    ),
    const GenreModel(
      id: 'gn48',
      name: 'World Music',
      colors: [Color(0xFF00E676), Color(0xFF00C853)],
    ),
  ];

  // Mock Moods matching screenshot stickers
  static const List<MoodModel> moods = [
    MoodModel(
      id: 'md1',
      name: 'In Love',
      imageUrl: 'https://api.iconify.design/noto:smiling-face-with-hearts.svg',
      colorHex: '#FF6B8B',
    ),
    MoodModel(
      id: 'md2',
      name: 'Devilish',
      imageUrl: 'https://api.iconify.design/noto:smiling-face-with-horns.svg',
      colorHex: '#FF4757',
    ),
    MoodModel(
      id: 'md3',
      name: 'Exhausted',
      imageUrl: 'https://api.iconify.design/noto:tired-face.svg',
      colorHex: '#FFA502',
    ),
    MoodModel(
      id: 'md4',
      name: 'Happy',
      imageUrl: 'https://api.iconify.design/noto:grinning-face-with-big-eyes.svg',
      colorHex: '#2ED573',
    ),
    MoodModel(
      id: 'md5',
      name: 'Relaxed',
      imageUrl: 'https://api.iconify.design/noto:relieved-face.svg',
      colorHex: '#1E90FF',
    ),
    MoodModel(
      id: 'md6',
      name: 'Energetic',
      imageUrl: 'https://api.iconify.design/noto:star-struck.svg',
      colorHex: '#ECCC68',
    ),
    MoodModel(
      id: 'md7',
      name: 'Sad',
      imageUrl: 'https://api.iconify.design/noto:crying-face.svg',
      colorHex: '#70A1FF',
    ),
    MoodModel(
      id: 'md8',
      name: 'Chill',
      imageUrl: 'https://api.iconify.design/noto:smiling-face-with-sunglasses.svg',
      colorHex: '#747D8C',
    ),
  ];

  // Mock Categories and Interest Chips matching reference screenshots
  static Map<String, List<InterestModel>> interestsByCategory = {
    'Events': const [
      InterestModel(id: 'e1', category: 'Events', name: 'Museum & Galleries', imageUrl: 'https://images.unsplash.com/photo-1554907984-15263bf963fb?w=100'),
      InterestModel(id: 'e2', category: 'Events', name: 'Architecture & Walk', imageUrl: 'https://images.unsplash.com/photo-1513694203232-719a280e022f?w=100'),
      InterestModel(id: 'e3', category: 'Events', name: 'Bar', imageUrl: 'https://images.unsplash.com/photo-1514933651103-005eec06c04b?w=100'),
      InterestModel(id: 'e4', category: 'Events', name: 'Cinema', imageUrl: 'https://images.unsplash.com/photo-1489599849927-2ee91cede3ba?w=100'),
      InterestModel(id: 'e5', category: 'Events', name: 'Restaurant & Cafe', imageUrl: 'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=100'),
      InterestModel(id: 'e6', category: 'Events', name: 'Karaoke', imageUrl: 'https://images.unsplash.com/photo-1516450360452-9312f5e86fc7?w=100'),
      InterestModel(id: 'e7', category: 'Events', name: 'Concerts', imageUrl: 'https://images.unsplash.com/photo-1470229722913-7c0e2dbbafd3?w=100'),
      InterestModel(id: 'e8', category: 'Events', name: 'Stand ups', imageUrl: 'https://images.unsplash.com/photo-1585699324551-f6c309eedeca?w=100'),
      InterestModel(id: 'e9', category: 'Events', name: 'Night club', imageUrl: 'https://images.unsplash.com/photo-1566737236500-c8ac43014a67?w=100'),
      InterestModel(id: 'e10', category: 'Events', name: 'Theatre', imageUrl: 'https://images.unsplash.com/photo-1507676184212-d03ab07a01bf?w=100'),
      InterestModel(id: 'e11', category: 'Events', name: 'Festivals', imageUrl: 'https://images.unsplash.com/photo-1533174072545-7a4b6ad7a6c3?w=100'),
    ],
    'Travel': const [
      InterestModel(id: 't1', category: 'Travel', name: 'Nature walk', imageUrl: 'https://images.unsplash.com/photo-1448375240586-882707db888b?w=100'),
      InterestModel(id: 't2', category: 'Travel', name: 'Beach', imageUrl: 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=100'),
      InterestModel(id: 't3', category: 'Travel', name: 'Camping', imageUrl: 'https://images.unsplash.com/photo-1504280390367-361c6d9f38f4?w=100'),
      InterestModel(id: 't4', category: 'Travel', name: 'Long drives', imageUrl: 'https://images.unsplash.com/photo-1469854523086-cc02fe5d8800?w=100'),
      InterestModel(id: 't5', category: 'Travel', name: 'Discover places', imageUrl: 'https://images.unsplash.com/photo-1488646953014-85cb44e25828?w=100'),
      InterestModel(id: 't6', category: 'Travel', name: 'Fishing', imageUrl: 'https://images.unsplash.com/photo-1499244571948-7ccddb3583f1?w=100'),
    ],
    'Home': const [
      InterestModel(id: 'h1', category: 'Home', name: 'Cooking', imageUrl: 'https://images.unsplash.com/photo-1556910103-1c02745aae4d?w=100'),
      InterestModel(id: 'h2', category: 'Home', name: 'Video games', imageUrl: 'https://images.unsplash.com/photo-1538481199705-c710c4e965fc?w=100'),
      InterestModel(id: 'h3', category: 'Home', name: 'Gardening', imageUrl: 'https://images.unsplash.com/photo-1416879595882-3373a0480b5b?w=100'),
      InterestModel(id: 'h4', category: 'Home', name: 'Pet animals', imageUrl: 'https://images.unsplash.com/photo-1543466835-00a7907e9de1?w=100'),
      InterestModel(id: 'h5', category: 'Home', name: 'Board games', imageUrl: 'https://images.unsplash.com/photo-1610890716171-6b1bb98ffd09?w=100'),
    ],
    'Food & Drinks': const [
      InterestModel(id: 'fd1', category: 'Food & Drinks', name: 'Pasta', imageUrl: 'https://images.unsplash.com/photo-1621996346565-e3d5d6281270?w=100'),
      InterestModel(id: 'fd2', category: 'Food & Drinks', name: 'Steak', imageUrl: 'https://images.unsplash.com/photo-1558030006-450675393462?w=100'),
      InterestModel(id: 'fd3', category: 'Food & Drinks', name: 'Vegetarian', imageUrl: 'https://images.unsplash.com/photo-1540420773420-3366772f4999?w=100'),
      InterestModel(id: 'fd4', category: 'Food & Drinks', name: 'Burger', imageUrl: 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=100'),
      InterestModel(id: 'fd5', category: 'Food & Drinks', name: 'Coffee', imageUrl: 'https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=100'),
      InterestModel(id: 'fd6', category: 'Food & Drinks', name: 'Whiskey', imageUrl: 'https://images.unsplash.com/photo-1527281400683-1aae777175f8?w=100'),
      InterestModel(id: 'fd7', category: 'Food & Drinks', name: 'Pizza', imageUrl: 'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=100'),
      InterestModel(id: 'fd8', category: 'Food & Drinks', name: 'Sushi', imageUrl: 'https://images.unsplash.com/photo-1579871494447-9811cf80d66c?w=100'),
    ],
    'Creativity': const [
      InterestModel(id: 'c1', category: 'Creativity', name: 'Painting', imageUrl: 'https://images.unsplash.com/photo-1579783902614-a3fb3927b675?w=100'),
      InterestModel(id: 'c2', category: 'Creativity', name: 'Art', imageUrl: 'https://images.unsplash.com/photo-1547826039-bfc35e0f1ea8?w=100'),
      InterestModel(id: 'c3', category: 'Creativity', name: 'Makeup', imageUrl: 'https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?w=100'),
      InterestModel(id: 'c4', category: 'Creativity', name: 'Photography', imageUrl: 'https://images.unsplash.com/photo-1516035069371-29a1b244cc32?w=100'),
      InterestModel(id: 'c5', category: 'Creativity', name: 'Writing', imageUrl: 'https://images.unsplash.com/photo-1455390582262-044cdead277a?w=100'),
      InterestModel(id: 'c6', category: 'Creativity', name: 'Dancing', imageUrl: 'https://images.unsplash.com/photo-1508700115892-45ecd05ae2ad?w=100'),
    ],
    'Music': const [
      InterestModel(id: 'm1', category: 'Music', name: 'Clarinet', imageUrl: 'https://images.unsplash.com/photo-1520523839897-bd0b52f945a0?w=100'),
      InterestModel(id: 'm2', category: 'Music', name: 'Saxophone', imageUrl: 'https://images.unsplash.com/photo-1525994886773-080587e161c2?w=100'),
      InterestModel(id: 'm3', category: 'Music', name: 'Playing Drums', imageUrl: 'https://images.unsplash.com/photo-1519892300165-cb5542fb47c7?w=100'),
      InterestModel(id: 'm4', category: 'Music', name: 'Composing', imageUrl: 'https://images.unsplash.com/photo-1507838153414-b4b713384a76?w=100'),
      InterestModel(id: 'm5', category: 'Music', name: 'Rapping', imageUrl: 'https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?w=100'),
      InterestModel(id: 'm6', category: 'Music', name: 'Music Production', imageUrl: 'https://images.unsplash.com/photo-1598488035139-bdbb2231ce04?w=100'),
      InterestModel(id: 'm7', category: 'Music', name: 'Guitar', imageUrl: 'https://images.unsplash.com/photo-1510915361894-db8b60106cb1?w=100'),
      InterestModel(id: 'm8', category: 'Music', name: 'Trumpet', imageUrl: 'https://images.unsplash.com/photo-1511192336575-5a79af67a629?w=100'),
      InterestModel(id: 'm9', category: 'Music', name: 'Piano', imageUrl: 'https://images.unsplash.com/photo-1520523839897-bd0b52f945a0?w=100'),
      InterestModel(id: 'm10', category: 'Music', name: 'Electronic music', imageUrl: 'https://images.unsplash.com/photo-1470225620780-dba8ba36b745?w=100'),
    ],
    'Sports': const [
      InterestModel(id: 's1', category: 'Sports', name: 'Yoga', imageUrl: 'https://images.unsplash.com/photo-1545205597-3d9d02c29597?w=100'),
      InterestModel(id: 's2', category: 'Sports', name: 'Baseball', imageUrl: 'https://images.unsplash.com/photo-1562077772-3bd90403f7f0?w=100'),
      InterestModel(id: 's3', category: 'Sports', name: 'Volleyball', imageUrl: 'https://images.unsplash.com/photo-1592656094267-764a45160876?w=100'),
      InterestModel(id: 's4', category: 'Sports', name: 'Rugby', imageUrl: 'https://images.unsplash.com/photo-1515037893149-de7f840978e2?w=100'),
      InterestModel(id: 's5', category: 'Sports', name: 'Running', imageUrl: 'https://images.unsplash.com/photo-1476480862126-209bfaa8edc8?w=100'),
      InterestModel(id: 's6', category: 'Sports', name: 'Football', imageUrl: 'https://images.unsplash.com/photo-1508098682722-e99c43a406b2?w=100'),
      InterestModel(id: 's7', category: 'Sports', name: 'Tennis', imageUrl: 'https://images.unsplash.com/photo-1595435934249-5df7ed86e1c0?w=100'),
      InterestModel(id: 's8', category: 'Sports', name: 'Cycling', imageUrl: 'https://images.unsplash.com/photo-1485965120184-e220f721d03e?w=100'),
    ],
  };
}
