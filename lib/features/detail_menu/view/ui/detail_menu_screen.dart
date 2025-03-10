import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:venturo_core/features/checkout/controllers/checkout_controller.dart';
import 'package:venturo_core/features/detail_menu/controllers/detail_menu_controller.dart';
import 'package:venturo_core/features/detail_menu/view/components/detail_menu_widgets.dart';
import 'package:venturo_core/features/detail_menu/view/components/level_bottom_sheet.dart';
import 'package:venturo_core/features/detail_menu/view/components/topping_bottom_sheet.dart';
import 'package:venturo_core/features/detail_menu/view/components/catatan_bottom_sheet.dart';
import 'package:venturo_core/features/detail_menu/view/components/detail_row_widget.dart';
import 'package:venturo_core/features/detail_menu/view/components/touchable_detail_row_widget.dart';
import 'package:venturo_core/shared/styles/color_style.dart';
import 'package:intl/intl.dart';
import 'package:venturo_core/shared/widgets/bottom_navbar.dart';
import 'package:venturo_core/shared/widgets/checkout_fab.dart';
import 'package:venturo_core/utils/functions/string_utils.dart' as string_utils;
import 'package:venturo_core/utils/functions/string_utils.dart';

class DetailMenuScreen extends StatelessWidget {
  const DetailMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DetailMenuController controller = Get.put(DetailMenuController());
    final CheckoutController checkoutController = Get.put(CheckoutController());
    final int menuId = Get.arguments as int;

    // Fetch menu detail when screen is loaded
    controller.fetchMenuDetail(menuId);
    final TextEditingController catatanController = TextEditingController();

    return Scaffold(
      appBar: buildAppBar(),
      body: Stack(
        children: [
          Obx(() {
            if (controller.menuDetail.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            final menu = controller.menuDetail;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildMenuImage(menu['foto']),
                Expanded(
                  child: _buildMenuDetails(context, controller, menu,
                      catatanController, checkoutController, menuId),
                ),
              ],
            );
          }),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: BottomNavbar(),
          ),
        ],
      ),
      floatingActionButton: const CheckoutFAB(),
    );
  }

  Widget _buildMenuDetails(
      BuildContext context,
      DetailMenuController controller,
      Map<String, dynamic> menu,
      TextEditingController catatanController,
      CheckoutController checkoutController,
      int menuId) {
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
          buildMenuHeader(controller, menu),
          SizedBox(height: 8.h),
          Text(
            menu['deskripsi'] ?? 'Deskripsi Tidak Tersedia',
            style: Get.textTheme.bodyMedium,
          ),
          SizedBox(height: 16.h),
          const Divider(),
          DetailRowWidget(
            title: 'Harga'.tr,
            value: Obx(() => Text(
                  'Rp${NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 0).format(controller.totalPrice.value)}',
                  style: const TextStyle(
                      color: ColorStyle.primary, fontWeight: FontWeight.bold),
                )),
            icon: Icons.attach_money,
          ),
          const Divider(),
          TouchableDetailRowWidget(
            title: 'Level'.tr,
            value: controller.selectedLevel.value.isEmpty
                ? 'Pilih Level'.tr
                : string_utils.capitalize(controller.selectedLevel.value),
            onTap: () => showLevelBottomSheet(context, controller),
            icon: Icons.whatshot,
          ),
          const Divider(),
          TouchableDetailRowWidget(
            title: 'Topping'.tr,
            value: controller.selectedToppings.isEmpty
                ? 'Pilih Topping'.tr
                : controller.selectedToppings
                    .map(string_utils.capitalize)
                    .join(', '),
            onTap: () => showToppingBottomSheet(context, controller),
            icon: Icons.local_pizza,
          ),
          const Divider(),
          TouchableDetailRowWidget(
            title: 'Catatan'.tr,
            value: controller.catatan.value.isEmpty
                ? 'Masukkan catatan'.tr
                : truncateWithEllipsis(controller.catatan.value, 20),
            onTap: () =>
                showCatatanBottomSheet(context, controller, catatanController),
            icon: Icons.edit_note_outlined,
          ),
          const Divider(),
          buildAddToOrderButton(controller, checkoutController, menuId, menu),
        ],
      ),
    );
  }
}
