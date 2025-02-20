import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional_switch.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:venturo_core/features/order/controllers/order_controller.dart';
import 'package:venturo_core/features/order/view/components/order_list_sliver.dart';

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
      body: RefreshIndicator(
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
              'success': (context) => CustomScrollView(
                    slivers: [
                      SliverPadding(
                        padding: EdgeInsets.all(16.r),
                        sliver: OrderListSliver(
                          orders: OrderController.to.filteredHistoryOrder,
                        ),
                      ),
                    ],
                  ),
            },
            fallbackBuilder: (context) => const Center(
              child: Text('Unknown state'),
            ),
          ),
        ),
      ),
    );
  }
}
