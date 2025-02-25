import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:venturo_core/features/profile/controllers/profile_controller.dart';
import 'package:venturo_core/shared/styles/color_style.dart';

Widget buildLogoutButton() {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 25.r),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorStyle.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.r),
        ),
        padding: EdgeInsets.symmetric(vertical: 15.h),
      ),
      onPressed: () {
        ProfileController.to.logout();
      },
      child: Text(
        'Logout',
        style: Get.textTheme.button!.copyWith(color: Colors.white),
      ),
    ),
  );
}