import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:venturo_core/features/profile/constants/profile_assets_constant.dart';
import 'package:venturo_core/features/profile/controllers/profile_controller.dart';
import 'package:venturo_core/shared/widgets/tile_option.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  final assetsConstant = ProfileAssetsConstant();

  @override
  Widget build(BuildContext context) {
    Get.put(ProfileController());

    /// Google analytics untuk tracking user di setiap halaman
    if (Platform.isAndroid) {
      /// Tracking bawah dia masuk screen lupa password di device android
      analytics.logScreenView(
        screenName: 'Forgot Password Screen',
        screenClass: 'Android',
      );
    } else if (Platform.isIOS) {
      /// Tracking bawah dia masuk screen lupa password di device ios
      analytics.logScreenView(
        screenName: 'Forgot Password Screen',
        screenClass: 'IOS',
      );
    } else if (Platform.isMacOS) {
      /// Tracking bawah dia masuk screen lupa password di device macos
      analytics.logScreenView(
        screenName: 'Forgot Password Screen',
        screenClass: 'MacOS',
      );
    }

    if (kIsWeb) {
      /// Tracking bawah dia masuk screen lupa password di device web
      analytics.logScreenView(
        screenName: 'Forgot Password Screen',
        screenClass: 'Web',
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: ListView(
        children: [
          const Divider(),
          TileOption(
            title: 'Privacy Policy'.tr,
            message: 'Here',
            onTap: ProfileController.to.privacyPolicyWebView,
          ),
          const Divider(),
          Obx(() {
            return ListTile(
              title: Text(
                  'Device Model: ${ProfileController.to.deviceModel.value}'),
              subtitle: Text(
                  'Android Version: ${ProfileController.to.deviceVersion.value}'),
            );
          }),
        ],
      ),
    );
  }
}