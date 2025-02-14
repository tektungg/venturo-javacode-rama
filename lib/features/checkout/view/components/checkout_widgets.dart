import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:venturo_core/features/checkout/controllers/checkout_controller.dart';
import 'package:venturo_core/features/checkout/sub_features/voucher/view/ui/voucher_screen.dart';
import 'package:venturo_core/shared/styles/color_style.dart';
import 'package:intl/intl.dart';
import 'package:venturo_core/features/checkout/view/components/detail_row.dart';
import 'package:venturo_core/features/checkout/view/components/touchable_detail_row.dart';

PreferredSizeWidget buildAppBar() {
  return PreferredSize(
    preferredSize: Size.fromHeight(68.h),
    child: SafeArea(
      child: Container(
        width: double.infinity,
        height: 68.h,
        padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(30.r)),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(111, 24, 24, 24),
              blurRadius: 15,
              spreadRadius: -1,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Get.back(),
              ),
            ),
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.room_service, color: ColorStyle.primary),
                  SizedBox(width: 8.w),
                  Text(
                    'Pesanan',
                    style: Get.textTheme.titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget buildEmptyCart() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.shopping_cart_outlined, size: 100.r, color: Colors.grey),
        SizedBox(height: 16.h),
        Text(
          'Belum ada pesanan',
          style: Get.textTheme.titleLarge
              ?.copyWith(color: Colors.grey, fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
}

Widget buildSummarySection(
    BuildContext context, CheckoutController controller) {
  return Container(
    width: Get.width,
    height: 320.h,
    padding: EdgeInsets.all(16.r),
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
        buildDetailRow(
          context,
          'Total Pesanan (${controller.totalMenuDipesan} Menu)',
          Obx(() => Text(
                'Rp${NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 0).format(controller.totalHarga.value)}',
                style: const TextStyle(
                    color: ColorStyle.primary, fontWeight: FontWeight.bold),
              )),
        ),
        const Divider(),
        buildTouchableDetailRow(
          context,
          'Diskon',
          'Pilih Diskon',
          () {
            // Implementasi untuk memilih diskon
          },
          Icons.discount,
        ),
        const Divider(),
        Obx(() => buildTouchableDetailRow(
              context,
              'Voucher',
              controller.totalVoucherNominal.value > 0
                  ? 'Rp${NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 0).format(controller.totalVoucherNominal.value)}'
                  : 'Pilih Voucher',
              () async {
                final selectedVouchers = await Get.to(() => VoucherScreen());
                if (selectedVouchers != null) {
                  controller.applyVouchers(selectedVouchers);
                }
              },
              Icons.local_play,
              textColor: controller.totalVoucherNominal.value > 0
                  ? Colors.red
                  : Colors.black,
            )),
        const Divider(),
        buildDetailRow(
          context,
          'Pembayaran',
          const Text('Pay Later'),
          icon: Icons.payment,
        ),
        const Divider(),
      ],
    ),
  );
}

Widget buildBottomBar(CheckoutController controller) {
  return Positioned(
    bottom: 0,
    left: 0,
    right: 0,
    child: Container(
      width: Get.width,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.shopping_cart,
                  color: ColorStyle.primary, size: 40),
              SizedBox(width: 8.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Pembayaran',
                    style: Get.textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Obx(() => Text(
                        'Rp${NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 0).format(controller.totalPembayaran.value)}',
                        style: Get.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: ColorStyle.primary),
                      )),
                ],
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              // Implementasi untuk memesan sekarang
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorStyle.primary,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.r)),
            ),
            child: Text(
              'Pesan Sekarang',
              style: Get.textTheme.labelLarge
                  ?.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
        ],
      ),
    ),
  );
}
