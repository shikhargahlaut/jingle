/// Compatibility breakdown model describing how strongly two users match on media & music.
class MediaCompatibilityModel {
  final int overallScore; // 0 to 100
  final int musicMatchPercentage;
  final int showMatchPercentage;
  final List<String> sharedGenres;
  final List<String> sharedArtists;
  final List<String> sharedShows;
  final List<String> sharedInterests;

  const MediaCompatibilityModel({
    required this.overallScore,
    this.musicMatchPercentage = 0,
    this.showMatchPercentage = 0,
    this.sharedGenres = const [],
    this.sharedArtists = const [],
    this.sharedShows = const [],
    this.sharedInterests = const [],
  });

  String get tierLabel {
    if (overallScore >= 90) return 'Very Strong Match';
    if (overallScore >= 75) return 'Strong Match';
    if (overallScore >= 60) return 'Good Match';
    if (overallScore >= 40) return 'Moderate Match';
    return 'Music Explorer';
  }

  Map<String, dynamic> toJson() {
    return {
      'overallScore': overallScore,
      'musicMatchPercentage': musicMatchPercentage,
      'showMatchPercentage': showMatchPercentage,
      'sharedGenres': sharedGenres,
      'sharedArtists': sharedArtists,
      'sharedShows': sharedShows,
      'sharedInterests': sharedInterests,
    };
  }

  factory MediaCompatibilityModel.fromJson(Map<String, dynamic> json) {
    return MediaCompatibilityModel(
      overallScore: json['overallScore'] as int? ?? 0,
      musicMatchPercentage: json['musicMatchPercentage'] as int? ?? 0,
      showMatchPercentage: json['showMatchPercentage'] as int? ?? 0,
      sharedGenres: (json['sharedGenres'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
      sharedArtists: (json['sharedArtists'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
      sharedShows: (json['sharedShows'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
      sharedInterests: (json['sharedInterests'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
    );
  }
}
