import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:venturo_core/features/checkout/sub_features/voucher/controllers/voucher_controller.dart';
import 'package:venturo_core/shared/styles/color_style.dart';

Widget buildVoucherBottomBar(VoucherController controller) {
  return Container(
    width: Get.width,
    padding: EdgeInsets.all(16.r),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
      boxShadow: const [
        BoxShadow(
          color: Color.fromARGB(111, 24, 24, 24),
          blurRadius: 4,
          spreadRadius: -1,
          offset: Offset(0, 1),
        ),
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RichText(
          text: TextSpan(
            text: 'Penggunaan ',
            style: Get.textTheme.titleMedium?.copyWith(color: Colors.black),
            children: [
              TextSpan(
                text: 'Voucher',
                style: Get.textTheme.titleMedium?.copyWith(color: ColorStyle.primary),
              ),
            ],
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Get.back(result: controller.selectedVouchers);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorStyle.primary,
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.r),
            ),
          ),
          child: Text(
            'Oke',
            style: Get.textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
}