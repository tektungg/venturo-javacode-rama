import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DetailMenuController extends GetxController {
  static DetailMenuController get to => Get.find();

  final RxMap<String, dynamic> menuDetail = <String, dynamic>{}.obs;
  final RxList<dynamic> toppings = <dynamic>[].obs;
  final RxList<dynamic> levels = <dynamic>[].obs;
  final RxString selectedLevel = ''.obs;
  final RxList<String> selectedToppings = <String>[].obs;
  final RxString catatan = ''.obs;
  final RxInt totalPrice = 0.obs;
  final String _token = dotenv.env['API_TOKEN'] ?? '';

  Future<void> fetchMenuDetail(int id) async {
    var headers = {
      'token': _token,
    };
    var request = http.Request(
        'GET', Uri.parse('https://trainee.landa.id/javacode/menu/detail/$id'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responseData = await response.stream.bytesToString();
      print('API Response Data: $responseData'); // Log API response
      var data = json.decode(responseData)['data'];
      menuDetail.value = data['menu'];
      toppings.assignAll(data['topping']);
      levels.assignAll(data['level']);
      totalPrice.value = (data['menu']['harga'] as num).toInt();
    } else {
      print('API Error: ${response.reasonPhrase}'); // Log API error
      throw Exception('Failed to load menu detail');
    }
  }

  void updateTotalPrice() {
    int price = (menuDetail['harga'] as num).toInt();
    if (selectedLevel.isNotEmpty) {
      final level = levels.firstWhere(
          (level) => level['keterangan'] == selectedLevel.value,
          orElse: () => null);
      if (level != null) {
        price += (level['harga'] as num).toInt();
      }
    }
    for (var topping in selectedToppings) {
      final toppingItem =
          toppings.firstWhere((t) => t['keterangan'] == topping);
      price += (toppingItem['harga'] as num).toInt();
    }
    totalPrice.value = price;
  }
}
