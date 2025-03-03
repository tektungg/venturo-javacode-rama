import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:venturo_core/features/checkout/controllers/checkout_controller.dart';
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
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 24.r,
              height: 24.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: ColorStyle.primary, width: 2),
              ),
              child: Icon(
                Icons.check,
                color: ColorStyle.primary,
                size: 16.r,
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: RichText(
                text: TextSpan(
                  text: 'Penggunaan voucher tidak dapat digabung dengan '.tr,
                  style:
                      Get.textTheme.titleSmall?.copyWith(color: Colors.black),
                  children: [
                    TextSpan(
                      text: 'discount employee reward program.'.tr,
                      style: Get.textTheme.titleSmall
                          ?.copyWith(color: ColorStyle.primary),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        SizedBox(
          width: Get.width,
          child: ElevatedButton(
            onPressed: () {
              if (controller.selectedVoucher.value == null) {
                CheckoutController.to.applyVoucher(null); 
              }
              Get.back(result: controller.selectedVoucher.value);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorStyle.primary,
              padding: EdgeInsets.symmetric(vertical: 12.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.r),
              ),
            ),
            child: Text(
              'Oke'.tr,
              style: Get.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}