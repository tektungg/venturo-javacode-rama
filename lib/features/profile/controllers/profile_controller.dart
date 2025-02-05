import 'package:get/get.dart';
import 'package:venturo_core/configs/routes/route.dart';

class ProfileController extends GetxController {
  static ProfileController get to => Get.find();

  void privacyPolicyWebView() {
    Get.toNamed(Routes.privacyPolicyRoute);
  }
}
