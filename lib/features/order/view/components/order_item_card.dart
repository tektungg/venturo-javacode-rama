import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:venturo_core/shared/styles/color_style.dart';
import 'package:venturo_core/utils/functions/string_utils.dart';
import 'package:venturo_core/features/order/view/components/outlined_title_button.dart';
import 'package:venturo_core/features/order/view/components/primary_button_with_title.dart';

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
    final String imageUrl = order['menu'][0]['foto'] ??
        'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/240px-No_image_available.svg.png';

    final String statusText;
    final IconData statusIcon;
    final Color statusColor;

    switch (order['status']) {
      case 0:
      case 1:
      case 2:
        statusText = 'Disiapkan';
        statusIcon = Icons.access_time;
        statusColor = const Color(0xFFFFAC01);
        break;
      case 3:
        statusText = 'Dibatalkan';
        statusIcon = Icons.cancel;
        statusColor = Colors.red;
        break;
      case 4:
      default:
        statusText = 'Selesai';
        statusIcon = Icons.check_circle;
        statusColor = Colors.green;
        break;
    }

    final String menuNames = truncateWithEllipsis(
        order['menu'].map<String>((menu) => menu['nama'] as String).join(', '),
        30);

    final int totalMenu = order['menu'].length;

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
        child: Row(
          children: [
            // Menu image
            Container(
              height: 90.h,
              width: 90.w,
              margin: EdgeInsets.only(right: 12.r),
              padding: EdgeInsets.all(5.r),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: Colors.grey[100],
              ),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.contain,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) {
                  return Image.network(
                    'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/240px-No_image_available.svg.png',
                    fit: BoxFit.contain,
                  );
                },
              ),
            ),
            // Menu info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Order status and date
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(statusIcon, color: statusColor, size: 16.sp),
                          SizedBox(width: 4.w),
                          Text(
                            statusText,
                            style: TextStyle(
                              color: statusColor,
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        DateFormat('yyyy-MM-dd')
                            .format(DateTime.parse(order['tanggal'])),
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    menuNames,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  SizedBox(height: 8.h),
                  RichText(
                    text: TextSpan(
                      text:
                          'Rp${NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 0).format(order['total_bayar'])} ',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: ColorStyle.primary,
                      ),
                      children: [
                        TextSpan(
                          text: '($totalMenu menu)',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (showButtons) ...[
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        OutlinedTitleButton(
                          text: 'Ulasan',
                          onPressed: () =>
                              onGiveReview?.call(order['id_order'] ?? 0),
                          width: 120.w,
                          height: 30.h,
                        ),
                        PrimaryButtonWithTitle(
                          onPressed: onOrderAgain,
                          title: 'Pesan Lagi',
                          backgroundColor: Colors.blue,
                          titleColor: Colors.white,
                          borderColor: Colors.blue,
                          width: 120.w,
                          height: 30.h,
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
