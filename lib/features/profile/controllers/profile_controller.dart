import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:venturo_core/configs/routes/route.dart';
import 'package:venturo_core/features/get_location/controllers/get_location_controller.dart';

class ProfileController extends GetxController {
  static ProfileController get to => Get.find();
  final RxString deviceModel = ''.obs;
  final RxString deviceVersion = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _getDeviceInfo();
    _checkLocationPermission();
  }

  void _getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    deviceModel.value = androidInfo.model;
    deviceVersion.value = androidInfo.version.release;
  }

  void _checkLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      Get.toNamed(Routes.getLocationRoute);
    } else {
      if (!GetLocationController.to.locationObtained) {
        _initializeGetLocationController();
      }
    }
  }

  void _initializeGetLocationController() {
    if (!Get.isRegistered<GetLocationController>()) {
      Get.put(GetLocationController());
    }
    if (!GetLocationController.to.locationObtained) {
      GetLocationController.to.getLocation();
    }
  }

  void privacyPolicyWebView() {
    Get.toNamed(Routes.privacyPolicyRoute);
  }
}
