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
                          child: buildCategorySection(category, menus),
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

  Widget buildCategorySection(String title, List<Map<String, dynamic>> items) {
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
