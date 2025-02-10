import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DetailMenuController extends GetxController {
  static DetailMenuController get to => Get.find();

  final RxMap<String, dynamic> menuDetail = <String, dynamic>{}.obs;
  final RxList<dynamic> toppings = <dynamic>[].obs;
  final RxList<dynamic> levels = <dynamic>[].obs;
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
    } else {
      print('API Error: ${response.reasonPhrase}'); // Log API error
      throw Exception('Failed to load menu detail');
    }
  }
}
