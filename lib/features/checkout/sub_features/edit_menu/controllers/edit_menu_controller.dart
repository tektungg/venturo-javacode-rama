import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class EditMenuController extends GetxController {
  static EditMenuController get to => Get.put(EditMenuController());

  final RxList<dynamic> selectedToppings = <dynamic>[].obs;
  final RxString selectedLevel = ''.obs;
  final RxString catatan = ''.obs;
  final RxInt quantity = 1.obs;
  final RxInt totalPrice = 0.obs;
  final RxList<dynamic> levels = <dynamic>[].obs;
  final RxList<dynamic> toppings = <dynamic>[].obs;

  void updateMenuInHive(Map<String, dynamic> updatedMenu) {
    var box = Hive.box('orders');
    int index = box.values
        .toList()
        .indexWhere((element) => element['id_menu'] == updatedMenu['id_menu']);
    if (index != -1) {
      box.putAt(index, updatedMenu);
    }
  }

  Future<void> fetchMenuFromHive(int menuId) async {
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
      levels.assignAll(savedMenu['levels'] ?? []);
      toppings.assignAll(savedMenu['toppings'] ?? []);
    }
  }

  void incrementQuantity() {
    quantity.value++;
    updateTotalPrice();
  }

  void decrementQuantity(int menuId) {
    if (quantity.value > 1) {
      quantity.value--;
      updateTotalPrice();
    } else {
      var box = Hive.box('orders');
      int index = box.values
          .toList()
          .indexWhere((element) => element['id_menu'] == menuId);
      if (index != -1) {
        box.deleteAt(index);
      }
      Get.back();
    }
  }

  void updateTotalPrice() {
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
  }
}
