import 'package:flutter/material.dart';
import 'package:venturo_core/features/profile/constants/profile_assets_constant.dart';
import 'package:venturo_core/features/profile/controllers/profile_controller.dart';
import 'package:venturo_core/shared/widgets/tile_option.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  final assetsConstant = ProfileAssetsConstant();

  @override
  Widget build(BuildContext context) {
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
        ],
      ),
    );
  }
}