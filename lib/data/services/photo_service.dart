import 'package:image_picker/image_picker.dart';
import '../models/profile_photo_model.dart';
import '../mock/mock_data.dart';

/// Abstract photo management service contract ready for real device gallery and cloud/backend API integration.
abstract class PhotoService {
  /// Returns preset library for mock fixture generation.
  List<String> getPresetPhotoLibrary();

  /// Picks photos directly from the user's real phone gallery (supporting multi-selection up to 6 photos).
  Future<List<ProfilePhotoModel>> pickPhotosFromGallery({
    required List<ProfilePhotoModel> currentPhotos,
  });

  /// Captures a photo using the device camera.
  Future<List<ProfilePhotoModel>> pickPhotoFromCamera({
    required List<ProfilePhotoModel> currentPhotos,
  });

  /// Validates and adds a photo to the photo list (maximum 6 photos allowed).
  List<ProfilePhotoModel> addPhoto({
    required List<ProfilePhotoModel> currentPhotos,
    required String photoUrl,
  });

  /// Removes a photo by its ID.
  List<ProfilePhotoModel> removePhoto({
    required List<ProfilePhotoModel> currentPhotos,
    required String photoId,
  });

  /// Sets a photo as the primary cover photo.
  List<ProfilePhotoModel> setPrimaryPhoto({
    required List<ProfilePhotoModel> currentPhotos,
    required String photoId,
  });

  /// Reorders photos in the list.
  List<ProfilePhotoModel> reorderPhotos({
    required List<ProfilePhotoModel> currentPhotos,
    required int oldIndex,
    required int newIndex,
  });
}

/// Concrete default photo service implementation using real ImagePicker.
class DefaultPhotoService implements PhotoService {
  static const int maxPhotosAllowed = 6;
  final ImagePicker _picker = ImagePicker();

  @override
  List<String> getPresetPhotoLibrary() {
    return MockData.samplePhotoLibrary;
  }

  @override
  Future<List<ProfilePhotoModel>> pickPhotosFromGallery({
    required List<ProfilePhotoModel> currentPhotos,
  }) async {
    final remainingSlots = maxPhotosAllowed - currentPhotos.length;
    if (remainingSlots <= 0) {
      return currentPhotos;
    }

    try {
      // Real phone gallery multi-image picker
      final List<XFile> pickedFiles = await _picker.pickMultiImage();
      if (pickedFiles.isEmpty) {
        return currentPhotos;
      }

      final filesToAdd = pickedFiles.take(remainingSlots).toList();
      var updated = List<ProfilePhotoModel>.from(currentPhotos);

      for (int i = 0; i < filesToAdd.length; i++) {
        final xfile = filesToAdd[i];
        updated = addPhoto(
          currentPhotos: updated,
          photoUrl: xfile.path,
        );
      }
      return updated;
    } catch (_) {
      // Graceful fallback to single image picker on platforms where multi-pick is unsupported
      try {
        final XFile? singleFile =
            await _picker.pickImage(source: ImageSource.gallery);
        if (singleFile != null) {
          return addPhoto(
            currentPhotos: currentPhotos,
            photoUrl: singleFile.path,
          );
        }
      } catch (_) {}
      return currentPhotos;
    }
  }

  @override
  Future<List<ProfilePhotoModel>> pickPhotoFromCamera({
    required List<ProfilePhotoModel> currentPhotos,
  }) async {
    if (currentPhotos.length >= maxPhotosAllowed) {
      return currentPhotos;
    }

    try {
      final XFile? file = await _picker.pickImage(source: ImageSource.camera);
      if (file != null) {
        return addPhoto(
          currentPhotos: currentPhotos,
          photoUrl: file.path,
        );
      }
    } catch (_) {}
    return currentPhotos;
  }

  @override
  List<ProfilePhotoModel> addPhoto({
    required List<ProfilePhotoModel> currentPhotos,
    required String photoUrl,
  }) {
    if (currentPhotos.length >= maxPhotosAllowed) {
      return currentPhotos;
    }

    final newPhoto = ProfilePhotoModel(
      id: 'photo_${DateTime.now().microsecondsSinceEpoch}_${currentPhotos.length}',
      url: photoUrl,
      isPrimary: currentPhotos.isEmpty,
      order: currentPhotos.length,
    );

    return [...currentPhotos, newPhoto];
  }

  @override
  List<ProfilePhotoModel> removePhoto({
    required List<ProfilePhotoModel> currentPhotos,
    required String photoId,
  }) {
    final updated = currentPhotos.where((p) => p.id != photoId).toList();

    // If we removed the primary photo, assign the first remaining photo as primary
    if (updated.isNotEmpty && !updated.any((p) => p.isPrimary)) {
      updated[0] = updated[0].copyWith(isPrimary: true);
    }

    // Re-index orders
    return updated.asMap().entries.map((e) {
      return e.value.copyWith(order: e.key);
    }).toList();
  }

  @override
  List<ProfilePhotoModel> setPrimaryPhoto({
    required List<ProfilePhotoModel> currentPhotos,
    required String photoId,
  }) {
    return currentPhotos.map((photo) {
      return photo.copyWith(isPrimary: photo.id == photoId);
    }).toList();
  }

  @override
  List<ProfilePhotoModel> reorderPhotos({
    required List<ProfilePhotoModel> currentPhotos,
    required int oldIndex,
    required int newIndex,
  }) {
    final list = List<ProfilePhotoModel>.from(currentPhotos);
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    final item = list.removeAt(oldIndex);
    list.insert(newIndex, item);

    return list.asMap().entries.map((e) {
      return e.value.copyWith(order: e.key);
    }).toList();
  }
}
