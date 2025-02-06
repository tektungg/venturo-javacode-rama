import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';
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
    _initializeGetLocationController();
  }

  void _getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    deviceModel.value = androidInfo.model;
    deviceVersion.value = androidInfo.version.release;
  }

  void _initializeGetLocationController() {
    Get.lazyPut(() => GetLocationController());
    GetLocationController.to.getLocation();
  }

  void privacyPolicyWebView() {
    Get.toNamed(Routes.privacyPolicyRoute);
  }
}
