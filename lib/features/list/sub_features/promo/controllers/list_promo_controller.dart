import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:venturo_core/features/list/sub_features/promo/repositories/promo_repository.dart';

class ListPromoController extends GetxController {
  static ListPromoController get to => Get.find();

  final PromoRepository repository = PromoRepository();
  final RxList<Map<String, dynamic>> promos = <Map<String, dynamic>>[].obs;
  final Logger logger = Logger();

  @override
  void onInit() {
    super.onInit();
    fetchPromos();
  }

  Future<void> fetchPromos() async {
    try {
      logger.d('Fetching promos');
      final result = await repository.getAllPromos();
      promos.assignAll(result);
      logger.d('Promos fetched successfully');
    } catch (e) {
      logger.e('Error in fetchPromos');
      Get.snackbar('Error', 'Failed to load promos');
    }
  }
}