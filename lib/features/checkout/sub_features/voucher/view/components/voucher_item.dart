import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:venturo_core/features/checkout/sub_features/voucher/controllers/voucher_controller.dart';
import 'package:venturo_core/shared/styles/color_style.dart';
import 'package:venturo_core/features/checkout/controllers/checkout_controller.dart';

class VoucherItem extends StatelessWidget {
  final Map<String, dynamic> voucher;

  const VoucherItem({required this.voucher, super.key});

  @override
  Widget build(BuildContext context) {
    final CheckoutController checkoutController = Get.find();
    final VoucherController voucherController = Get.find();

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: ColorStyle.tertiary,
        borderRadius: BorderRadius.circular(20.r),
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
          Padding(
            padding: EdgeInsets.only(left: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    voucher['nama'],
                    style: Get.textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                Obx(() {
                  final isSelected = voucherController.selectedVoucherId ==
                      voucher['id_voucher'] as int?;
                  return Checkbox(
                    value: isSelected,
                    onChanged: (value) {
                      voucherController.selectVoucher(voucher);
                      if (isSelected) {
                        checkoutController.applyVoucher(null);
                      } else {
                        checkoutController.applyVoucher(voucher);
                      }
                    },
                  );
                }),
              ],
            ),
          ),
          Container(
            height: 180.h,
            width: Get.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(111, 24, 24, 24),
                  blurRadius: 8,
                  spreadRadius: -1,
                  offset: Offset(0, 1),
                ),
              ],
              image: DecorationImage(
                image: CachedNetworkImageProvider(voucher['info_voucher']),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}