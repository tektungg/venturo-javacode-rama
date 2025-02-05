import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:venturo_core/configs/routes/route.dart';
import 'package:venturo_core/features/sign_in/controllers/sign_in_controller.dart';
import 'package:venturo_core/shared/customs/text_form_field_custom.dart';
import 'package:venturo_core/shared/styles/color_style.dart';
import 'package:venturo_core/shared/styles/google_text_style.dart';

class FormSignInComponent extends StatelessWidget {
  const FormSignInComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: SignInController.to.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextFormFieldCustoms(
            controller: SignInController.to.emailCtrl,
            keyboardType: TextInputType.emailAddress,
            initialValue: SignInController.to.emailValue.value,
            label: "Email Address",
            hint: "Masukkan alamat email",
            isRequired: true,
            requiredText: "Alamat email tidak boleh kosong",
          ),
          SizedBox(
            height: 40.h,
          ),
          Obx(
            () => TextFormFieldCustoms(
              controller: SignInController.to.passwordCtrl,
              keyboardType: TextInputType.visiblePassword,
              initialValue: SignInController.to.passwordValue.value,
              label: "Password",
              hint: "Masukkan password",
              isPassword: SignInController.to.isPassword.value,
              isRequired: true,
              requiredText: "Password tidak boleh kosong",
              suffixIcon: IconButton(
                icon: Icon(
                  SignInController.to.isPassword.value
                      ? Icons.visibility
                      : Icons.visibility_off,
                ),
                onPressed: () {
                  SignInController.to.showPassword();
                },
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  Get.toNamed(Routes.forgotPasswordRoute);
                },
                child: Text(
                  "Lupa Password?",
                  style: GoogleTextStyle.fw600.copyWith(
                    fontSize: 14.sp,
                    color: ColorStyle.primary,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}