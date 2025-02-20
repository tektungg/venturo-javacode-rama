import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:venturo_core/features/order/view/components/detail_order_card.dart';

class OrderListSliver extends StatelessWidget {
  const OrderListSliver({
    super.key,
    required this.orders,
  });

  final List<Map<String, dynamic>> orders;

  @override
  Widget build(BuildContext context) {
    return SliverFixedExtentList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 8.5.h),
            child: DetailOrderCard(
              orders[index],
            ),
          );
        },
        childCount: orders.length,
      ),
      itemExtent: 112.h,
    );
  }
}
