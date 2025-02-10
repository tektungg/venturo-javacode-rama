// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional_switch.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:venturo_core/constants/core/assets/image_constant.dart';
import 'package:venturo_core/features/get_location/controllers/get_location_controller.dart';
import 'package:venturo_core/shared/styles/color_style.dart';
import 'package:app_settings/app_settings.dart';

class GetLocationScreen extends StatelessWidget {
  const GetLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GetLocationController controller = Get.put(GetLocationController());

    return Scaffold(
      body: WillPopScope(
        onWillPop: () async => false,
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(ImageConstant.bgPattern2),
              fit: BoxFit.fitHeight,
              alignment: Alignment.center,
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 30.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(() {
                if (controller.statusLocation.value == 'request_permission') {
                  return Column(
                    children: [
                      Text(
                        'Izin Diperlukan'.tr,
                        style: Get.textTheme.titleLarge!
                            .copyWith(color: ColorStyle.dark.withOpacity(0.5)),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 50.h),
                      Stack(
                        children: [
                          ClipOval(
                            child: Opacity(
                              opacity: 0.15,
                              child: Image.asset(
                                ImageConstant.location,
                                width: 190.r,
                                height: 190.r,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(70.r),
                            child: Opacity(
                              opacity: 0.8,
                              child: Icon(
                                Icons.location_pin,
                                size: 50.r,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 50.h),
                      Text(
                        'Aplikasi ini membutuhkan akses lokasi untuk digunakan.'
                            .tr,
                        textAlign: TextAlign.center,
                        style: Get.textTheme.bodyLarge!
                            .copyWith(color: ColorStyle.dark.withOpacity(0.7)),
                      ),
                      SizedBox(height: 24.h),
                      ElevatedButton(
                        onPressed: controller.requestPermission,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorStyle.primary,
                          elevation: 2,
                          padding: EdgeInsets.symmetric(
                              horizontal: 24.w, vertical: 12.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24.r),
                          ),
                        ),
                        child: Text(
                          'Berikan Izin'.tr,
                          style: Get.textTheme.bodyLarge!
                              .copyWith(color: ColorStyle.white),
                        ),
                      ),
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      Text(
                        'Mencari lokasi...'.tr,
                        style: Get.textTheme.titleLarge!
                            .copyWith(color: ColorStyle.dark.withOpacity(0.5)),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 50.h),
                      Stack(
                        children: [
                          ClipOval(
                            child: Opacity(
                              opacity: 0.15,
                              child: Image.asset(
                                ImageConstant.location,
                                width: 190.r,
                                height: 190.r,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(70.r),
                            child: Opacity(
                              opacity: 0.8,
                              child: Icon(
                                Icons.location_pin,
                                size: 50.r,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 50.h),
                      Obx(
                        () => ConditionalSwitch.single<String>(
                          context: context,
                          valueBuilder: (context) =>
                              controller.statusLocation.value,
                          caseBuilders: {
                            'error': (context) => Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      controller.messageLocation.value,
                                      style: Get.textTheme.titleLarge,
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(height: 24.h),
                                    ElevatedButton(
                                      onPressed: () =>
                                          AppSettings.openAppSettings(),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        elevation: 2,
                                        padding: EdgeInsets.zero,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(24.r),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.settings,
                                            color: ColorStyle.dark,
                                          ),
                                          SizedBox(width: 16.w),
                                          Text(
                                            'Buka pengaturan'.tr,
                                            style: Get.textTheme.bodySmall,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                            'success': (context) => Text(
                                  controller.address.value!,
                                  style: Get.textTheme.titleLarge,
                                  textAlign: TextAlign.center,
                                ),
                          },
                          fallbackBuilder: (context) =>
                              const CircularProgressIndicator(
                            color: ColorStyle.primary,
                          ),
                        ),
                      ),
                    ],
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}