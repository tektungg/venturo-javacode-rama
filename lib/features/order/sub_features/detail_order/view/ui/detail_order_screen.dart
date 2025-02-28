import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:get/get.dart';
import 'package:venturo_core/features/order/sub_features/detail_order/controllers/detail_order_controller.dart';
import 'package:venturo_core/features/order/sub_features/detail_order/view/components/build_category_section.dart';
import 'package:venturo_core/features/order/sub_features/detail_order/view/components/build_summary_section.dart';
import 'package:venturo_core/features/order/sub_features/detail_order/view/components/cancel_order_dialog.dart';
import 'package:venturo_core/shared/widgets/bottom_navbar.dart';
import 'package:venturo_core/shared/widgets/rounded_app_bar.dart';

class DetailOrderScreen extends StatelessWidget {
  const DetailOrderScreen({super.key});

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  Widget build(BuildContext context) {
    analytics.setCurrentScreen(
      screenName: 'Detail Order Screen',
      screenClassOverride: 'Trainee',
    );

    final DetailOrderController controller = DetailOrderController.to;

    return Scaffold(
      appBar: RoundedAppBar(
        title: 'Pesanan',
        iconData: Icons.room_service,
        enableBackButton: true,
        onBackPressed: () => Get.back(),
        actions: [
          Obx(() => Conditional.single(
                context: context,
                conditionBuilder: (context) =>
                    controller.order.value?['status'] == 0,
                widgetBuilder: (context) => Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 16.h, horizontal: 10.w),
                  child: TextButton(
                    onPressed: () {
                      final orderId = controller.order.value?['id_order'];
                      if (orderId != null) {
                        showCancelOrderConfirmationDialog(orderId);
                      }
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                    ),
                    child: Text(
                      'Cancel'.tr,
                      style: Get.textTheme.labelLarge
                          ?.copyWith(color: const Color(0xFFD81D1D)),
                    ),
                  ),
                ),
                fallbackBuilder: (context) => const SizedBox(),
              )),
        ],
      ),
      body: Obx(
        () {
          if (controller.orderDetailState.value == 'loading') {
            return const Center(child: CircularProgressIndicator());
          } else if (controller.orderDetailState.value == 'error') {
            return const Center(child: Text('Error loading order details'));
          } else {
            final order = controller.order.value!;
            final foodItems = controller.foodItems;
            final drinkItems = controller.drinkItems;
            final snackItems = controller.snackItems;
            final totalItems =
                foodItems.length + drinkItems.length + snackItems.length;

            final groupedMenu = controller.groupMenuByCategory(
                foodItems, drinkItems, snackItems);

            return Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: ListView.builder(
                      itemCount: groupedMenu.keys.length,
                      itemBuilder: (context, index) {
                        String category = groupedMenu.keys.elementAt(index);
                        List<Map<String, dynamic>> menus =
                            groupedMenu[category]!;
                        return Padding(
                          padding: EdgeInsets.only(bottom: 4.h),
                          child: CategorySection(title: category, items: menus),
                        );
                      },
                    ),
                  ),
                ),
                SummarySection(totalItems: totalItems, order: order),
              ],
            );
          }
        },
      ),
      bottomNavigationBar: BottomNavbar(),
    );
  }
}