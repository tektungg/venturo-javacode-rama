import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:venturo_core/features/profile/view/components/edit_bottom_sheet.dart';

Widget buildInfoRow(String title, String value,
    {String? key, VoidCallback? onPressed}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: Get.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
      ),
      Row(
        children: [
          Text(
            value,
            style: Get.textTheme.bodyMedium,
          ),
          if (key != null || onPressed != null)
            IconButton(
              icon: const Icon(Icons.chevron_right),
              onPressed: () {
                if (key != null) {
                  showEditBottomSheet(Get.context!, title, value, key);
                } else if (onPressed != null) {
                  onPressed();
                }
              },
            ),
        ],
      ),
    ],
  );
}