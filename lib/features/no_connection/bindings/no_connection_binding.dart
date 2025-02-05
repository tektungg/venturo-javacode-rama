import 'package:get/get.dart';
import 'package:venturo_core/features/no_connection/controllers/no_connection_controller.dart';

class NoConnectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(NoConnectionController());
  }
}
