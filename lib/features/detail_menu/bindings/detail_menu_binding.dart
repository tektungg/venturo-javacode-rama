import 'package:get/get.dart';
import 'package:venturo_core/features/detail_menu/controllers/detail_menu_controller.dart';

class DetailMenuBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DetailMenuController());
  }
}
