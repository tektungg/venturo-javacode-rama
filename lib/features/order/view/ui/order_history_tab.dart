import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:venturo_core/configs/routes/route.dart';
import 'package:venturo_core/features/order/controllers/order_controller.dart';
import 'package:venturo_core/features/order/view/components/order_item_card.dart';
import 'package:venturo_core/features/order/view/components/dropdown_status.dart';
import 'package:venturo_core/features/order/view/components/date_picker.dart';

class OrderHistoryTabScreen extends StatelessWidget {
  const OrderHistoryTabScreen({super.key});

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  Widget build(BuildContext context) {
    analytics.setCurrentScreen(
      screenName: 'Order History Screen',
      screenClassOverride: 'Trainee',
    );

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Row(
              children: [
                Expanded(
                  child: Obx(() {
                    return DropdownStatus(
                      items: OrderController.to.dateFilterStatus,
                      selectedItem: OrderController.to.selectedCategory.value,
                      onChanged: (value) {
                        if (value != null) {
                          OrderController.to.setDateFilter(category: value);
                        }
                      },
                    );
                  }),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Obx(() {
                    return DatePicker(
                      selectDate: OrderController.to.selectedDateRange.value,
                      onChanged: (dateRange) {
                        OrderController.to.setDateFilter(range: dateRange);
                      },
                    );
                  }),
                ),
              ],
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: OrderController.to.getOrderHistories,
              child: Obx(
                () => ConditionalSwitch.single(
                  context: context,
                  valueBuilder: (context) =>
                      OrderController.to.orderHistoryState.value,
                  caseBuilders: {
                    'loading': (context) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                    'empty': (context) => const Center(
                          child: Text('No order history available'),
                        ),
                    'error': (context) => const Center(
                          child: Text('Failed to load order history'),
                        ),
                    'success': (context) => ListView.builder(
                          padding: EdgeInsets.all(16.r),
                          itemCount:
                              OrderController.to.filteredHistoryOrder.length,
                          itemBuilder: (context, index) {
                            final order =
                                OrderController.to.filteredHistoryOrder[index];
                            return Padding(
                              padding: EdgeInsets.only(bottom: 16.r),
                              child: OrderItemCard(
                                order: order,
                                showButtons: true,
                                onTap: () => Get.toNamed(
                                  '${Routes.orderRoute}/${order['id_order']}',
                                ),
                                onOrderAgain: () {
                                  // Handle onOrderAgain
                                },
                                onGiveReview: (id) {
                                  // Handle onGiveReview
                                },
                              ),
                            );
                          },
                        ),
                  },
                  fallbackBuilder: (context) => const Center(
                    child: Text('Unknown state'),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
