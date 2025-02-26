import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:venturo_core/features/splash/constants/splash_assets_constant.dart';
import 'package:venturo_core/features/splash/controllers/splash_controller.dart';
import 'package:venturo_core/shared/controllers/global_controllers.dart';
import 'package:venturo_core/configs/routes/route.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final assetsConstant = SplashAssetsConstant();

  @override
  Widget build(BuildContext context) {
    // Initialize SplashController
    Get.put(SplashController());

    // Check connection when the splash screen is built
    _checkConnection();

    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/logo.png',
          width: 300,
        ),
      ),
    );
  }

  Future<void> _checkConnection() async {
    await GlobalController.to.checkConnection(Routes.splashRoute);
    if (GlobalController.to.isConnect.value) {
      // Navigate to the next screen if connected
      Get.offNamed(Routes.signInRoute);
    } else {
      // Navigate to the no connection screen if not connected
      Get.offNamed(Routes.noConnectionRoute);
    }
  }
}
