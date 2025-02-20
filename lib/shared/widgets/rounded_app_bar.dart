import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:venturo_core/shared/styles/color_style.dart';

class RoundedAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? svgPicture;
  final double? heightSvg, widthSvg;
  final IconData? iconData;
  final VoidCallback? onBackPressed;
  final List<Widget>? actions;
  final Widget? titleWidget;
  final bool? enableBackButton;
  final TextStyle? textStyle;

  const RoundedAppBar({
    super.key,
    required this.title,
    this.iconData,
    this.onBackPressed,
    this.heightSvg,
    this.widthSvg,
    this.actions,
    this.svgPicture,
    this.titleWidget,
    this.enableBackButton,
    this.textStyle
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 2,
      centerTitle: true,
      backgroundColor: ColorStyle.white,
      actions: actions,
      title: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          if (iconData != null)
            Icon(
              iconData,
              size: 28.r,
              color: Theme.of(context).primaryColor,
            ),

          if (svgPicture != null)
            SvgPicture.asset(
              svgPicture!,
              width: widthSvg,
              height: heightSvg,
              color: Theme.of(context).primaryColor,
            ),

          if (iconData != null || svgPicture != null) 10.horizontalSpaceRadius,

          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title.tr,
                style: textStyle ?? Get.textTheme.titleMedium!.copyWith(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),

              if (titleWidget != null) 10.verticalSpace,
              if (titleWidget != null) titleWidget!,
            ],
          ),
        ],
      ),

      leading: (enableBackButton == true) ? IconButton(
        onPressed: onBackPressed ?? () => Get.back(closeOverlays: true),
        icon: Icon(
          Icons.chevron_left,
          color: ColorStyle.black,
          size: 36.r,
        ),
      ) : null,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30.r)
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}