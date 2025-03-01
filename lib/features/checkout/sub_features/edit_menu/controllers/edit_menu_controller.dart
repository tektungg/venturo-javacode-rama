import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:logger/logger.dart';

class EditMenuController extends GetxController {
  static EditMenuController get to => Get.put(EditMenuController());

  final RxList<dynamic> selectedToppings = <dynamic>[].obs;
  final RxString selectedLevel = ''.obs;
  final RxString catatan = ''.obs;
  final RxString deskripsi = ''.obs;
  final RxInt quantity = 1.obs;
  final RxInt totalPrice = 0.obs;
  final RxList<dynamic> levels = <dynamic>[].obs;
  final RxList<dynamic> toppings = <dynamic>[].obs;

  final Logger logger = Logger();

  void updateMenuInHive(Map<String, dynamic> updatedMenu) {
    try {
      var box = Hive.box('orders');
      int index = box.values.toList().indexWhere(
          (element) => element['id_menu'] == updatedMenu['id_menu']);
      if (index != -1) {
        box.putAt(index, updatedMenu);
      }
      logger.d('Menu updated in Hive: $updatedMenu');
    } catch (e) {
      logger.e('Error in updateMenuInHive: $e');
    }
  }

  Future<void> fetchMenuFromHive(int menuId) async {
    try {
      var box = Hive.box('orders');
      var savedMenu = box.values.firstWhere(
          (element) => element['id_menu'] == menuId,
          orElse: () => null);
      if (savedMenu != null) {
        selectedToppings.assignAll(savedMenu['toppings'] ?? []);
        selectedLevel.value = savedMenu['level'] ?? '';
        quantity.value = savedMenu['jumlah'] ?? 1;
        catatan.value = savedMenu['catatan'] ?? '';
        totalPrice.value = savedMenu['harga'] ?? 0;
        levels.assignAll(savedMenu['available_levels'] ?? []);
        toppings.assignAll(savedMenu['available_toppings'] ?? []);
        deskripsi.value = savedMenu['deskripsi'] ?? '';
        logger.d('Menu fetched from Hive: $savedMenu');
      }
    } catch (e) {
      logger.e('Error in fetchMenuFromHive: $e');
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
        var box = Hive.box('orders');
        int index = box.values
            .toList()
            .indexWhere((element) => element['id_menu'] == menuId);
        if (index != -1) {
          box.deleteAt(index);
        }
        Get.back();
        logger.d('Menu removed from Hive: $menuId');
      }
    } catch (e) {
      logger.e('Error in decrementQuantity: $e');
    }
  }

  void updateTotalPrice() {
    try {
      int price = totalPrice.value;
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
}
