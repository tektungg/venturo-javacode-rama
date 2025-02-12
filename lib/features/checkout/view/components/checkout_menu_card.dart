import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:venturo_core/shared/styles/color_style.dart';
import 'package:venturo_core/features/checkout/controllers/checkout_controller.dart';
import 'package:venturo_core/features/list/view/components/menu_card.dart';

class CheckoutMenuCard extends StatelessWidget {
  final Map<String, dynamic> menu;
  final CheckoutController controller = Get.find();

  CheckoutMenuCard({super.key, required this.menu});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MenuCard(
          menu: menu,
          isSelected: false,
          onTap: null,
        ),
        Positioned(
          right: 10.w,
          top: 38.h,
          child: Row(
            children: [
              // Decrement Button
              Container(
                width: 30.w,
                height: 30.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: ColorStyle.primary),
                  borderRadius: BorderRadius.circular(5.r),
                ),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: () {
                    if (menu['jumlah'] > 1) {
                      menu['jumlah']--;
                    } else {
                      controller.menuList.remove(menu);
                    }
                    controller.calculateTotal();
                  },
                  icon: const Icon(
                    Icons.remove,
                    color: ColorStyle.primary,
                    size: 15,
                  ),
                ),
              ),
              // Quantity Text
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                child: Text(
                  '${menu['jumlah']}',
                  style: Get.textTheme.bodyLarge,
                ),
              ),
              // Increment Button
              Container(
                width: 30.w,
                height: 30.h,
                decoration: BoxDecoration(
                  color: ColorStyle.primary,
                  border: Border.all(color: ColorStyle.primary),
                  borderRadius: BorderRadius.circular(5.r),
                ),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: () {
                    menu['jumlah']++;
                    controller.calculateTotal();
                  },
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 20.h,
          left: 111.w,
          child: Text(
            'Catatan: ${menu['catatan'] ?? 'Tidak ada catatan'}',
            style: Get.textTheme.bodySmall?.copyWith(
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
