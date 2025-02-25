import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:venturo_core/constants/core/assets/image_constant.dart';
import 'package:venturo_core/features/profile/controllers/profile_controller.dart';
import 'package:venturo_core/shared/styles/color_style.dart';
import 'package:venturo_core/shared/widgets/tile_option.dart';
import 'package:venturo_core/shared/widgets/bottom_navbar.dart';
import 'package:flutter_conditional_rendering/conditional.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(68.h),
        child: SafeArea(
          child: Container(
            width: double.infinity,
            height: 68.h,
            padding: EdgeInsets.symmetric(vertical: 10.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.vertical(bottom: Radius.circular(30.r)),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(111, 24, 24, 24),
                  blurRadius: 15,
                  spreadRadius: -1,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: const Icon(Icons.chevron_left),
                    onPressed: () => Get.back(),
                  ),
                ),
                Center(
                  child: Text(
                    'Profile'.tr,
                    style: Get.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold, color: ColorStyle.primary),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageConstant.bgPattern2),
            fit: BoxFit.fitHeight,
            alignment: Alignment.center,
          ),
        ),
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 25.r),
          children: [
            /// Profile Icon
            Center(
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
                              "Change".tr,
                              style: Get.textTheme.labelMedium!
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
            ),
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
      ),
      bottomNavigationBar: BottomNavbar(),
    );
  }
}
