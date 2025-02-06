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
    return Scaffold(
      body: WillPopScope(
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
              Text(
                'Searching location...'.tr,
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
                      GetLocationController.to.statusLocation.value,
                  caseBuilders: {
                    'error': (context) => Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              GetLocationController.to.messageLocation.value,
                              style: Get.textTheme.titleLarge,
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 24.h),
                            ElevatedButton(
                              onPressed: () => AppSettings.openAppSettings(),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                elevation: 2,
                                padding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24.r),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.settings,
                                    color: ColorStyle.dark,
                                  ),
                                  SizedBox(width: 16.w),
                                  Text(
                                    'Open settings'.tr,
                                    style: Get.textTheme.bodySmall,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                    'success': (context) => Text(
                          GetLocationController.to.address.value!,
                          style: Get.textTheme.titleLarge,
                          textAlign: TextAlign.center,
                        ),
                  },
                  fallbackBuilder: (context) => const CircularProgressIndicator(
                    color: ColorStyle.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
        onWillPop: () async => false,
      ),
    );
  }
}
