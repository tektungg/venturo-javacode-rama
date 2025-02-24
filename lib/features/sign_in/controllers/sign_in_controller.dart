import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:venturo_core/configs/routes/route.dart';
import 'package:venturo_core/constants/core/api/api_constant.dart';
import 'package:venturo_core/shared/controllers/global_controllers.dart';
import 'package:venturo_core/shared/styles/color_style.dart';
import 'package:venturo_core/shared/styles/google_text_style.dart';
import 'package:logger/logger.dart';
import 'package:venturo_core/features/sign_in/repositories/sign_in_repository.dart';

class SignInController extends GetxController {
  static SignInController get to => Get.find();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final Logger logger = Logger();

  /// Form Variable Setting
  var formKey = GlobalKey<FormState>();
  var emailCtrl = TextEditingController();
  var emailValue = "".obs;
  var passwordCtrl = TextEditingController();
  var passwordValue = "".obs;
  var isPassword = true.obs;
  var isRememberMe = false.obs;

  @override
  void onInit() {
    super.onInit();
    try {
      logger.d('Initializing SignInController');
    } catch (e) {
      logger.e('Error in SignInController onInit');
    }
  }

  /// Form Password Show
  void showPassword() {
    isPassword.value = !isPassword.value;
  }

  /// Form Validate & Submited
  void validateForm(context) async {
    try {
      await GlobalController.to.checkConnection(Routes.signInRoute);

      var isValid = formKey.currentState!.validate();
      Get.focusScope!.unfocus();

      if (isValid && GlobalController.to.isConnect.value == true) {
        EasyLoading.show(
          status: 'Sedang Diproses...',
          maskType: EasyLoadingMaskType.black,
          dismissOnTap: false,
        );

        formKey.currentState!.save();
        try {
          // ignore: unused_local_variable
          final response =
              await SignInRepository.instance.signInWithEmailAndPassword(
            emailCtrl.text,
            passwordCtrl.text,
          );
          EasyLoading.dismiss();
          _saveSession();
          Get.offAllNamed(Routes.listRoute);
        } catch (e) {
          EasyLoading.dismiss();
          PanaraInfoDialog.show(
            context,
            title: "Warning",
            message: "Email & Password Salah",
            buttonText: "Coba lagi",
            onTapDismiss: () {
              Get.back();
            },
            panaraDialogType: PanaraDialogType.warning,
            barrierDismissible: false,
          );
        }
      } else if (GlobalController.to.isConnect.value == false) {
        Get.toNamed(Routes.noConnectionRoute);
      }
    } catch (e) {
      logger.e('Error in validateForm');
      EasyLoading.dismiss();
      PanaraInfoDialog.show(
        context,
        title: "Error",
        message: "An error occurred while validating the form",
        buttonText: "Coba lagi",
        onTapDismiss: () {
          Get.back();
        },
        panaraDialogType: PanaraDialogType.error,
        barrierDismissible: false,
      );
    }
  }

  /// Google Sign-In
  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        // The user canceled the sign-in
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _auth.signInWithCredential(credential);
      _saveSession();
      Get.offAllNamed(Routes.listRoute);
    } catch (e) {
      logger.e('Error in signInWithGoogle');
      Get.snackbar("Error", "Failed to sign in with Google: $e",
          duration: const Duration(seconds: 2));
    }
  }

  /// Save session status
  void _saveSession() {
    try {
      var box = Hive.box('venturo');
      box.put('isLoggedIn', true);
      logger.d('Session saved successfully');
    } catch (e) {
      logger.e('Error in _saveSession');
    }
  }

  /// Flavor setting
  void flavorSeting() async {
    try {
      logger.d('Opening flavor setting');
      Get.bottomSheet(
        Obx(
          () => Wrap(
            children: [
              Container(
                width: double.infinity.w,
                padding: EdgeInsets.symmetric(
                  horizontal: 5.w,
                  vertical: 5.h,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: ColorStyle.white,
                ),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      onTap: () {
                        GlobalController.to.isStaging.value = false;
                        GlobalController.to.baseUrl = ApiConstant.production;
                      },
                      title: Text(
                        "Production",
                        style: GoogleTextStyle.fw400.copyWith(
                          color: GlobalController.to.isStaging.value == true
                              ? ColorStyle.dark
                              : ColorStyle.primary,
                          fontSize: 14.sp,
                        ),
                      ),
                      trailing: GlobalController.to.isStaging.value == true
                          ? null
                          : Icon(
                              Icons.check,
                              color: ColorStyle.primary,
                              size: 14.sp,
                            ),
                    ),
                    Divider(
                      height: 1.h,
                    ),
                    ListTile(
                      onTap: () {
                        GlobalController.to.isStaging.value = true;
                        GlobalController.to.baseUrl = ApiConstant.staging;
                      },
                      title: Text(
                        "Staging",
                        style: GoogleTextStyle.fw400.copyWith(
                          color: GlobalController.to.isStaging.value == true
                              ? ColorStyle.primary
                              : ColorStyle.dark,
                          fontSize: 14.sp,
                        ),
                      ),
                      trailing: GlobalController.to.isStaging.value == true
                          ? Icon(
                              Icons.check,
                              color: ColorStyle.primary,
                              size: 14.sp,
                            )
                          : null,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    } catch (e) {
      logger.e('Error in flavorSeting');
    }
  }
}
