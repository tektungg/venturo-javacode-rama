import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:venturo_core/features/order/controllers/order_controller.dart';
import 'package:venturo_core/shared/styles/color_style.dart';
import 'package:venturo_core/constants/core/assets/image_constant.dart';
import 'package:venturo_core/shared/widgets/bottom_navbar.dart';

class OrderScreen extends StatelessWidget {
  OrderScreen({super.key});

  final OrderController controller = Get.put(OrderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(68.h),
        child: SafeArea(
          child: Container(
            width: double.infinity,
            height: 68.h,
            padding: EdgeInsets.symmetric(
              horizontal: 25.w,
              vertical: 10.h,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30.r),
              ),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(111, 24, 24, 24),
                  blurRadius: 15,
                  spreadRadius: -1,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    controller.selectedTab.value = 'Sedang Berjalan';
                  },
                  child: Obx(() => Text(
                        'Sedang Berjalan',
                        style: Get.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color:
                              controller.selectedTab.value == 'Sedang Berjalan'
                                  ? ColorStyle.primary
                                  : Colors.black,
                        ),
                      )),
                ),
                GestureDetector(
                  onTap: () {
                    controller.selectedTab.value = 'Riwayat';
                  },
                  child: Obx(() => Text(
                        'Riwayat',
                        style: Get.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: controller.selectedTab.value == 'Riwayat'
                              ? ColorStyle.primary
                              : Colors.black,
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(ImageConstant.bgPattern2),
                fit: BoxFit.cover,
              ),
            ),
            child: Obx(() {
              if (controller.selectedTab.value == 'Sedang Berjalan') {
                return _buildOrderList(
                    controller.ongoingOrders, 'Belum ada pesanan');
              } else {
                return _buildOrderList(
                    controller.orderHistory, 'Belum ada riwayat');
              }
            }),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: BottomNavbar(),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderList(
      List<Map<String, dynamic>> orders, String emptyMessage) {
    if (orders.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inbox, size: 100.r, color: Colors.grey),
            SizedBox(height: 16.h),
            Text(
              emptyMessage,
              style: Get.textTheme.titleMedium?.copyWith(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      );
    } else {
      return ListView.builder(
        padding: EdgeInsets.all(16.r),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return ListTile(
            title: Text(order['nama']),
            subtitle: Text(
                'Rp${NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 0).format(order['harga'])}'),
            trailing: Text('x${order['jumlah']}'),
          );
        },
      );
    }
  }
}