import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:venturo_core/shared/styles/color_style.dart';
import 'package:venturo_core/features/order/sub_features/detail_order/view/components/order_tracker.dart';

class SummarySection extends StatelessWidget {
  final int totalItems;
  final Map<String, dynamic> order;

  const SummarySection({
    Key? key,
    required this.totalItems,
    required this.order,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      padding: EdgeInsets.all(26.r),
      decoration: BoxDecoration(
        color: ColorStyle.tertiary,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
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
                'Rp${NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 0).format(order['total_bayar'])}',
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
                  const Icon(Icons.local_offer, color: ColorStyle.primary),
                  const SizedBox(width: 8),
                  Text(
                    'Potongan',
                    style: Get.textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Text(
                '-Rp${NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 0).format(order['potongan'] ?? 0)}',
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
                  const Icon(Icons.payment, color: ColorStyle.primary),
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
                'Rp${NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 0).format(order['total_bayar'] - (order['potongan'] ?? 0))}',
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
    );
  }
}