import 'package:get/get.dart';
import 'package:venturo_core/features/list/sub_features/promo/repositories/promo_repository.dart';

class ListPromoController extends GetxController {
  static ListPromoController get to => Get.find();

  final PromoRepository repository = PromoRepository();

  final RxList<Map<String, dynamic>> promos = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchPromos();
  }

  Future<void> fetchPromos() async {
    try {
      final result = await repository.getAllPromos();
      promos.assignAll(result);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load promos');
    }
  }
}
