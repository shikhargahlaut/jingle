import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/dating_preference_model.dart';
import '../../../data/models/profile_photo_model.dart';
import '../../../data/models/media_connection_model.dart';
import '../../../data/services/photo_service.dart';
import '../../../data/services/media_service.dart';
import '../../../data/repositories/media_repository.dart';
import '../../authentication/controllers/auth_controller.dart';
import '../../../app/routes/app_routes.dart';

/// GetX controller managing Dating Preferences, Photos (up to 6), Bio, and Media Connections.
class DatingProfileController extends GetxController {
  final PhotoService _photoService = DefaultPhotoService();
  final MediaRepository _mediaRepository = Get.put<MediaRepository>(
    DefaultMediaService(),
    permanent: true,
  );

  // Observable state
  final Rxn<GenderIdentity> selectedGender = Rxn<GenderIdentity>();
  final Rxn<LookingFor> selectedLookingFor = Rxn<LookingFor>();
  final Rxn<RelationshipStatus> selectedStatus = Rxn<RelationshipStatus>();
  final Rxn<RelationshipIntent> selectedIntent = Rxn<RelationshipIntent>();

  final RxList<ProfilePhotoModel> photos = <ProfilePhotoModel>[].obs;
  final RxList<MediaConnectionModel> mediaConnections =
      <MediaConnectionModel>[].obs;

  final TextEditingController bioTextController = TextEditingController();
  final RxInt bioCharCount = 0.obs;
  final RxBool isLoading = false.obs;
  final RxString connectingPlatform = ''.obs;

  static const int maxBioLength = 300;
  static const int maxPhotosAllowed = 6;

  @override
  void onInit() {
    super.onInit();
    _loadInitialUserData();
    _loadMediaConnections();

    bioTextController.addListener(() {
      bioCharCount.value = bioTextController.text.length;
    });
  }

  @override
  void onClose() {
    bioTextController.dispose();
    super.onClose();
  }

  void _loadInitialUserData() {
    final authCtrl = Get.find<AuthController>();
    final user = authCtrl.currentUser.value;
    if (user != null) {
      if (user.datingPreferences != null) {
        selectedGender.value = user.datingPreferences!.gender;
        selectedLookingFor.value = user.datingPreferences!.lookingFor;
        selectedStatus.value = user.datingPreferences!.relationshipStatus;
        selectedIntent.value = user.datingPreferences!.relationshipIntent;
      }
      if (user.photos.isNotEmpty) {
        photos.assignAll(user.photos);
      } else if (user.imageUrl.isNotEmpty) {
        photos.assignAll([
          ProfilePhotoModel(
            id: 'photo_main',
            url: user.imageUrl,
            isPrimary: true,
            order: 0,
          ),
        ]);
      }
      if (user.bio.isNotEmpty) {
        bioTextController.text = user.bio;
        bioCharCount.value = user.bio.length;
      }
    }
  }

  Future<void> _loadMediaConnections() async {
    try {
      final list = await _mediaRepository.getMediaConnections();
      mediaConnections.assignAll(list);
    } catch (_) {}
  }

  void setGender(GenderIdentity gender) {
    selectedGender.value = gender;
  }

  void setLookingFor(LookingFor lookingFor) {
    selectedLookingFor.value = lookingFor;
  }

  void setStatus(RelationshipStatus status) {
    selectedStatus.value = status;
  }

  void setIntent(RelationshipIntent intent) {
    selectedIntent.value = intent;
  }

