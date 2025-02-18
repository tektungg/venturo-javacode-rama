import 'package:venturo_core/features/checkout/constants/checkout_api_constant.dart';

class DiscountRepository {
  DiscountRepository();

  var apiConstant = CheckoutApiConstant();

  Future<List<Map<String, dynamic>>> fetchDiscount() async {
    return [
      {
        'id_diskon': 1,
        'nama': 'Ngaji',
        'diskon': 10,
      },
      {
        'id_diskon': 2,
        'nama': 'Ontime',
        'diskon': 10,
      }
    ];
  }
}
