import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:venturo_core/shared/styles/color_style.dart';

Widget buildTouchableDetailRow(BuildContext context, String title, String value,
    VoidCallback onTap, IconData icon,
    {Color? textColor, String? subtitle}) {
  return GestureDetector(
    onTap: onTap,
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(icon, color: ColorStyle.primary),
                  SizedBox(width: 8.w),
                  Text(
                    title,
                    style: Get.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        value,
                        style: Get.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                      if (subtitle != null)
                        Padding(
                          padding: EdgeInsets.only(top: 4.h),
                          child: Text(
                            subtitle,
                            style: Get.textTheme.bodySmall?.copyWith(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(width: 4.w),
                  Icon(Icons.arrow_forward_ios, size: 16.r, color: Colors.grey),
                ],
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
