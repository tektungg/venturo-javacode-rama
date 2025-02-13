import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class PromoRepository {
  final String _baseUrl = 'https://trainee.landa.id/javacode/promo';
  final String _token = dotenv.env['API_TOKEN'] ?? '';

  Future<List<Map<String, dynamic>>> getAllPromos() async {
    String url = '$_baseUrl/all';

    var headers = {
      'token': _token,
    };

    var request = http.Request('GET', Uri.parse(url));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responseData = await response.stream.bytesToString();
      var data = json.decode(responseData);
      return List<Map<String, dynamic>>.from(data['data']);
    } else {
      throw Exception('Failed to load promos');
    }
  }

  Future<Map<String, dynamic>> getPromoDetail(int id) async {
    String url = '$_baseUrl/detail/$id';

    var headers = {
      'token': _token,
    };

    var request = http.Request('GET', Uri.parse(url));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responseData = await response.stream.bytesToString();
      var data = json.decode(responseData);
      return data['data'];
    } else {
      throw Exception('Failed to load promo detail');
    }
  }
}