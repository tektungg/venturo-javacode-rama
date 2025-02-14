import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:venturo_core/features/detail_menu/repositories/detail_menu_repository.dart';

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
      totalPrice.value = (data['menu']['harga'] as num).toInt();
      logger.d('Menu detail fetched successfully');
    } catch (e) {
      logger.e('Error in fetchMenuDetail');
      Get.snackbar('Error', e.toString());
    }
  }

  void incrementQuantity() {
    try {
      quantity.value++;
      logger.d('Quantity incremented to ${quantity.value}');
    } catch (e) {
      logger.e('Error in incrementQuantity');
    }
  }

  void decrementQuantity() {
    try {
      if (quantity.value > 1) {
        quantity.value--;
        logger.d('Quantity decremented to ${quantity.value}');
      }
    } catch (e) {
      logger.e('Error in decrementQuantity');
    }
  }

  void updateTotalPrice() {
    try {
      int price = (menuDetail['harga'] as num).toInt();
      if (selectedLevel.isNotEmpty) {
        final level = levels.firstWhere(
            (level) => level['keterangan'] == selectedLevel.value,
            orElse: () => null);
        if (level != null) {
          price += (level['harga'] as num).toInt();
        }
      }
      for (var topping in selectedToppings) {
        final toppingItem =
            toppings.firstWhere((t) => t['keterangan'] == topping);
        price += (toppingItem['harga'] as num).toInt();
      }
      totalPrice.value = price;
      logger.d('Total price updated to $price');
    } catch (e) {
      logger.e('Error in updateTotalPrice');
    }
  }
}