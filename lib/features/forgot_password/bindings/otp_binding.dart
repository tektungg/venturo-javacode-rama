import 'package:get/get.dart';
import 'package:venturo_core/features/forgot_password/controllers/otp_controller.dart';

class OtpBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(OtpController());
  }
}
