import 'dart:async';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:logger/logger.dart';
import 'package:venturo_core/configs/routes/route.dart';

class SplashController extends GetxController {
  static SplashController get to => Get.find();
  final Logger logger = Logger();

  @override
  void onInit() {
    super.onInit();
    try {
      logger.d('Initializing SplashController');
      _navigateBasedOnSession();
    } catch (e) {
      logger.e('Error in SplashController onInit');
    }
  }

  void _navigateBasedOnSession() async {
    try {
      await Future.delayed(
          const Duration(seconds: 3)); 

      var box = Hive.box('venturo');
      bool isLoggedIn = box.get('isLoggedIn', defaultValue: false);

      if (isLoggedIn) {
        logger.d('User is logged in, navigating to list route');
        Get.offAllNamed(
            Routes.listRoute); 
      } else {
        logger.d('User is not logged in, navigating to sign-in route');
        Get.offAllNamed(Routes
            .signInRoute); 
      }
    } catch (e) {
      logger.e('Error in _navigateBasedOnSession');
    }
  }
}