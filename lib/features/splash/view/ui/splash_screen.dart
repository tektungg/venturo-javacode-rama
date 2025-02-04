import 'package:flutter/material.dart';
import 'package:venturo_core/features/splash/constants/splash_assets_constant.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);

  final assetsConstant = SplashAssetsConstant();

  @override
  Widget build(BuildContext context) {
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
