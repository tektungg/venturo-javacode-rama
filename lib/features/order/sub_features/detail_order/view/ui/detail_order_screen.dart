import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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
                  width: Get.width,
                  padding: EdgeInsets.all(26.r),
                  decoration: BoxDecoration(
                    color: ColorStyle.tertiary,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(30.r)),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromARGB(111, 24, 24, 24),
                        blurRadius: 4,
                        spreadRadius: -1,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total Pesanan ($totalItems Menu)',
                            style: Get.textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Rp ${NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 0).format(order['total_bayar'])}',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.local_offer,
                                  color: ColorStyle.primary),
                              const SizedBox(width: 8),
                              Text(
                                'Potongan',
                                style: Get.textTheme.titleMedium
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Text(
                            '-Rp ${NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 0).format(order['potongan'] ?? 0)}',
                            style: const TextStyle(
                                color: Colors.red, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.payment,
                                  color: ColorStyle.primary),
                              const SizedBox(width: 8),
                              Text(
                                'Pembayaran',
                                style: Get.textTheme.titleMedium
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const Text('Pay Later'),
                        ],
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total Pembayaran',
                            style: Get.textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Rp ${NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 0).format(order['total_bayar'] - (order['potongan'] ?? 0))}',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold),
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
