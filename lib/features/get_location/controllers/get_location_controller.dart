import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:venturo_core/features/get_location/view/ui/get_location_screen.dart';
import 'package:venturo_core/utils/services/location_service.dart';
import 'package:venturo_core/configs/routes/route.dart';

class GetLocationController extends GetxController {
  static GetLocationController get to => Get.find();

  /// Location
  RxString statusLocation = RxString('request_permission');
  RxString messageLocation = RxString('');
  Rxn<Position> position = Rxn<Position>();
  RxnString address = RxnString();
  bool locationObtained = false; // Flag to check if location has been obtained
  final Logger logger = Logger();

  Future<void> requestPermission() async {
    try {
      logger.d('Requesting location permission');
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {
        statusLocation.value = 'loading';
        getLocation();
      } else {
        Get.snackbar("Izin Ditolak", "Izin lokasi diperlukan untuk melanjutkan.");
        logger.d('Location permission denied');
      }
    } catch (e) {
      logger.e('Error in requestPermission');
    }
  }

  Future<void> getLocation() async {
    if (locationObtained) return; // If location is already obtained, return

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (Get.isDialogOpen == false) {
        Get.dialog(const GetLocationScreen(), barrierDismissible: false);
      }
    });

    try {
      logger.d('Getting current location');
      /// Mendapatkan Lokasi saat ini
      statusLocation.value = 'loading';
      final locationResult = await LocationServices.getCurrentPosition();

      if (locationResult.success) {
        /// Jika jarak lokasi cukup dekat, dapatkan informasi alamat
        position.value = locationResult.position;
        address.value = locationResult.address;
        statusLocation.value = 'success';
        locationObtained = true; // Set the flag to true

        await Future.delayed(const Duration(seconds: 1));
        Get.offAllNamed(
            Routes.listRoute); // Navigate to profile screen directly
        logger.d('Location obtained successfully');
      } else {
        /// Jika jarak lokasi tidak cukup dekat, tampilkan pesan
        statusLocation.value = 'error';
        messageLocation.value = locationResult.message!;
        logger.d('Location error: ${locationResult.message}');
      }
    } catch (e) {
      /// Jika terjadi kesalahan server
      statusLocation.value = 'error';
      messageLocation.value = 'Kesalahan server'.tr;
      logger.e('Error in getLocation');
    }
  }
}