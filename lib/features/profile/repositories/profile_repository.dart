import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class ProfileRepository {
  ProfileRepository();

  static final ProfileRepository instance = ProfileRepository();
  final Logger logger = Logger();

  final String baseUrl = 'https://trainee.landa.id/javacode/';
  final String token = '5b90e85d28255df4e6c4e57053d0a87063157de3';

  Future<Map<String, dynamic>> getUserProfile(int userId) async {
    var headers = {
      'token': token,
      'Cookie': 'PHPSESSID=994efc163c62acb0186812f3df3c9619'
    };
    var request =
        http.Request('GET', Uri.parse('${baseUrl}user/detail/$userId'));
    request.headers.addAll(headers);

    logger.d('Sending request to ${request.url}');
    logger.d('Request headers: ${request.headers}');

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      logger.d('Response body: $responseBody');
      final Map<String, dynamic> parsedResponse = json.decode(responseBody);
      return parsedResponse['data'];
    } else {
      final responseBody = await response.stream.bytesToString();
      logger.e('Failed to fetch user profile: ${response.reasonPhrase}');
      logger.e('Response body: $responseBody');
      throw Exception('Failed to fetch user profile: ${response.reasonPhrase}');
    }
  }

  Future<void> updateUserProfile(
      int userId, Map<String, dynamic> profileData) async {
    var headers = {
      'token': token,
      'Content-Type': 'application/json',
      'Cookie': 'PHPSESSID=994efc163c62acb0186812f3df3c9619'
    };
    var request =
        http.Request('POST', Uri.parse('${baseUrl}user/update/$userId'));
    request.headers.addAll(headers);
    request.body = json.encode(profileData);

    logger.d('Sending request to ${request.url}');
    logger.d('Request headers: ${request.headers}');
    logger.d('Request body: ${request.body}');

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      logger.d('Response body: $responseBody');
    } else {
      final responseBody = await response.stream.bytesToString();
      logger.e('Failed to update user profile: ${response.reasonPhrase}');
      logger.e('Response body: $responseBody');
      throw Exception(
          'Failed to update user profile: ${response.reasonPhrase}');
    }
  }
}
