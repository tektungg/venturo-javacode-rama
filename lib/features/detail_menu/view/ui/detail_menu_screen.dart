import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:venturo_core/features/detail_menu/controllers/detail_menu_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:venturo_core/features/detail_menu/view/components/level_bottom_sheet.dart';
import 'package:venturo_core/features/detail_menu/view/components/topping_bottom_sheet.dart';
import 'package:venturo_core/features/detail_menu/view/components/catatan_bottom_sheet.dart';
import 'package:venturo_core/shared/styles/color_style.dart';
import 'package:intl/intl.dart';

class DetailMenuScreen extends StatelessWidget {
  const DetailMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DetailMenuController controller = Get.put(DetailMenuController());
    final int menuId = Get.arguments as int;

    // Fetch menu detail when screen is loaded
    controller.fetchMenuDetail(menuId);

    final TextEditingController catatanController = TextEditingController();

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
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ),
                Center(
                  child: Text(
                    'Detail Menu',
                    style: Get.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Obx(() {
        if (controller.menuDetail.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        final menu = controller.menuDetail;

        return SingleChildScrollView(
          padding: EdgeInsets.all(16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CachedNetworkImage(
                  imageUrl: menu['foto'] ??
                      'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/240px-No_image_available.svg.png',
                  height: 200.h,
                  fit: BoxFit.contain,
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Image.network(
                    'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/240px-No_image_available.svg.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.r),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30.r),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      menu['nama'] ?? 'Nama Tidak Tersedia',
                      style: Get.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      menu['deskripsi'] ?? 'Deskripsi Tidak Tersedia',
                      style: Get.textTheme.bodyMedium,
                    ),
                    SizedBox(height: 16.h),
                    const Divider(),
                    _buildDetailRow(
                      context,
                      'Harga',
                      Obx(() => Text(
                            'Rp${NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 0).format(controller.totalPrice.value)}',
                            style: const TextStyle(
                              color: ColorStyle.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                      Icons.attach_money,
                    ),
                    const Divider(),
                    _buildTouchableDetailRow(
                      context,
                      'Level',
                      controller.selectedLevel.value.isEmpty
                          ? 'Pilih Level'
                          : controller.selectedLevel.value,
                      () => showLevelBottomSheet(context, controller),
                      Icons.whatshot,
                    ),
                    const Divider(),
                    _buildTouchableDetailRow(
                      context,
                      'Topping',
                      controller.selectedToppings.isEmpty
                          ? 'Pilih Topping'
                          : controller.selectedToppings.join(', '),
                      () => showToppingBottomSheet(context, controller),
                      Icons.local_pizza,
                    ),
                    const Divider(),
                    _buildTouchableDetailRow(
                      context,
                      'Catatan',
                      controller.catatan.value.isEmpty
                          ? 'Masukkan catatan'
                          : controller.catatan.value,
                      () => showCatatanBottomSheet(
                          context, controller, catatanController),
                      Icons.edit_note_outlined,
                    ),
                    const Divider(),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildDetailRow(
      BuildContext context, String title, Widget value, IconData icon) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: ColorStyle.primary),
              SizedBox(width: 8.w),
              Text(
                title,
                style: Get.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          value,
        ],
      ),
    );
  }

  Widget _buildTouchableDetailRow(BuildContext context, String title,
      String value, VoidCallback onTap, IconData icon) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, color: ColorStyle.primary),
                SizedBox(width: 8.w),
                Text(
                  title,
                  style: Get.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  value,
                  style: Get.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(Icons.arrow_forward_ios, size: 16.r),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
