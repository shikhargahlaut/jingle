class PlaylistModel {
  final String id;
  final String name;
  final String ownerName;
  final String ownerAvatar;
  final String coverUrl;
  final String description;
  final String playsCount;
  final String likesCount;
  final String commentsCount;
  final int songCount;
  final String? platform; // 'spotify', 'youtube'

  const PlaylistModel({
    required this.id,
    required this.name,
    required this.ownerName,
    required this.ownerAvatar,
    required this.coverUrl,
    required this.description,
    required this.playsCount,
    required this.likesCount,
    required this.commentsCount,
    required this.songCount,
    this.platform,
  });
}
