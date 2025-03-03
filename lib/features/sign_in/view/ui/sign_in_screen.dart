import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:venturo_core/constants/core/assets/image_constant.dart';
import 'package:venturo_core/features/sign_in/controllers/sign_in_controller.dart';
import 'package:venturo_core/features/sign_in/view/components/sign_in_component.dart';
import 'package:venturo_core/shared/styles/color_style.dart';
import 'package:venturo_core/shared/styles/google_text_style.dart';
import 'package:get/get.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  Widget build(BuildContext context) {
    final SignInController controller = Get.put(SignInController());

    /// Google analytics untuk tracking user di setiap halaman
    if (Platform.isAndroid) {
      /// Tracking bawah dia masuk screen sign in di device android
      analytics.logScreenView(
        screenName: 'Sign In Screen',
        screenClass: 'Android',
      );
    } else if (Platform.isIOS) {
      /// Tracking bawah dia masuk screen sign in di device ios
      analytics.logScreenView(
        screenName: 'Sign In Screen',
        screenClass: 'IOS',
      );
    } else if (Platform.isMacOS) {
      /// Tracking bawah dia masuk screen sign in di device macos
      analytics.logScreenView(
        screenName: 'Sign In Screen',
        screenClass: 'MacOS',
      );
    }

    if (kIsWeb) {
      /// Tracking bawah dia masuk screen sign in di device web
      analytics.logScreenView(
        screenName: 'Sign In Screen',
        screenClass: 'Web',
      );
    }

    return Scaffold(
      appBar: null,
      extendBody: false,
      backgroundColor: ColorStyle.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(45),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 121.h),
              GestureDetector(
                onDoubleTap: () => controller.flavorSeting(),
                child: Image.asset(
                  ImageConstant.logo,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 121.h),
              Text(
                'Masuk untuk melanjutkan!'.tr,
                style: GoogleTextStyle.fw600.copyWith(
                  fontSize: 22.sp,
                  color: ColorStyle.dark,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40.h),
              const FormSignInComponent(),
              SizedBox(height: 40.h),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  backgroundColor: ColorStyle.primary,
                ),
                onPressed: () => controller.validateForm(context),
                child: Text(
                  "Masuk".tr,
                  style: GoogleTextStyle.fw800.copyWith(
                    fontSize: 14.sp,
                    color: ColorStyle.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20.h),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  backgroundColor: Colors.white,
                ),
                onPressed: () => controller.signInWithGoogle(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/icons/ic_google.png',
                      height: 24.0,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "Masuk dengan Google".tr,
                      style: GoogleTextStyle.fw800.copyWith(
                        fontSize: 14.sp,
                        color: ColorStyle.dark,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
