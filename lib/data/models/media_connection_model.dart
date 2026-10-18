/// Supported media & social service platforms.
enum MediaPlatform {
  spotify,
  youtube,
  appleMusic,
  amazonPrime,
  netflix,
  instagram;

  String get displayName {
    switch (this) {
      case MediaPlatform.spotify:
        return 'Spotify';
      case MediaPlatform.youtube:
        return 'YouTube Music';
      case MediaPlatform.appleMusic:
        return 'Apple Music';
      case MediaPlatform.amazonPrime:
        return 'Amazon Prime';
      case MediaPlatform.netflix:
        return 'Netflix';
      case MediaPlatform.instagram:
        return 'Instagram';
    }
  }

  String get category {
    switch (this) {
      case MediaPlatform.spotify:
      case MediaPlatform.youtube:
      case MediaPlatform.appleMusic:
        return 'Music';
      case MediaPlatform.amazonPrime:
      case MediaPlatform.netflix:
        return 'Streaming';
      case MediaPlatform.instagram:
        return 'Social';
    }
  }

  static MediaPlatform? fromString(String? val) {
    if (val == null) return null;
    switch (val.toLowerCase()) {
      case 'spotify':
        return MediaPlatform.spotify;
      case 'youtube':
      case 'youtube music':
      case 'youtubemusic':
        return MediaPlatform.youtube;
      case 'applemusic':
      case 'apple music':
      case 'apple':
        return MediaPlatform.appleMusic;
      case 'amazonprime':
      case 'amazon prime':
      case 'prime':
        return MediaPlatform.amazonPrime;
      case 'netflix':
        return MediaPlatform.netflix;
      case 'instagram':
        return MediaPlatform.instagram;
      default:
        return null;
    }
  }
}

/// Status of a media provider connection.
enum ConnectionStatus {
  disconnected,
  connecting,
  connected,
  error;

  bool get isConnected => this == ConnectionStatus.connected;
  bool get isConnecting => this == ConnectionStatus.connecting;
}

/// Data model representing a media or social connection for the user.
class MediaConnectionModel {
  final MediaPlatform platform;
  final ConnectionStatus status;
  final String? accountUsername;
  final DateTime? connectedAt;
  final String? profileUrl;

  const MediaConnectionModel({
    required this.platform,
    this.status = ConnectionStatus.disconnected,
    this.accountUsername,
    this.connectedAt,
    this.profileUrl,
  });

  MediaConnectionModel copyWith({
    MediaPlatform? platform,
    ConnectionStatus? status,
    String? accountUsername,
    DateTime? connectedAt,
    String? profileUrl,
  }) {
    return MediaConnectionModel(
      platform: platform ?? this.platform,
      status: status ?? this.status,
      accountUsername: accountUsername ?? this.accountUsername,
      connectedAt: connectedAt ?? this.connectedAt,
      profileUrl: profileUrl ?? this.profileUrl,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'platform': platform.name,
      'status': status.name,
      'accountUsername': accountUsername,
      'connectedAt': connectedAt?.toIso8601String(),
      'profileUrl': profileUrl,
    };
  }

  factory MediaConnectionModel.fromJson(Map<String, dynamic> json) {
    return MediaConnectionModel(
      platform: MediaPlatform.fromString(json['platform'] as String?) ??
          MediaPlatform.spotify,
      status: ConnectionStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => ConnectionStatus.disconnected,
      ),
      accountUsername: json['accountUsername'] as String?,
      connectedAt: json['connectedAt'] != null
          ? DateTime.tryParse(json['connectedAt'] as String)
          : null,
      profileUrl: json['profileUrl'] as String?,
    );
  }
}
