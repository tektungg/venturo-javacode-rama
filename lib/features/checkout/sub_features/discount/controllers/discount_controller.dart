import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:venturo_core/features/checkout/sub_features/discount/repositories/discount_repository.dart';

class DiscountController extends GetxController {
  static DiscountController get to => Get.find();

  final DiscountRepository discountRepository = DiscountRepository();
  final Logger logger = Logger();

  final RxList<Map<String, dynamic>> discounts = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchDiscounts();
  }

  void fetchDiscounts() async {
    try {
      logger.d('Fetching discounts');
      final fetchedDiscounts = await discountRepository.fetchDiscount();
      discounts.assignAll(fetchedDiscounts);
      logger.d('Discounts fetched successfully');
    } catch (e) {
      logger.e('Error in fetchDiscounts');
    }
  }
}