import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:venturo_core/features/checkout/controllers/checkout_controller.dart';
import 'package:venturo_core/features/checkout/sub_features/discount/repositories/discount_repository.dart';

class DiscountController extends GetxController {
  static DiscountController get to => Get.find();

  final CheckoutController checkoutController = CheckoutController.to;
  final DiscountRepository discountRepository = DiscountRepository();
  final Logger logger = Logger();

  final RxList<Map<String, dynamic>> discounts = <Map<String, dynamic>>[].obs;
  final RxInt totalDiskonNominal = 0.obs;

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
      calculateTotalDiscount();
      checkoutController.calculateTotal();
      logger.d('Discounts fetched successfully');
    } catch (e) {
      logger.e('Error in fetchDiscounts');
    }
  }

  void calculateTotalDiscount() {
    try {
      logger.d('Calculating total discount');
      int totalDiskon = 0;
      for (var discount in discounts) {
        totalDiskon += discount['diskon'] as int;
      }
      totalDiskonNominal.value =
          checkoutController.totalHarga.value * totalDiskon ~/ 100;
      checkoutController.totalDiskonNominal.value = totalDiskonNominal.value;
      logger.d('Total discount calculated: ${totalDiskonNominal.value}');
    } catch (e) {
      logger.e('Error in calculateTotalDiscount');
    }
  }
}