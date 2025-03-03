import 'package:get/get.dart';
import 'package:venturo_core/features/review/constants/review_api_constant.dart';

class ReviewRepository {
  ReviewRepository._();

  var apiConstant = ReviewApiConstant();

  static final List<Map<String, dynamic>> reviews = [
    {
      'improvements': ['Harga'.tr, 'Rasa'.tr],
      'rating': 4,
      'review': 'Makanan enak, harga terjangkau, pelayanan cepat.'.tr,
    },
    {
      'improvements': ['Pelayanan'.tr],
      'rating': 5,
      'review': 'Pelayanan sangat memuaskan, ramah dan cepat.'.tr,
    },
  ];

  static void addReview(Map<String, dynamic> review) {
    reviews.add(review);
  }
}