import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:venturo_core/features/profile/controllers/profile_controller.dart';
import 'package:venturo_core/features/profile/view/components/language_bottom_sheet.dart.dart';
import 'package:venturo_core/shared/styles/color_style.dart';
import 'package:venturo_core/features/profile/view/components/info_row.dart';

String getCurrentLanguage() {
  switch (Get.locale?.languageCode) {
    case 'en':
      return 'English';
    case 'id':
      return 'Indonesia';
    default:
      return 'Unknown';
  }
}

Widget buildAccountInfo() {
  return Container(
    padding: EdgeInsets.all(16.r),
    decoration: BoxDecoration(
      color: ColorStyle.white,
      borderRadius: BorderRadius.circular(10.r),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 10,
          spreadRadius: 1,
          offset: const Offset(0, 1),
        ),
      ],
    ),
    child: Obx(() {
      final profile = ProfileController.to.userProfile;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildInfoRow('Nama'.tr, profile['nama'] ?? 'N/A', key: 'nama'),
          const Divider(),
          buildInfoRow('Tanggal Lahir'.tr, profile['tgl_lahir'] ?? 'N/A',
              key: 'tgl_lahir'),
          const Divider(),
          buildInfoRow('No. Telepon'.tr, profile['telepon'] ?? 'N/A',
              key: 'telepon'),
          const Divider(),
          buildInfoRow('Email'.tr, profile['email'] ?? 'N/A', key: 'email'),
          const Divider(),
          buildInfoRow('PIN'.tr, profile['pin'] ?? 'N/A', key: 'pin'),
          const Divider(),
          buildInfoRow('Ganti Bahasa'.tr, getCurrentLanguage(), onPressed: () {
            showLanguageBottomSheet(Get.context!);
          }),
        ],
      );
    }),
  );
}
