import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PromoAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PromoAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(68.h),
      child: SafeArea(
        child: Container(
          width: double.infinity,
          height: 68.h,
          padding: EdgeInsets.symmetric(vertical: 10.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30.r)),
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(111, 24, 24, 24),
                blurRadius: 15,
                spreadRadius: -1,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(Icons.chevron_left),
                  onPressed: () => Get.back(),
                ),
              ),
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.local_play,
                      color: Theme.of(context).primaryColor,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'Promo',
                      style: Get.textTheme.titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(68.h);
}
