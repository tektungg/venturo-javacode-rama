import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:venturo_core/configs/routes/route.dart';
import 'package:venturo_core/shared/styles/color_style.dart';
import 'package:venturo_core/shared/widgets/image_picker_dialog.dart';
import 'package:venturo_core/features/profile/repositories/profile_repository.dart';

class ProfileController extends GetxController {
  static ProfileController get to => Get.find();
  final RxString deviceModel = ''.obs;
  final RxString deviceVersion = ''.obs;
  final Logger logger = Logger();

  final Rx<File?> _imageFile = Rx<File?>(null);
  final RxMap<String, dynamic> userProfile = RxMap<String, dynamic>({});

  File? get imageFile => _imageFile.value;

  @override
  void onInit() {
    super.onInit();
    try {
      logger.d('Initializing ProfileController');
      _getDeviceInfo();
      fetchUserProfile();
    } catch (e) {
      logger.e('Error in ProfileController onInit');
    }
  }

  void _getDeviceInfo() async {
    try {
      logger.d('Getting device info');
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceModel.value = androidInfo.model;
      deviceVersion.value = androidInfo.version.release;
      logger.d(
          'Device info fetched successfully: Model - ${deviceModel.value}, Version - ${deviceVersion.value}');
    } catch (e) {
      logger.e('Error in _getDeviceInfo');
    }
  }

  void privacyPolicyWebView() {
    try {
      logger.d('Navigating to privacy policy web view');
      Get.toNamed(Routes.privacyPolicyRoute);
    } catch (e) {
      logger.e('Error in privacyPolicyWebView');
    }
  }

  /// Pilih image untuk update photo
  Future<void> pickImage() async {
    /// Buka dialog untuk sumber gambar
    ImageSource? imageSource = await Get.defaultDialog<ImageSource>(
      title: '',
      titleStyle: const TextStyle(fontSize: 0),
      content: const ImagePickerDialog(),
    );

    /// pengecekan sumber gambar
    if (imageSource == null) return;

    final pickedFile = await ImagePicker().pickImage(
      source: imageSource,
      maxWidth: 300,
      maxHeight: 300,
      imageQuality: 75,
    );

    /// setelah dipilih, akan terbuka crop gambar
    if (pickedFile != null) {
      _imageFile.value = File(pickedFile.path);
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: _imageFile.value!.path,
        aspectRatio: const CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Cropper'.tr,
            toolbarColor: ColorStyle.primary,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true,
          ),
        ],
      );

      /// Jika gambar telah dipilih, maka akan dimasukkan ke variabel image file, karena ini masih menggunakan local file
      if (croppedFile != null) {
        _imageFile.value = File(croppedFile.path);
      }
    }
  }

  Future<void> fetchUserProfile() async {
    try {
      var box = Hive.box('venturo');
      int userId = box.get('userId');
      logger.d('Fetching user profile for user ID: $userId');
      final profileData =
          await ProfileRepository.instance.getUserProfile(userId);
      userProfile.value = profileData;
      logger.d('User profile fetched successfully: $profileData');
    } catch (e) {
      logger.e('Error in fetchUserProfile: $e');
    }
  }

  Future<void> updateUserProfile(String key, String value) async {
    try {
      var box = Hive.box('venturo');
      int userId = box.get('userId');
      logger.d('Updating user profile for user ID: $userId');
      userProfile[key] = value;
      await ProfileRepository.instance.updateUserProfile(userId, userProfile);
      logger.d('User profile updated successfully');
    } catch (e) {
      logger.e('Error in updateUserProfile: $e');
    }
  }
}