  Future<void> pickPhotosFromGallery() async {
    if (photos.length >= maxPhotosAllowed) {
      Get.snackbar(
        'Photo Limit Reached',
        'You can add up to a maximum of $maxPhotosAllowed photos.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    final updated = await _photoService.pickPhotosFromGallery(
      currentPhotos: photos.toList(),
    );
    photos.assignAll(updated);
  }

  Future<void> pickPhotoFromCamera() async {
    if (photos.length >= maxPhotosAllowed) {
      Get.snackbar(
        'Photo Limit Reached',
        'You can add up to a maximum of $maxPhotosAllowed photos.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    final updated = await _photoService.pickPhotoFromCamera(
      currentPhotos: photos.toList(),
    );
    photos.assignAll(updated);
  }

  void addPhoto(String url) {
    if (photos.length >= maxPhotosAllowed) {
      Get.snackbar(
        'Photo Limit Reached',
        'You can add up to a maximum of $maxPhotosAllowed photos.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    final updated = _photoService.addPhoto(
      currentPhotos: photos.toList(),
      photoUrl: url,
    );
    photos.assignAll(updated);
  }

  void removePhoto(String photoId) {
    final updated = _photoService.removePhoto(
      currentPhotos: photos.toList(),
      photoId: photoId,
    );
    photos.assignAll(updated);
  }

  void setPrimaryPhoto(String photoId) {
    final updated = _photoService.setPrimaryPhoto(
      currentPhotos: photos.toList(),
      photoId: photoId,
    );
    photos.assignAll(updated);
  }

  void reorderPhotos(int oldIndex, int newIndex) {
    final updated = _photoService.reorderPhotos(
      currentPhotos: photos.toList(),
      oldIndex: oldIndex,
      newIndex: newIndex,
    );
    photos.assignAll(updated);
  }

  Future<void> toggleMediaConnection(MediaPlatform platform) async {
    try {
      connectingPlatform.value = platform.name;
      final existingIndex =
          mediaConnections.indexWhere((c) => c.platform == platform);

      if (existingIndex != -1 &&
          mediaConnections[existingIndex].status ==
              ConnectionStatus.connected) {
        await _mediaRepository.disconnectPlatform(platform);
        mediaConnections[existingIndex] = MediaConnectionModel(
          platform: platform,
          status: ConnectionStatus.disconnected,
        );
      } else {
        final connected = await _mediaRepository.connectPlatform(platform);
        if (existingIndex != -1) {
          mediaConnections[existingIndex] = connected;
        } else {
          mediaConnections.add(connected);
        }
      }
    } catch (e) {
      Get.snackbar(
        'Connection Failed',
        'Could not connect to ${platform.displayName}. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      connectingPlatform.value = '';
    }
  }

  Future<void> saveAndProceedToMedia() async {
    await _saveProfileState();
    Get.toNamed(AppRoutes.mediaConnections);
  }

  Future<void> saveAndCompleteOnboarding() async {
    isLoading.value = true;
    try {
      await _saveProfileState();
      if (Get.isRegistered<AuthController>()) {
        final authCtrl = Get.find<AuthController>();
        await authCtrl.completeOnboarding();
      }
      Get.offAllNamed(AppRoutes.mainApp);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> saveProfileAndReturn() async {
    isLoading.value = true;
    try {
      await _saveProfileState();
      Get.back();
      Get.snackbar(
        'Profile Updated',
        'Your dating preferences & profile have been saved!',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _saveProfileState() async {
    final authCtrl = Get.find<AuthController>();
    final currentUser = authCtrl.currentUser.value;
    if (currentUser == null) return;

    final primaryUrl = photos.isNotEmpty
        ? (photos.firstWhereOrNull((p) => p.isPrimary)?.url ?? photos.first.url)
        : currentUser.imageUrl;

    final preferences = DatingPreferenceModel(
      gender: selectedGender.value,
      lookingFor: selectedLookingFor.value,
      relationshipStatus: selectedStatus.value,
      relationshipIntent: selectedIntent.value,
    );

    final updated = currentUser.copyWith(
      imageUrl: primaryUrl,
      bio: bioTextController.text.trim(),
      photos: photos.toList(),
      datingPreferences: preferences,
      mediaConnections: mediaConnections.toList(),
    );

    await authCtrl.updateUserProfile(updated);
  }
}
