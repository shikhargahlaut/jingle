import 'package:flutter_test/flutter_test.dart';
import 'package:jingle/data/models/dating_preference_model.dart';
import 'package:jingle/data/models/profile_photo_model.dart';
import 'package:jingle/data/models/media_connection_model.dart';
import 'package:jingle/data/models/media_compatibility_model.dart';
import 'package:jingle/data/services/photo_service.dart';
import 'package:jingle/data/services/media_service.dart';
import 'package:jingle/data/services/compatibility_service.dart';
import 'package:jingle/data/mock/mock_data.dart';

void main() {
  group('Dating Preference Model & Enums Tests', () {
    test('GenderIdentity enum string mapping', () {
      expect(GenderIdentity.fromString('man'), GenderIdentity.man);
      expect(GenderIdentity.fromString('woman'), GenderIdentity.woman);
      expect(GenderIdentity.fromString('non-binary'), GenderIdentity.other);
      expect(GenderIdentity.man.label, 'Man');
    });

    test('LookingFor enum string mapping', () {
      expect(LookingFor.fromString('men'), LookingFor.man);
      expect(LookingFor.fromString('women'), LookingFor.woman);
      expect(LookingFor.fromString('everyone'), LookingFor.everyone);
    });

    test('RelationshipStatus enum mapping', () {
      expect(RelationshipStatus.fromString('single'), RelationshipStatus.single);
      expect(RelationshipStatus.fromString('in_relationship'), RelationshipStatus.inRelationship);
      expect(RelationshipStatus.fromString('complicated'), RelationshipStatus.complicated);
    });

    test('RelationshipIntent enum mapping', () {
      expect(RelationshipIntent.fromString('relationship'), RelationshipIntent.relationship);
      expect(RelationshipIntent.fromString('casual'), RelationshipIntent.casual);
      expect(RelationshipIntent.fromString('commitment'), RelationshipIntent.commitment);
      expect(RelationshipIntent.fromString('friends'), RelationshipIntent.friends);
    });

    test('DatingPreferenceModel serialization & deserialization', () {
      const model = DatingPreferenceModel(
        gender: GenderIdentity.woman,
        lookingFor: LookingFor.man,
        relationshipStatus: RelationshipStatus.single,
        relationshipIntent: RelationshipIntent.relationship,
        ageMin: 21,
        ageMax: 30,
      );

      final json = model.toJson();
      final fromJson = DatingPreferenceModel.fromJson(json);

      expect(fromJson.gender, GenderIdentity.woman);
      expect(fromJson.lookingFor, LookingFor.man);
      expect(fromJson.relationshipStatus, RelationshipStatus.single);
      expect(fromJson.relationshipIntent, RelationshipIntent.relationship);
      expect(fromJson.ageMin, 21);
      expect(fromJson.ageMax, 30);
    });
  });

  group('Photo Management Service Tests', () {
    final photoService = DefaultPhotoService();

    test('Adding photos up to max 6 photos', () {
      List<ProfilePhotoModel> list = [];

      // User can have 0 photos (no mandatory minimum)
      expect(list.length, 0);

      // Add 6 photos
      for (int i = 1; i <= 6; i++) {
        list = photoService.addPhoto(
          currentPhotos: list,
          photoUrl: 'https://example.com/photo$i.jpg',
        );
      }
      expect(list.length, 6);
      expect(list.first.isPrimary, true); // First photo is primary

      // Adding 7th photo should be ignored (enforcing max 6 limit)
      final overflow = photoService.addPhoto(
        currentPhotos: list,
        photoUrl: 'https://example.com/photo7.jpg',
      );
      expect(overflow.length, 6);
    });

    test('Supports local device file paths', () {
      List<ProfilePhotoModel> list = [];
      list = photoService.addPhoto(
        currentPhotos: list,
        photoUrl: '/data/user/0/com.jingle.app/cache/image_picker_123.jpg',
      );
      expect(list.length, 1);
      expect(list.first.url.contains('image_picker_123.jpg'), true);
    });

    test('Removing photos updates primary flag & orders', () {
      List<ProfilePhotoModel> list = [];
      list = photoService.addPhoto(
        currentPhotos: list,
        photoUrl: 'https://example.com/photo1.jpg',
      );
      list = photoService.addPhoto(
        currentPhotos: list,
        photoUrl: 'https://example.com/photo2.jpg',
      );

      final primaryId = list.first.id;
      list = photoService.removePhoto(currentPhotos: list, photoId: primaryId);

      expect(list.length, 1);
      expect(list.first.isPrimary, true);
      expect(list.first.order, 0);
    });

    test('Reordering photos works accurately', () {
      List<ProfilePhotoModel> list = [
        const ProfilePhotoModel(id: '1', url: 'url1', order: 0),
        const ProfilePhotoModel(id: '2', url: 'url2', order: 1),
        const ProfilePhotoModel(id: '3', url: 'url3', order: 2),
      ];

      final reordered = photoService.reorderPhotos(
        currentPhotos: list,
        oldIndex: 0,
        newIndex: 2,
      );

      expect(reordered[0].id, '2');
      expect(reordered[1].id, '1');
      expect(reordered[2].id, '3');
    });
  });

  group('Media Service & Top Tracks Pipeline Tests', () {
    final mediaService = DefaultMediaService();

    test('Top listening tracks sorted descending by playback count and capped at 5', () async {
      final top5 = await mediaService.getTopListeningTracks(limit: 5);
      expect(top5.length, 5);

      // Verify descending order (e.g. Starboy 34.2k > Levitating 28.1k > ...)
      expect(top5[0].title, 'Starboy');
      expect(top5[1].title, 'Levitating');
    });

    test('Connecting and disconnecting external media platforms', () async {
      final connected = await mediaService.connectPlatform(MediaPlatform.spotify);
      expect(connected.platform, MediaPlatform.spotify);
      expect(connected.status, ConnectionStatus.connected);

      await mediaService.disconnectPlatform(MediaPlatform.spotify);
      final connections = await mediaService.getMediaConnections();
      final spotify = connections.firstWhere((c) => c.platform == MediaPlatform.spotify);
      expect(spotify.status, ConnectionStatus.disconnected);
    });
  });

  group('Compatibility Service Tests', () {
    final compService = DefaultCompatibilityService();

    test('Resolves compatibility score and tier label', () {
      final current = MockData.userJohnJacobs;
      final other = MockData.userPriya;

      final comp = compService.getCompatibility(current, other);
      expect(comp.overallScore, greaterThanOrEqualTo(0));
      expect(comp.overallScore, lessThanOrEqualTo(100));
      expect(comp.tierLabel.isNotEmpty, true);
    });

    test('Precomputed compatibility is prioritized when available', () {
      final current = MockData.userJohnJacobs;
      final other = MockData.userPriya.copyWith(
        compatibility: const MediaCompatibilityModel(
          overallScore: 99,
          musicMatchPercentage: 99,
          showMatchPercentage: 95,
        ),
      );

      final comp = compService.getCompatibility(current, other);
      expect(comp.overallScore, 99);
      expect(comp.tierLabel, 'Very Strong Match');
    });
  });
}
