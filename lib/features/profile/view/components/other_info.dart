import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:venturo_core/features/profile/controllers/profile_controller.dart';
import 'package:venturo_core/features/profile/view/components/info_row.dart';

Widget buildOtherInfo() {
  return Container(
    padding: EdgeInsets.all(16.r),
    decoration: BoxDecoration(
      color: Colors.white,
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
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildInfoRow(
          'Kebijakan Privasi'.tr,
          '',
          onPressed: ProfileController.to.privacyPolicyWebView,
        ),
        const Divider(),
        Obx(() {
          return buildInfoRow(
            'Model Perangkat'.tr,
            ProfileController.to.deviceModel.value,
          );
        }),
        const Divider(),
        Obx(() {
          return buildInfoRow(
            'Versi Android'.tr,
            ProfileController.to.deviceVersion.value,
          );
        }),
      ],
    ),
  );
}
