import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:venturo_core/features/checkout/sub_features/discount/controllers/discount_controller.dart';
import 'package:venturo_core/features/checkout/sub_features/voucher/controllers/voucher_controller.dart';
import 'package:venturo_core/shared/styles/color_style.dart';

class DiscountScreen extends StatelessWidget {
  DiscountScreen({super.key});

  final DiscountController discountController = Get.put(DiscountController());
  final VoucherController voucherController = Get.put(VoucherController());

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Container(
        padding: EdgeInsets.all(16.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Info Diskon'.tr,
                style: Get.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold, color: ColorStyle.primary),
              ),
            ),
            SizedBox(height: 16.h),
            Obx(() {
              if (voucherController.selectedVoucher.value != null) {
                return Center(
                  child: Text(
                    'Anda tidak dapat menggunakan diskon dan voucher secara bersamaan'.tr,
                    style: Get.textTheme.bodyLarge?.copyWith(
                      color: Colors.red,
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
              } else {
                final discounts = discountController.discounts;
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: discounts.length,
                  itemBuilder: (context, index) {
                    final discount = discounts[index];
                    return ListTile(
                      title: Text(discount['nama']),
                      trailing: Text('${discount['diskon']}%'),
                    );
                  },
                );
              }
            }),
            SizedBox(height: 16.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Get.back();
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
      ),
    );
  }
}
