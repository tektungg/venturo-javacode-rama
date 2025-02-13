import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:venturo_core/configs/routes/route.dart';
import 'package:venturo_core/features/checkout/controllers/checkout_controller.dart';
import 'package:venturo_core/shared/styles/color_style.dart';

class CheckoutFAB extends StatelessWidget {
  const CheckoutFAB({super.key});

  @override
  Widget build(BuildContext context) {
    final CheckoutController controller = Get.find();

    return Stack(
      children: [
        Positioned(
          bottom: 50.h, // Adjust this value to move the FAB upwards
          right: 16.w,
          child: FloatingActionButton(
            onPressed: () {
              Get.toNamed(Routes.checkoutRoute);
            },
            backgroundColor: ColorStyle.primary,
            child: const Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
          ),
        ),
        Positioned(
          bottom: 50.h + 28.r, // Adjust this value to match the FAB position
          right: 0.w + 28.r,
          child: Obx(() {
            int itemCount = controller.menuList.length;
            return itemCount > 0
                ? Container(
                    padding: EdgeInsets.all(6.r),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '$itemCount',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : Container();
          }),
        ),
      ],
    );
  }
}
