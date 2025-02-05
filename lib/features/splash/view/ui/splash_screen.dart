import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:venturo_core/features/splash/constants/splash_assets_constant.dart';
import 'package:venturo_core/features/splash/controllers/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);

  final assetsConstant = SplashAssetsConstant();

  @override
  Widget build(BuildContext context) {
    // Initialize SplashController
    Get.put(SplashController());

    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/logo.png',
          width: 300,
        ),
      ),
    );
  }
}