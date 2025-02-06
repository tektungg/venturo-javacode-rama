import 'package:get/get.dart';
import 'package:venturo_core/features/get_location/controllers/get_location_controller.dart';

class GetLocationBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(GetLocationController());
  }
}
