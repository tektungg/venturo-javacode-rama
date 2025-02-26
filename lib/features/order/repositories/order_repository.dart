import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class OrderRepository {
  OrderRepository();

  static final OrderRepository instance = OrderRepository();
  final Logger logger = Logger();

  final String baseUrl = 'https://trainee.landa.id/javacode/';
  final String token = '5b90e85d28255df4e6c4e57053d0a87063157de3';

  Future<List<Map<String, dynamic>>> getOrdersByUserId(int userId) async {
    var headers = {
      'token': token,
      'Cookie': 'PHPSESSID=994efc163c62acb0186812f3df3c9619'
    };
    var request =
        http.Request('GET', Uri.parse('${baseUrl}order/user/$userId'));
    request.headers.addAll(headers);

    logger.d('Sending request to ${request.url}');
    logger.d('Request headers: ${request.headers}');

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      logger.d('Response body: $responseBody');
      final Map<String, dynamic> parsedResponse = json.decode(responseBody);
      return List<Map<String, dynamic>>.from(parsedResponse['data']);
    } else {
      final responseBody = await response.stream.bytesToString();
      logger.e('Failed to fetch orders: ${response.reasonPhrase}');
      logger.e('Response body: $responseBody');
      throw Exception('Failed to fetch orders: ${response.reasonPhrase}');
    }
  }

  Future<List<Map<String, dynamic>>> getOngoingOrder(int userId) async {
    final orders = await getOrdersByUserId(userId);
    return orders.where((element) => element['status'] < 3).toList();
  }

  Future<List<Map<String, dynamic>>> getOrderHistory(int userId) async {
    final orders = await getOrdersByUserId(userId);
    return orders.where((element) => element['status'] > 2).toList();
  }

  Future<Map<String, dynamic>?> getOrderDetail(int userId, int idOrder) async {
    final orders = await getOrdersByUserId(userId);
    return orders.firstWhere((element) => element['id_order'] == idOrder,
        orElse: () => {});
  }

  Future<void> createOrder(Map<String, dynamic> orderData) async {
    var headers = {'token': token, 'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse('${baseUrl}order/add'));
    request.body = json.encode(orderData);
    request.headers.addAll(headers);

    logger.d('Sending request to ${request.url}');
    logger.d('Request body: ${request.body}');
    logger.d('Request headers: ${request.headers}');

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      logger.d('Response body: $responseBody');
    } else {
      final responseBody = await response.stream.bytesToString();
      logger.e('Failed to create order: ${response.reasonPhrase}');
      logger.e('Response body: $responseBody');
      throw Exception('Failed to create order: ${response.reasonPhrase}');
    }
  }
}
