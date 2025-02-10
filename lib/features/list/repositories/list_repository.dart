import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ListRepository {
  final String _baseUrl = 'https://trainee.landa.id/javacode/menu';
  final String _token = dotenv.env['API_TOKEN'] ?? '';

  Future<List<Map<String, dynamic>>> getListOfData({String category = 'semua'}) async {
    String url = '$_baseUrl/all';
    if (category != 'semua') {
      url = '$_baseUrl/kategori/$category';
    }

    var headers = {
      'token': _token,
    };

    var response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      var responseData = response.body;
      var data = json.decode(responseData);
      return List<Map<String, dynamic>>.from(data['data']);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> deleteItem(int id) async {
    
  }
}