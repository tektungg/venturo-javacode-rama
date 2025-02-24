import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:venturo_core/shared/styles/color_style.dart';

class OutlinedTitleButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final VisualDensity? visualDensity;
  final bool isCompact;
  final double? width;
  final double? height;

  const OutlinedTitleButton({
    super.key,
    required this.text,
    this.onPressed,
    this.visualDensity,
    this.width,
    this.height,
  }) : isCompact = false;

  const OutlinedTitleButton.compact({
    super.key,
    required this.text,
    this.onPressed,
    this.visualDensity,
    this.width,
    this.height,
  }) : isCompact = true;

  @override
  Widget build(BuildContext context) {
    final double fontSize = (height != null && height! <= 30.h) ? 14.sp : 16.sp;
    final EdgeInsetsGeometry padding = (height != null && height! <= 30.h)
        ? EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h)
        : EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h);

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        visualDensity: visualDensity,
        backgroundColor: Colors.white,
        maximumSize: Size(width ?? 1.sw, height ?? 56.h),
        elevation: 3,
        textStyle: GoogleFonts.montserrat(
          fontSize: fontSize,
          fontWeight: FontWeight.w800,
          height: 1.219,
        ),
        tapTargetSize: isCompact ? MaterialTapTargetSize.shrinkWrap : null,
        minimumSize:
            isCompact ? Size(100.w, 30.h) : Size(width ?? 1.sw, height ?? 56.h),
        padding: padding,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: ColorStyle.primary, width: 1),
          borderRadius: BorderRadius.circular(25.r),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
