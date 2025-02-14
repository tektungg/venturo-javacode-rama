import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class OtpController extends GetxController {
  static OtpController get to => Get.find();
  final RxString email = "".obs;
  late TextEditingController otpTextController;
  final Logger logger = Logger();

  @override
  void onInit() {
    super.onInit();
    try {
      logger.d('Initializing OtpController');
      otpTextController = TextEditingController();
      email.value = Get.arguments != null ? Get.arguments as String : "";
    } catch (e) {
      logger.e('Error in OtpController onInit');
    }
  }

  @override
  void onClose() {
    try {
      otpTextController.dispose();
      super.onClose();
    } catch (e) {
      logger.e('Error in OtpController onClose');
    }
  }

  void onOtpComplete(String value) {
    try {
      if (value == "1234") {
        Get.snackbar("Sukses", "Kode Otp Valid",
            duration: const Duration(seconds: 1));
        logger.d('OTP is valid');
      } else {
        logger.d('OTP is invalid');
      }
    } catch (e) {
      logger.e('Error in onOtpComplete');
    }
  }
}