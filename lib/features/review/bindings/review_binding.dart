import 'package:get/get.dart';
import 'package:venturo_core/features/review/controllers/review_controller.dart';

class ReviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ReviewController());
  }
}
