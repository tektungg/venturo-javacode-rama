import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:venturo_core/features/order/sub_features/detail_order/controllers/detail_order_controller.dart';
import 'package:venturo_core/features/order/sub_features/detail_order/view/components/checked_step.dart';
import 'package:venturo_core/features/order/sub_features/detail_order/view/components/unchecked_step.dart';

class OrderTracker extends StatelessWidget {
  const OrderTracker({super.key});

  @override
  Widget build(BuildContext context) {
    final int? status = DetailOrderController.to.order.value?['status'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (status == 4) ...[
          Center(
            child: Column(
              children: [
                Icon(
                  Icons.sentiment_very_dissatisfied,
                  color: Colors.red,
                  size: 40.r,
                ),
                SizedBox(height: 8.h),
                Text(
                  'Pesanan kamu batalkan'.tr,
                  style: Get.textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ] else if (status == 3) ...[
          Center(
            child: Column(
              children: [
                Icon(
                  Icons.sentiment_very_satisfied,
                  color: Colors.green,
                  size: 40.r,
                ),
                SizedBox(height: 8.h),
                Text(
                  'Pesananmu sudah selesai!'.tr,
                  style: Get.textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ] else ...[
          Text(
            'Pesananmu sedang disiapkan:'.tr,
            style: Get.textTheme.titleMedium
                ?.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.left,
          ),
          18.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Spacer(flex: 10),
              Expanded(
                flex: 10,
                child: Conditional.single(
                  context: context,
                  conditionBuilder: (context) => status! >= 0,
                  widgetBuilder: (context) => const CheckedStep(),
                  fallbackBuilder: (context) => const UncheckedStep(),
                ),
              ),
              Expanded(
                flex: 35,
                child: Container(
                  height: 2.h,
                  color: status! >= 1 ? Get.theme.primaryColor : Colors.grey,
                ),
              ),
              Expanded(
                flex: 10,
                child: Conditional.single(
                  context: context,
                  conditionBuilder: (context) => status >= 1,
                  widgetBuilder: (context) => const CheckedStep(),
                  fallbackBuilder: (context) => const UncheckedStep(),
                ),
              ),
              Expanded(
                flex: 35,
                child: Container(
                  height: 2.h,
                  color: status >= 2 ? Get.theme.primaryColor : Colors.grey,
                ),
              ),
              Expanded(
                flex: 10,
                child: Conditional.single(
                  context: context,
                  conditionBuilder: (context) => status >= 2,
                  widgetBuilder: (context) => const CheckedStep(),
                  fallbackBuilder: (context) => const UncheckedStep(),
                ),
              ),
              const Spacer(flex: 10),
            ],
          ),
          18.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'Pesanan Diterima'.tr,
                  style: Get.textTheme.bodySmall,
                  textAlign: TextAlign.center,
                ),
              ),
              const Spacer(flex: 1),
              Expanded(
                flex: 2,
                child: Text(
                  'Menyiapkan'.tr,
                  style: Get.textTheme.bodySmall,
                  textAlign: TextAlign.center,
                ),
              ),
              const Spacer(flex: 1),
              Expanded(
                flex: 2,
                child: Text(
                  'Siap Diambil'.tr,
                  style: Get.textTheme.bodySmall,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}
