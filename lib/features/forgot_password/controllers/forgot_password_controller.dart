import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  static ForgotPasswordController get to => Get.find();

  final TextEditingController emailCtrl = TextEditingController();
  var formKey = GlobalKey<FormState>();

  var emailValue = "".obs;
}
