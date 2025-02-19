import 'package:get/get.dart';
import 'package:venturo_core/features/checkout/controllers/checkout_controller.dart';
import 'package:venturo_core/features/checkout/sub_features/discount/controllers/discount_controller.dart';
import 'package:venturo_core/features/list/controllers/list_controller.dart';

class ListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DiscountController());
    Get.lazyPut(() => CheckoutController());
    Get.put(ListController());
  }
}
