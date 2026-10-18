/// Favorite show or movie data model.
class FavoriteShowModel {
  final String id;
  final String title;
  final String posterUrl;
  final String platform; // 'Netflix', 'Amazon Prime', 'Apple TV', etc.
  final String? genre;
  final String? releaseYear;

  const FavoriteShowModel({
    required this.id,
    required this.title,
    required this.posterUrl,
    required this.platform,
    this.genre,
    this.releaseYear,
  });

  FavoriteShowModel copyWith({
    String? id,
    String? title,
    String? posterUrl,
    String? platform,
    String? genre,
    String? releaseYear,
  }) {
    return FavoriteShowModel(
      id: id ?? this.id,
      title: title ?? this.title,
      posterUrl: posterUrl ?? this.posterUrl,
      platform: platform ?? this.platform,
      genre: genre ?? this.genre,
      releaseYear: releaseYear ?? this.releaseYear,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'posterUrl': posterUrl,
      'platform': platform,
      'genre': genre,
      'releaseYear': releaseYear,
    };
  }

  factory FavoriteShowModel.fromJson(Map<String, dynamic> json) {
    return FavoriteShowModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      posterUrl: json['posterUrl'] as String? ?? '',
      platform: json['platform'] as String? ?? 'Netflix',
      genre: json['genre'] as String?,
      releaseYear: json['releaseYear'] as String?,
    );
  }
}
