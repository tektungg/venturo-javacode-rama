import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:venturo_core/configs/routes/route.dart';

class ProfileController extends GetxController {
  static ProfileController get to => Get.find();
  final RxString deviceModel = ''.obs;
  final RxString deviceVersion = ''.obs;
  final Logger logger = Logger();

  @override
  void onInit() {
    super.onInit();
    try {
      logger.d('Initializing ProfileController');
      _getDeviceInfo();
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
      logger.d('Device info fetched successfully: Model - ${deviceModel.value}, Version - ${deviceVersion.value}');
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
}