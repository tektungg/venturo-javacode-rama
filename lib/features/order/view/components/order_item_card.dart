import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderItemCard extends StatelessWidget {
  const OrderItemCard({
    super.key,
    required this.order,
    this.onTap,
    this.onOrderAgain,
    this.onGiveReview,
    this.showButtons = false,
  });

  final Map<String, dynamic> order;
  final VoidCallback? onTap;
  final VoidCallback? onOrderAgain;
  final ValueChanged<int>? onGiveReview;
  final bool showButtons;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.r),
      child: Container(
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              order['no_struk'] ?? 'Unknown',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Order ID: ${order['id_order']?.toString() ?? 'N/A'}',
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Total: \$${order['total_bayar']?.toString() ?? '0'}',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8.h),
            if (showButtons)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: onOrderAgain,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    child: Text(
                      'Order Again',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => onGiveReview?.call(order['id_order'] ?? 0),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    child: Text(
                      'Give Review',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}