import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:venturo_core/configs/routes/route.dart';
import 'package:venturo_core/features/get_location/view/ui/get_location_screen.dart';
import 'package:venturo_core/utils/services/location_service.dart';

class GetLocationController extends GetxController {
  static GetLocationController get to => Get.find();

  /// Location
  RxString statusLocation = RxString('request_permission');
  RxString messageLocation = RxString('');
  Rxn<Position> position = Rxn<Position>();
  RxnString address = RxnString();
  bool locationObtained = false;

  Future<void> requestPermission() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      statusLocation.value = 'loading';
      getLocation();
    } else {
      Get.snackbar("Izin Ditolak", "Izin lokasi diperlukan untuk melanjutkan.");
    }
  }

  Future<void> getLocation() async {
    if (locationObtained) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (Get.isDialogOpen == false) {
        Get.dialog(const GetLocationScreen(), barrierDismissible: false);
      }
    });

    try {
      /// Mendapatkan Lokasi saat ini
      statusLocation.value = 'loading';
      final locationResult = await LocationServices.getCurrentPosition();

      if (locationResult.success) {
        /// Jika jarak lokasi cukup dekat, dapatkan informasi alamat
        position.value = locationResult.position;
        address.value = locationResult.address;
        statusLocation.value = 'success';
        locationObtained = true;

        await Future.delayed(const Duration(seconds: 1));
        Get.offAllNamed(Routes.profileRoute);
      } else {
        /// Jika jarak lokasi tidak cukup dekat, tampilkan pesan
        statusLocation.value = 'error';
        messageLocation.value = locationResult.message!;
      }
    } catch (e) {
      /// Jika terjadi kesalahan server
      statusLocation.value = 'error';
      messageLocation.value = 'Kesalahan server'.tr;
    }
  }
}