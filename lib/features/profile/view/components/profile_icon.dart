import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:venturo_core/constants/core/assets/image_constant.dart';
import 'package:venturo_core/features/profile/controllers/profile_controller.dart';
import 'package:venturo_core/shared/styles/color_style.dart';
import 'package:flutter_conditional_rendering/conditional.dart';

Widget buildProfileIcon(BuildContext context) {
  return Center(
    child: Container(
      width: 170.r,
      height: 170.r,
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(shape: BoxShape.circle),
      child: Stack(
        children: [
          Obx(
            () => Conditional.single(
              context: context,
              conditionBuilder: (context) =>
                  ProfileController.to.imageFile != null,
              widgetBuilder: (context) => Image.file(
                ProfileController.to.imageFile!,
                width: 170.r,
                height: 170.r,
                fit: BoxFit.cover,
              ),
              fallbackBuilder: (context) => Image.asset(
                ImageConstant.bgProfile,
                width: 170.r,
                height: 170.r,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Material(
              color: ColorStyle.primary,
              child: InkWell(
                onTap: ProfileController.to.pickImage,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 10.r, bottom: 15.r),
                  child: Text(
                    "Ubah".tr,
                    style: Get.textTheme.labelLarge!
                        .copyWith(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    ),
  );
}