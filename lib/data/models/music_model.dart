class MusicModel {
  final String id;
  final String title;
  final String artist;
  final String albumArt;
  final String plays;
  final String? platform; // 'spotify', 'youtube', null

  const MusicModel({
    required this.id,
    required this.title,
    required this.artist,
    required this.albumArt,
    required this.plays,
    this.platform,
  });
}
