import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:venturo_core/features/order/sub_features/detail_order/view/components/detail_order_menu_card.dart';
import 'package:venturo_core/shared/styles/color_style.dart';

class CategorySection extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> items;

  const CategorySection({
    Key? key,
    required this.title,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    IconData icon;
    switch (title.toLowerCase()) {
      case 'makanan':
        icon = Icons.local_dining;
        break;
      case 'minuman':
        icon = Icons.local_drink;
        break;
      case 'snack':
        icon = Icons.kebab_dining;
        break;
      default:
        icon = Icons.category;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Row(
            children: [
              Icon(icon, color: ColorStyle.primary),
              SizedBox(width: 8.w),
              Text(
                title.capitalizeFirst!,
                style: Get.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: ColorStyle.primary,
                ),
              ),
            ],
          ),
        ),
        for (var item in items)
          Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: DetailOrderMenuCard(menu: item, jumlah: item['jumlah']),
          ),
      ],
    );
  }
}