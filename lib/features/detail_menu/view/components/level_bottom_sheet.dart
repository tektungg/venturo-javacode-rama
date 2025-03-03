import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:venturo_core/features/detail_menu/controllers/detail_menu_controller.dart';
import 'package:venturo_core/utils/functions/string_utils.dart' as string_utils;

void showLevelBottomSheet(
    BuildContext context, DetailMenuController controller) {
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
                'Pilih Level'.tr,
                style: Get.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Obx(() {
              if (controller.levels.isEmpty) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 7.r),
                  child: Text(
                    'Menu ini tidak memiliki pilihan level'.tr,
                    style: Get.textTheme.bodyMedium,
                  ),
                );
              }
              return Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: controller.levels.map((level) {
                  final isSelected =
                      controller.selectedLevel.value == level['keterangan'];
                  return ChoiceChip(
                    showCheckmark: false,
                    label: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(string_utils.capitalize(level['keterangan'])),
                        if (isSelected)
                          Padding(
                            padding: EdgeInsets.only(left: 4.w),
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 16.r,
                            ),
                          ),
                      ],
                    ),
                    selected: isSelected,
                    onSelected: (selected) {
                      if (isSelected) {
                        controller.selectedLevel.value = '';
                      } else {
                        controller.selectedLevel.value = level['keterangan'];
                      }
                      controller.updateTotalPrice();
                    },
                    selectedColor: Theme.of(context).primaryColor,
                    backgroundColor: Colors.grey[200],
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.r),
                      side: BorderSide(
                        color: isSelected
                            ? Colors.transparent
                            : Theme.of(context).primaryColor,
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
