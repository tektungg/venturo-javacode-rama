import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:venturo_core/features/list/view/components/menu_item.dart';
import 'package:venturo_core/shared/styles/color_style.dart';

Widget buildCategorySection(
    String title, List<Map<String, dynamic>> items, IconData icon) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Row(
          children: [
            Icon(icon, color: ColorStyle.primary),
            SizedBox(width: 8.w),
            Text(
              title,
              style: Get.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: ColorStyle.primary,
              ),
            ),
          ],
        ),
      ),
      for (var item in items) buildMenuItem(item),
    ],
  );
}