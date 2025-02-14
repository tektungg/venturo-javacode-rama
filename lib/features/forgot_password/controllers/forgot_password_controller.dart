import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class ForgotPasswordController extends GetxController {
  static ForgotPasswordController get to => Get.find();

  final TextEditingController emailCtrl = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var emailValue = "".obs;
  final Logger logger = Logger();

  @override
  void onInit() {
    super.onInit();
    try {
      logger.d('Initializing ForgotPasswordController');
    } catch (e) {
      logger.e('Error in ForgotPasswordController onInit');
    }
  }

  @override
  void onClose() {
    try {
      emailCtrl.dispose();
      super.onClose();
    } catch (e) {
      logger.e('Error in ForgotPasswordController onClose');
    }
  }
}
