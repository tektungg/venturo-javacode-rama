import 'dart:async';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:venturo_core/configs/routes/route.dart';

class SplashController extends GetxController {
  static SplashController get to => Get.find();

  @override
  void onInit() {
    super.onInit();
    _navigateBasedOnSession();
  }

  void _navigateBasedOnSession() async {
    await Future.delayed(
        const Duration(seconds: 3)); // Simulate a delay for the splash screen

    var box = Hive.box('venturo');
    bool isLoggedIn = box.get('isLoggedIn', defaultValue: false);

    if (isLoggedIn) {
      Get.offAllNamed(
          Routes.listRoute); // Navigate to the profile screen if logged in
    } else {
      Get.offAllNamed(Routes
          .signInRoute); // Navigate to the sign-in screen if not logged in
    }
  }
}
