import 'package:get/get.dart';
import 'package:venturo_core/features/sign_in/controllers/sign_in_controller.dart';

class SignInBindding implements Bindings {
  @override
  void dependencies() {
    Get.put(SignInController());
  }
}
