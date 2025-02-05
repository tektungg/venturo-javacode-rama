import 'dart:async';
import 'package:get/get.dart';
import 'package:venturo_core/configs/routes/route.dart';

class SplashController extends GetxController {
  static SplashController get to => Get.find();

  @override
  void onInit() {
    super.onInit();
    _navigateToSignIn();
  }

  void _navigateToSignIn() {
    Timer(const Duration(seconds: 3), () {
      Get.offAllNamed(Routes.signInRoute);
    });
  }
}