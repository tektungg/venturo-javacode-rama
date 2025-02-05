import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:venturo_core/shared/styles/color_style.dart';
import 'package:venturo_core/shared/styles/google_text_style.dart';

class TextFormFieldCustoms extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String? initialValue;
  final String label;
  final String hint;
  final bool isPassword;
  final bool isRequired;
  final String requiredText;
  final int? maxLength;
  final Widget? suffixIcon;

  const TextFormFieldCustoms({
    super.key,
    required this.controller,
    required this.keyboardType,
    this.initialValue,
    required this.label,
    required this.hint,
    this.isPassword = false,
    this.isRequired = false,
    this.requiredText = 'Input type tidak boleh kosong',
    this.maxLength,
    this.suffixIcon
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label,
          style: GoogleTextStyle.fw400.copyWith(
            fontSize: 14.sp,
            color: ColorStyle.dark,
          ),
        ),

        TextFormField(
          keyboardType: keyboardType,
          obscureText: isPassword,
          maxLength: maxLength,
          initialValue: initialValue,
          onChanged: (text) {
            controller.text = text;
          },

          validator: (String? value) {
            if (isRequired == true) {
              String trim = value!.trim();
              if (trim.isEmpty) {
                return requiredText;
              }
            }

            return null;
          },

          style: GoogleTextStyle.fw400.copyWith(
            fontSize: 14.sp,
            color: ColorStyle.dark,
          ),

          decoration: InputDecoration(
            hintText: hint,
            suffixIcon: suffixIcon,
            counterText: "",
            hintStyle: GoogleTextStyle.fw400.copyWith(
              fontSize: 14.sp,
              color: ColorStyle.secondary,
            ),

            border: const UnderlineInputBorder(
              borderSide: BorderSide(width: 1, color: ColorStyle.secondary),
            ),

            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(width: 1, color: ColorStyle.secondary),
            ),

            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(width: 1, color: ColorStyle.primary),
            ),
          ),
        ),
      ],
    );
  }
}