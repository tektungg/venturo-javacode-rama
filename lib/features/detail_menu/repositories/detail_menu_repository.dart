import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:venturo_core/features/detail_menu/constants/detail_menu_api_constant.dart';

class DetailMenuRepository {
  DetailMenuRepository();

  var apiConstant = DetailMenuApiConstant();
  final String _token = dotenv.env['API_TOKEN'] ?? '';

  Future<Map<String, dynamic>> fetchMenuDetail(int id) async {
    var headers = {
      'token': _token,
    };
    var request = http.Request(
        'GET', Uri.parse('https://trainee.landa.id/javacode/menu/detail/$id'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responseData = await response.stream.bytesToString();
      var data = json.decode(responseData)['data'];
      return data;
    } else {
      throw Exception('Failed to load menu detail');
    }
  }
}