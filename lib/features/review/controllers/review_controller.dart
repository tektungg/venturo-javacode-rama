import 'package:get/get.dart';
import 'package:venturo_core/features/review/repositories/review_repository.dart';

class ReviewController extends GetxController {
  static ReviewController get to => Get.put(ReviewController());

  final reviews = ReviewRepository.reviews.obs;

  void addReview(Map<String, dynamic> review) {
    ReviewRepository.addReview(review);
    reviews.add(review);
  }
}
