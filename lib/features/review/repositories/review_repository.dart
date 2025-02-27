import 'package:venturo_core/features/review/constants/review_api_constant.dart';

class ReviewRepository {
  ReviewRepository._();

  var apiConstant = ReviewApiConstant();

  static final List<Map<String, dynamic>> reviews = [
    {
      'improvements': ['Harga', 'Rasa'],
      'rating': 4,
      'review': 'Makanan enak, harga terjangkau, pelayanan cepat.',
    },
    {
      'improvements': ['Pelayanan'],
      'rating': 5,
      'review': 'Pelayanan sangat memuaskan, ramah dan cepat.',
    },
  ];
}
