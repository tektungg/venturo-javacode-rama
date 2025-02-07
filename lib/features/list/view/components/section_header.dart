import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    this.color,
    required this.title,
    this.icon,
  });

  final String title;
  final Color? color;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(icon,
              size: 28.r, color: color ?? Theme.of(context).primaryColor),
          10.horizontalSpace,
          Text(
            title,
            style: Get.textTheme.titleMedium?.copyWith(
              color: color,
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
