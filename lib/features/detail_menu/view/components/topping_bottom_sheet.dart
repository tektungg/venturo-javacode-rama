import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:venturo_core/features/detail_menu/controllers/detail_menu_controller.dart';

void showToppingBottomSheet(BuildContext context, DetailMenuController controller) {
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
                width: 155.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 7.r),
              child: Text(
                'Pilih Topping',
                style: Get.textTheme.headline6?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Obx(() {
              if (controller.toppings.isEmpty) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 7.r),
                  child: Text(
                    'Menu ini tidak memiliki pilihan topping',
                    style: Get.textTheme.bodyMedium,
                  ),
                );
              }
              return Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: controller.toppings.map((topping) {
                  final isSelected = controller.selectedToppings.contains(topping['keterangan']);
                  return ChoiceChip(
                    label: Text(topping['keterangan']),
                    selected: isSelected,
                    onSelected: (selected) {
                      if (isSelected) {
                        controller.selectedToppings.remove(topping['keterangan']);
                      } else {
                        controller.selectedToppings.add(topping['keterangan']);
                      }
                      controller.updateTotalPrice();
                    },
                    selectedColor: Theme.of(context).primaryColor,
                    backgroundColor: Colors.grey[200],
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                    avatar: isSelected ? Icon(Icons.check, color: Colors.white) : null,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.r),
                      side: BorderSide(
                        color: isSelected ? Colors.transparent : Theme.of(context).primaryColor,
                      ),
                    ),
                  );
                }).toList(),
              );
            }),
          ],
        ),
      );
    },
  );
}