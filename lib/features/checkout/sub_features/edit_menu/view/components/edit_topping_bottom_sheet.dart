import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:venturo_core/features/checkout/sub_features/edit_menu/controllers/edit_menu_controller.dart';

void showEditToppingBottomSheet(
    BuildContext context, EditMenuController controller) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    isDismissible: true,
    enableDrag: true,
    builder: (context) {
      return Container(
        padding: EdgeInsets.all(16.r),
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 7.r),
              child: Text(
                'Pilih Topping',
                style: Get.textTheme.headlineSmall
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 16.h),
            Obx(() {
              if (controller.toppings.isEmpty) {
                return Center(child: Text('No toppings available'));
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.toppings.length,
                  itemBuilder: (context, index) {
                    final topping = controller.toppings[index];
                    return CheckboxListTile(
                      title: Text(topping['keterangan']),
                      value: controller.selectedToppings.contains(topping['keterangan']),
                      onChanged: (bool? value) {
                        if (value == true) {
                          controller.selectedToppings.add(topping['keterangan']);
                        } else {
                          controller.selectedToppings.remove(topping['keterangan']);
                        }
                        controller.updateTotalPrice();
                      },
                    );
                  },
                );
              }
            }),
          ],
        ),
      );
    },
  );
}