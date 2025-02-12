import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:venturo_core/features/checkout/controllers/checkout_controller.dart';
import 'package:venturo_core/features/detail_menu/controllers/detail_menu_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:venturo_core/features/detail_menu/view/components/level_bottom_sheet.dart';
import 'package:venturo_core/features/detail_menu/view/components/topping_bottom_sheet.dart';
import 'package:venturo_core/features/detail_menu/view/components/catatan_bottom_sheet.dart';
import 'package:venturo_core/features/detail_menu/view/components/detail_row_widget.dart';
import 'package:venturo_core/features/detail_menu/view/components/touchable_detail_row_widget.dart';
import 'package:venturo_core/shared/styles/color_style.dart';
import 'package:intl/intl.dart';
import 'package:venturo_core/utils/functions/string_utils.dart' as string_utils;
import 'package:venturo_core/utils/functions/string_utils.dart';

class EditMenuScreen extends StatelessWidget {
  const EditMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DetailMenuController controller = Get.put(DetailMenuController());
    final CheckoutController checkoutController = Get.put(CheckoutController());

    final Map<String, dynamic> menu = Get.arguments as Map<String, dynamic>;

    // Fetch menu detail when screen is loaded
    controller.fetchMenuDetail(menu['id_menu']);
    controller
        .updateTotalPrice(); // Calculate total price when screen is loaded

    final TextEditingController catatanController = TextEditingController();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(68.h),
        child: SafeArea(
          child: Container(
            width: double.infinity,
            height: 68.h,
            padding: EdgeInsets.symmetric(
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
                    'Edit Menu',
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

        final menuDetail = controller.menuDetail;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CachedNetworkImage(
                imageUrl: menuDetail['foto'] ??
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
            Expanded(
              child: Container(
                width: Get.width,
                padding: EdgeInsets.all(28.r),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30.r),
                  ),
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
                          menuDetail['nama'] ?? 'Nama Tidak Tersedia',
                          style: Get.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: ColorStyle.primary,
                          ),
                        ),
                        Row(
                          children: [
                            // Decrement Button
                            Container(
                              width: 30.w,
                              height: 30.h,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: ColorStyle.primary),
                                borderRadius: BorderRadius.circular(5.r),
                              ),
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                                onPressed: () {
                                  if (controller.quantity.value > 1) {
                                    controller.decrementQuantity();
                                  }
                                },
                                icon: const Icon(
                                  Icons.remove,
                                  color: ColorStyle.primary,
                                  size: 15,
                                ),
                              ),
                            ),
                            // Quantity Text
                            Obx(() => Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 6.w),
                                  child: Text(
                                    '${controller.quantity.value}',
                                    style: Get.textTheme.bodyLarge,
                                  ),
                                )),
                            // Increment Button
                            Container(
                              width: 30.w,
                              height: 30.h,
                              decoration: BoxDecoration(
                                color: ColorStyle.primary,
                                border: Border.all(color: ColorStyle.primary),
                                borderRadius: BorderRadius.circular(5.r),
                              ),
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                                onPressed: () {
                                  controller.incrementQuantity();
                                },
                                icon: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      menuDetail['deskripsi'] ?? 'Deskripsi Tidak Tersedia',
                      style: Get.textTheme.bodyMedium,
                    ),
                    SizedBox(height: 16.h),
                    const Divider(),
                    DetailRowWidget(
                      title: 'Harga',
                      value: Obx(() => Text(
                            'Rp${NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 0).format(controller.totalPrice.value)}',
                            style: const TextStyle(
                              color: ColorStyle.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                      icon: Icons.attach_money,
                    ),
                    const Divider(),
                    TouchableDetailRowWidget(
                      title: 'Level',
                      value: controller.selectedLevel.value.isEmpty
                          ? 'Pilih Level'
                          : string_utils
                              .capitalize(controller.selectedLevel.value),
                      onTap: () => showLevelBottomSheet(context, controller),
                      icon: Icons.whatshot,
                    ),
                    const Divider(),
                    TouchableDetailRowWidget(
                      title: 'Topping',
                      value: controller.selectedToppings.isEmpty
                          ? 'Pilih Topping'
                          : controller.selectedToppings
                              .map(string_utils.capitalize)
                              .join(', '),
                      onTap: () => showToppingBottomSheet(context, controller),
                      icon: Icons.local_pizza,
                    ),
                    const Divider(),
                    TouchableDetailRowWidget(
                      title: 'Catatan',
                      value: controller.catatan.value.isEmpty
                          ? 'Masukkan catatan'
                          : truncateWithEllipsis(controller.catatan.value, 20),
                      onTap: () => showCatatanBottomSheet(
                          context, controller, catatanController),
                      icon: Icons.edit_note_outlined,
                    ),
                    const Divider(),
                  ],
                ),
              ),
            ),
            Container(
              width: Get.width,
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(30.r),
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(111, 24, 24, 24),
                    blurRadius: 4,
                    spreadRadius: -1,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorStyle.primary,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                ),
                onPressed: () {
                  // Simpan perubahan dan kembali ke halaman checkout
                  final updatedMenu = {
                    'id_menu': menu['id_menu'],
                    'nama': menuDetail['nama'],
                    'harga': controller.totalPrice.value,
                    'jumlah': controller.quantity.value,
                    'foto': menuDetail['foto'],
                    'catatan': controller.catatan.value,
                    'kategori': menu['kategori'],
                  };
                  checkoutController.updateMenu(updatedMenu);
                  Get.back();
                },
                child: Text(
                  'Simpan',
                  style: Get.textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
