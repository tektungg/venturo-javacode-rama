import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:get/get.dart';
import 'package:venturo_core/features/order/sub_features/detail_order/controllers/detail_order_controller.dart';
import 'package:venturo_core/features/order/sub_features/detail_order/view/components/detail_order_menu_card.dart';
import 'package:venturo_core/shared/styles/color_style.dart';
import 'package:venturo_core/shared/widgets/bottom_navbar.dart';
import 'package:venturo_core/shared/widgets/rounded_app_bar.dart';
import 'package:venturo_core/features/order/sub_features/detail_order/view/components/order_tracker.dart';

class DetailOrderScreen extends StatelessWidget {
  const DetailOrderScreen({super.key});

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  Widget build(BuildContext context) {
    analytics.setCurrentScreen(
      screenName: 'Detail Order Screen',
      screenClassOverride: 'Trainee',
    );

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
                    DetailOrderController.to.order.value?['status'] == 0,
                widgetBuilder: (context) => Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 16.h, horizontal: 10.w),
                  child: TextButton(
                    onPressed: () {},
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
          if (DetailOrderController.to.orderDetailState.value == 'loading') {
            return const Center(child: CircularProgressIndicator());
          } else if (DetailOrderController.to.orderDetailState.value ==
              'error') {
            return const Center(child: Text('Error loading order details'));
          } else {
            final order = DetailOrderController.to.order.value!;
            final foodItems = DetailOrderController.to.foodItems;
            final drinkItems = DetailOrderController.to.drinkItems;
            final totalItems = foodItems.length + drinkItems.length;

            return Column(
              children: [
                SizedBox(height: 16.h),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: ListView.builder(
                      itemCount: totalItems,
                      itemBuilder: (context, index) {
                        final item = index < foodItems.length
                            ? foodItems[index]
                            : drinkItems[index - foodItems.length];
                        return Padding(
                          padding: EdgeInsets.only(bottom: 8.h),
                          child: DetailOrderMenuCard(
                            menu: item,
                            jumlah: item['jumlah'],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(16.r),
                  decoration: BoxDecoration(
                    color: ColorStyle.tertiary,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20.r)),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0, -2),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total Pesanan ($totalItems Menu)'),
                          Text(
                            'Rp ${order['total_bayar']}',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                          ),
                        ],
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Potongan'),
                          Text(
                            'Rp ${order['potongan'] ?? 0}',
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                      const Divider(),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Pembayaran'),
                          Text('Pay Later'),
                        ],
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Total Pembayaran'),
                          Text(
                            'Rp ${order['total_bayar'] - (order['potongan'] ?? 0)}',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                          ),
                        ],
                      ),
                      const Divider(),
                      const OrderTracker(),
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
      bottomNavigationBar: BottomNavbar(),
    );
  }
}
