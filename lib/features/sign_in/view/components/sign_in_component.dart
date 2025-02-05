// filepath: /D:/Kuliah/Magang/Venturo/venturo-core/lib/features/sign_in/view/components/sign_in_component.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:venturo_core/features/sign_in/controllers/sign_in_controller.dart';
import 'package:venturo_core/shared/customs/text_form_field_custom.dart';

class FormSignInCompoent extends StatelessWidget {
  const FormSignInCompoent({super.key});

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
        ],
      ),
    );
  }
}