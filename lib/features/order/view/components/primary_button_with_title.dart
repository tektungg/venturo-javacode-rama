import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:venturo_core/shared/styles/color_style.dart';

class PrimaryButtonWithTitle extends StatelessWidget {
  final VoidCallback? onPressed;
  final String title;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? titleColor;
  final bool isLoading;
  final VisualDensity? visualDensity;
  final bool isCompact;
  final double? width;
  final double? height;

  const PrimaryButtonWithTitle(
      {super.key,
      this.onPressed,
      required this.title,
      this.backgroundColor,
      this.borderColor,
      this.titleColor,
      this.isLoading = false,
      this.visualDensity,
      this.width,
      this.height})
      : isCompact = false;

  const PrimaryButtonWithTitle.compact(
      {super.key,
      this.onPressed,
      required this.title,
      this.backgroundColor,
      this.borderColor,
      this.titleColor,
      this.isLoading = false,
      this.width,
      this.height})
      : isCompact = true,
        visualDensity = VisualDensity.compact;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 2,
        backgroundColor: ColorStyle.primary,
        maximumSize: isCompact
            ? Size(width ?? 100.w, height ?? 30.h)
            : Size(
                width ?? 1.sw,
                height ?? 56.h,
              ),
        side: const BorderSide(color: ColorStyle.primary),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.r)),
        tapTargetSize: isCompact ? MaterialTapTargetSize.shrinkWrap : null,
        minimumSize: isCompact
            ? Size(width ?? 100.w, height ?? 30.h)
            : Size(
                width ?? 1.sw,
                height ?? 56.h,
              ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (!isLoading)
            Text(
              title,
              textAlign: TextAlign.center,
              style: Get.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w800,
                fontSize: isCompact ? 10.sp : 14.sp,
                color: titleColor ?? Colors.white,
              ),
            ),
          isLoading ? 15.horizontalSpace : 0.horizontalSpace,
          isLoading
              ? SizedBox(
                  height: 15,
                  width: 15,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.w,
                    color: titleColor ?? Colors.white,
                  ),
                )
              : 0.horizontalSpace,
        ],
      ),
    );
  }
}
