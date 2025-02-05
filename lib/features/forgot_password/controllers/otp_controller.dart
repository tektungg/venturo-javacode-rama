import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpController extends GetxController {
  static OtpController get to => Get.find();
  final RxString email = "".obs;
  late TextEditingController otpTextController;

  @override
  void onInit() {
    otpTextController = TextEditingController();
    email.value = Get.arguments != null ? Get.arguments as String : "";
    super.onInit();
  }

  @override
  void onClose() {
    otpTextController.dispose();
    super.onClose();
  }

  void onOtpComplete(String value) {
    if (value == "1234") {
      Get.snackbar("Sukses", "Kode Otp Valid",
          duration: const Duration(seconds: 1));
    }
  }
}