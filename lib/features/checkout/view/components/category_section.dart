import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:venturo_core/shared/styles/color_style.dart';
import 'package:venturo_core/features/checkout/view/components/checkout_menu_card.dart';
import 'package:venturo_core/utils/functions/string_utils.dart';

Widget buildCategorySection(String title, List<Map<String, dynamic>> items) {
  IconData icon;
  switch (title.toLowerCase()) {
    case 'makanan':
      icon = Icons.local_dining;
      break;
    case 'minuman':
      icon = Icons.local_drink;
      break;
    case 'snack':
      icon = Icons.kebab_dining;
      break;
    default:
      icon = Icons.category;
  }

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
              capitalize(title.tr),
              style: Get.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: ColorStyle.primary,
              ),
            ),
          ],
        ),
      ),
      for (var item in items) CheckoutMenuCard(menu: item),
    ],
  );
}
