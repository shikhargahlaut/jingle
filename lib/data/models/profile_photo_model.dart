/// Profile photo data model representing an image uploaded/linked by the user.
class ProfilePhotoModel {
  final String id;
  final String url;
  final bool isPrimary;
  final int order;

  const ProfilePhotoModel({
    required this.id,
    required this.url,
    this.isPrimary = false,
    this.order = 0,
  });

  ProfilePhotoModel copyWith({
    String? id,
    String? url,
    bool? isPrimary,
    int? order,
  }) {
    return ProfilePhotoModel(
      id: id ?? this.id,
      url: url ?? this.url,
      isPrimary: isPrimary ?? this.isPrimary,
      order: order ?? this.order,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'url': url,
      'isPrimary': isPrimary,
      'order': order,
    };
  }

  factory ProfilePhotoModel.fromJson(Map<String, dynamic> json) {
    return ProfilePhotoModel(
      id: json['id'] as String? ?? '',
      url: json['url'] as String? ?? '',
      isPrimary: json['isPrimary'] as bool? ?? false,
      order: json['order'] as int? ?? 0,
    );
  }
}
