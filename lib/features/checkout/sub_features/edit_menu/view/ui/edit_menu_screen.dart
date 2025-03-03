import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:venturo_core/features/checkout/controllers/checkout_controller.dart';
import 'package:venturo_core/features/checkout/sub_features/edit_menu/controllers/edit_menu_controller.dart';
import 'package:venturo_core/features/checkout/sub_features/edit_menu/view/components/edit_menu_widgets.dart';
import 'package:venturo_core/features/checkout/sub_features/edit_menu/view/components/edit_level_bottom_sheet.dart';
import 'package:venturo_core/features/checkout/sub_features/edit_menu/view/components/edit_topping_bottom_sheet.dart';
import 'package:venturo_core/features/checkout/sub_features/edit_menu/view/components/edit_catatan_bottom_sheet.dart';
import 'package:venturo_core/features/detail_menu/view/components/detail_row_widget.dart';
import 'package:venturo_core/features/detail_menu/view/components/touchable_detail_row_widget.dart';
import 'package:venturo_core/shared/styles/color_style.dart';
import 'package:venturo_core/utils/functions/string_utils.dart';
import 'package:venturo_core/utils/functions/string_utils.dart' as string_utils;

class EditMenuScreen extends StatelessWidget {
  const EditMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final EditMenuController controller = Get.put(EditMenuController());
    final CheckoutController checkoutController = Get.put(CheckoutController());
    final Map<String, dynamic> arguments =
        Get.arguments as Map<String, dynamic>;
    final int menuId = arguments['id_menu'] as int;

    return Scaffold(
      appBar: buildAppBar(),
      body: FutureBuilder(
        future: controller.fetchMenuFromHive(menuId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading menu details'));
          } else {
            final menuDetail = arguments;

            return Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildMenuImage(menuDetail['foto']),
                    Expanded(
                      child: _buildMenuDetails(context, controller, menuDetail),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: buildSaveButton(
                      controller, checkoutController, arguments, menuDetail),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildMenuDetails(BuildContext context, EditMenuController controller,
      Map<String, dynamic> menuDetail) {
    return Container(
      width: Get.width,
      padding: EdgeInsets.all(28.r),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildMenuHeader(controller, menuDetail),
          SizedBox(height: 8.h),
          Text(
            menuDetail['deskripsi'] ?? 'Deskripsi Tidak Tersedia',
            style: Get.textTheme.bodyMedium,
          ),
          SizedBox(height: 16.h),
          const Divider(),
          Obx(() => DetailRowWidget(
                title: 'Harga'.tr,
                value: Text(
                  'Rp${NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 0).format(controller.totalPrice.value)}',
                  style: const TextStyle(
                      color: ColorStyle.primary, fontWeight: FontWeight.bold),
                ),
                icon: Icons.attach_money,
              )),
          const Divider(),
          Obx(() => TouchableDetailRowWidget(
                title: 'Level'.tr,
                value: controller.selectedLevel.value.isEmpty
                    ? 'Pilih Level'.tr
                    : string_utils.capitalize(controller.selectedLevel.value),
                onTap: () => showEditLevelBottomSheet(context, controller),
                icon: Icons.whatshot,
              )),
          const Divider(),
          Obx(() => TouchableDetailRowWidget(
                title: 'Topping'.tr,
                value: controller.selectedToppings.isEmpty
                    ? 'Pilih Topping'.tr
                    : controller.selectedToppings
                        .map((item) => string_utils.capitalize(item as String))
                        .join(', '),
                onTap: () => showEditToppingBottomSheet(context, controller),
                icon: Icons.local_pizza,
              )),
          const Divider(),
          Obx(() => TouchableDetailRowWidget(
                title: 'Catatan'.tr,
                value: controller.catatan.value.isEmpty
                    ? 'Masukkan catatan'.tr
                    : truncateWithEllipsis(controller.catatan.value, 20),
                onTap: () => showEditCatatanBottomSheet(context, controller,
                    TextEditingController(text: controller.catatan.value)),
                icon: Icons.edit_note_outlined,
              )),
          const Divider(),
        ],
      ),
    );
  }
}
