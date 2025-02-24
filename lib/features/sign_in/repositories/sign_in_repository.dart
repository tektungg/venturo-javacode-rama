import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:venturo_core/features/sign_in/constants/sign_in_api_constant.dart';

class SignInRepository {
  SignInRepository._();

  var apiConstant = SignInApiConstant();
  final Logger logger = Logger();

  static final SignInRepository instance = SignInRepository._();

  Future<Map<String, dynamic>> signInWithEmailAndPassword(String email, String password) async {
    var headers = {
      'Content-Type': 'application/json',
      'Cookie': 'PHPSESSID=994efc163c62acb0186812f3df3c9619'
    };
    var request = http.Request('POST', Uri.parse('https://trainee.landa.id/javacode/auth/login'));
    request.body = json.encode({
      "email": email,
      "password": password
    });
    request.headers.addAll(headers);

    logger.d('Sending request to ${request.url}');
    logger.d('Request body: ${request.body}');

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      logger.d('Response body: $responseBody');
      return json.decode(responseBody);
    } else {
      final responseBody = await response.stream.bytesToString();
      logger.e('Failed to sign in: ${response.reasonPhrase}');
      logger.e('Response body: $responseBody');
      throw Exception('Failed to sign in: ${response.reasonPhrase}');
    }
  }
}