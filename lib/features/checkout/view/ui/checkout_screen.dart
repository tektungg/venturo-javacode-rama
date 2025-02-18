import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:venturo_core/features/checkout/controllers/checkout_controller.dart';
import 'package:venturo_core/features/checkout/sub_features/discount/controllers/discount_controller.dart';
import 'package:venturo_core/features/checkout/view/components/category_section.dart';
import 'package:venturo_core/features/checkout/view/components/checkout_widgets.dart';

class CheckoutScreen extends StatelessWidget {
  CheckoutScreen({super.key});

  final CheckoutController checkoutController = Get.put(CheckoutController());
  final DiscountController discountController = Get.put(DiscountController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Obx(() {
        if (checkoutController.menuList.isEmpty) {
          return buildEmptyCart();
        }

        final groupedMenu = checkoutController.groupedMenuByCategory;

        return Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.all(16.r),
                    itemCount: groupedMenu.keys.length,
                    itemBuilder: (context, index) {
                      String category = groupedMenu.keys.elementAt(index);
                      List<Map<String, dynamic>> menus = groupedMenu[category]!;
                      return buildCategorySection(category, menus);
                    },
                  ),
                ),
                buildSummarySection(context, checkoutController),
              ],
            ),
            buildBottomBar(checkoutController),
          ],
        );
      }),
    );
  }
}