import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:venturo_core/features/checkout/controllers/checkout_controller.dart';
import 'package:venturo_core/features/detail_menu/controllers/detail_menu_controller.dart';
import 'package:venturo_core/features/detail_menu/view/components/level_bottom_sheet.dart';
import 'package:venturo_core/features/detail_menu/view/components/topping_bottom_sheet.dart';
import 'package:venturo_core/features/detail_menu/view/components/catatan_bottom_sheet.dart';
import 'package:venturo_core/features/detail_menu/view/components/detail_row_widget.dart';
import 'package:venturo_core/features/detail_menu/view/components/touchable_detail_row_widget.dart';
import 'package:venturo_core/shared/styles/color_style.dart';
import 'package:intl/intl.dart';
import 'package:venturo_core/utils/functions/string_utils.dart' as string_utils;
import 'package:venturo_core/utils/functions/string_utils.dart';
import 'package:venturo_core/features/checkout/sub_features/edit_menu/view/components/edit_menu_widgets.dart';

class EditMenuScreen extends StatelessWidget {
  const EditMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DetailMenuController controller = Get.put(DetailMenuController());
    final CheckoutController checkoutController = Get.put(CheckoutController());
    final Map<String, dynamic> menu = Get.arguments as Map<String, dynamic>;

    controller.fetchMenuDetail(menu['id_menu']);
    controller.updateTotalPrice();

    final TextEditingController catatanController = TextEditingController();

    return Scaffold(
      appBar: buildAppBar(),
      body: Obx(() {
        if (controller.menuDetail.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        final menuDetail = controller.menuDetail;

        return Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildMenuImage(menuDetail['foto']),
                Expanded(
                  child: _buildMenuDetails(
                      context, controller, menuDetail, catatanController),
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: buildSaveButton(
                  controller, checkoutController, menu, menuDetail),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildMenuDetails(
      BuildContext context,
      DetailMenuController controller,
      Map<String, dynamic> menuDetail,
      TextEditingController catatanController) {
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
          DetailRowWidget(
            title: 'Harga',
            value: Obx(() => Text(
                  'Rp${NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 0).format(controller.totalPrice.value)}',
                  style: const TextStyle(
                      color: ColorStyle.primary, fontWeight: FontWeight.bold),
                )),
            icon: Icons.attach_money,
          ),
          const Divider(),
          TouchableDetailRowWidget(
            title: 'Level',
            value: controller.selectedLevel.value.isEmpty
                ? 'Pilih Level'
                : string_utils.capitalize(controller.selectedLevel.value),
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
            onTap: () =>
                showCatatanBottomSheet(context, controller, catatanController),
            icon: Icons.edit_note_outlined,
          ),
          const Divider(),
        ],
      ),
    );
  }
}
