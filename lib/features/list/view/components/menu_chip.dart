import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MenuChip extends StatelessWidget {
  final bool isSelected;
  final String text;
  final Function()? onTap;

  const MenuChip({
    super.key,
    this.isSelected = false,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30.r),
      child: Ink(
        padding: EdgeInsets.symmetric(horizontal: 14.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.r),
          color: isSelected ? Theme.of(context).primaryColor : Colors.grey,
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, 2),
              blurRadius: 8,
              spreadRadius: -1,
              color: Colors.black54,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Text(
              text,
              style: Get.textTheme.bodyLarge!.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
