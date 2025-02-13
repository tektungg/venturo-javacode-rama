import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:venturo_core/features/checkout/controllers/checkout_controller.dart';
import 'package:venturo_core/features/detail_menu/controllers/detail_menu_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:venturo_core/shared/styles/color_style.dart';

PreferredSizeWidget buildAppBar() {
  return PreferredSize(
    preferredSize: Size.fromHeight(68.h),
    child: SafeArea(
      child: Container(
        width: double.infinity,
        height: 68.h,
        padding: EdgeInsets.symmetric(vertical: 10.h),
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
              child: Text(
                'Edit Menu',
                style: Get.textTheme.titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget buildMenuImage(String? imageUrl) {
  return Center(
    child: CachedNetworkImage(
      imageUrl: imageUrl ??
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
  );
}

Widget buildMenuHeader(
    DetailMenuController controller, Map<String, dynamic> menuDetail) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        menuDetail['nama'] ?? 'Nama Tidak Tersedia',
        style: Get.textTheme.headlineSmall
            ?.copyWith(fontWeight: FontWeight.bold, color: ColorStyle.primary),
      ),
      Row(
        children: [
          buildQuantityButton(controller, Icons.remove, () {
            if (controller.quantity.value > 1) {
              controller.decrementQuantity();
            }
          }),
          Obx(() => Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                child: Text('${controller.quantity.value}',
                    style: Get.textTheme.bodyLarge),
              )),
          buildQuantityButton(
              controller, Icons.add, controller.incrementQuantity),
        ],
      ),
    ],
  );
}

Widget buildQuantityButton(
    DetailMenuController controller, IconData icon, VoidCallback onPressed) {
  return Container(
    width: 20.w,
    height: 20.h,
    decoration: BoxDecoration(
      color: icon == Icons.add ? ColorStyle.primary : Colors.white,
      border: Border.all(color: ColorStyle.primary),
      borderRadius: BorderRadius.circular(5.r),
    ),
    child: IconButton(
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
      onPressed: onPressed,
      icon: Icon(icon,
          color: icon == Icons.add ? Colors.white : ColorStyle.primary,
          size: 15),
    ),
  );
}

Widget buildSaveButton(
    DetailMenuController controller,
    CheckoutController checkoutController,
    Map<String, dynamic> menu,
    Map<String, dynamic> menuDetail) {
  return Container(
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
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorStyle.primary,
        padding: EdgeInsets.symmetric(vertical: 16.h),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.r)),
      ),
      onPressed: () {
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
        style: Get.textTheme.titleLarge
            ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    ),
  );
}
