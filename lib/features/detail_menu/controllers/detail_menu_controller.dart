import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:venturo_core/features/detail_menu/repositories/detail_menu_repository.dart';
import 'package:venturo_core/features/checkout/controllers/checkout_controller.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DetailMenuController extends GetxController {
  static DetailMenuController get to => Get.find();

  final RxMap<String, dynamic> menuDetail = <String, dynamic>{}.obs;
  final RxList<dynamic> toppings = <dynamic>[].obs;
  final RxList<dynamic> levels = <dynamic>[].obs;
  final RxString selectedLevel = ''.obs;
  final RxList<String> selectedToppings = <String>[].obs;
  final RxString catatan = ''.obs;
  final RxInt quantity = 1.obs;
  final RxInt totalPrice = 0.obs;

  final DetailMenuRepository repository = DetailMenuRepository();
  final Logger logger = Logger();

  Future<void> fetchMenuDetail(int id) async {
    try {
      logger.d('Fetching menu detail for id: $id');
      var data = await repository.fetchMenuDetail(id);
      menuDetail.value = data['menu'];
      toppings.assignAll(data['topping']);
      levels.assignAll(data['level']);
      totalPrice.value = (data['menu']['harga'] as num?)?.toInt() ?? 0;
      logger.d('Menu detail fetched successfully');
    } catch (e) {
      logger.e('Error in fetchMenuDetail: $e');
      Get.snackbar('Error', e.toString());
    }
  }

  void incrementQuantity() {
    try {
      quantity.value++;
      updateTotalPrice();
      logger.d('Quantity incremented to ${quantity.value}');
    } catch (e) {
      logger.e('Error in incrementQuantity: $e');
    }
  }

  void decrementQuantity(int menuId) {
    try {
      if (quantity.value > 1) {
        quantity.value--;
        updateTotalPrice();
        logger.d('Quantity decremented to ${quantity.value}');
      } else {
        CheckoutController.to.removeMenu(menuId);
        logger.d('Menu removed from order: $menuId');
      }
    } catch (e) {
      logger.e('Error in decrementQuantity: $e');
    }
  }

  void updateTotalPrice() {
    try {
      int price = (menuDetail['harga'] as num?)?.toInt() ?? 0;
      if (selectedLevel.isNotEmpty) {
        final level = levels.firstWhere(
            (level) => level['keterangan'] == selectedLevel.value,
            orElse: () => null);
        if (level != null) {
          price += (level['harga'] as num?)?.toInt() ?? 0;
        }
      }
      for (var topping in selectedToppings) {
        final toppingItem =
            toppings.firstWhere((t) => t['keterangan'] == topping);
        price += (toppingItem['harga'] as num?)?.toInt() ?? 0;
      }
      totalPrice.value = price;
      logger.d('Total price updated to $price');
    } catch (e) {
      logger.e('Error in updateTotalPrice: $e');
    }
  }

  void addToOrder() {
    final updatedMenu = {
      'id_menu': menuDetail['id_menu'],
      'nama': menuDetail['nama'],
      'harga': totalPrice.value,
      'jumlah': quantity.value,
      'foto': menuDetail['foto'],
      'catatan': catatan.value,
      'kategori': menuDetail['kategori'],
      'toppings': selectedToppings,
      'level': selectedLevel.value,
    };
    CheckoutController.to.menuList.add(updatedMenu);
    CheckoutController.to.calculateTotal();

    // Save data to Hive box
    var box = Hive.box('orders');
    box.add(updatedMenu);

    logger.d('Menu added to order: $updatedMenu');
  }
}