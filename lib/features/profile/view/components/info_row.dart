import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:venturo_core/features/profile/controllers/profile_controller.dart';

Widget buildInfoRow(String title, String value,
    [String? key, VoidCallback? onPressed]) {
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
                  _showEditDialog(title, value, key);
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

void _showEditDialog(String title, String currentValue, String key) {
  final TextEditingController controller =
      TextEditingController(text: currentValue);
  Get.defaultDialog(
    title: 'Edit $title',
    content: Column(
      children: [
        TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: title,
          ),
        ),
        SizedBox(height: 20.h),
        ElevatedButton(
          onPressed: () {
            ProfileController.to.updateUserProfile(key, controller.text);
            Get.back();
          },
          child: const Text('Save'),
        ),
      ],
    ),
  );
}