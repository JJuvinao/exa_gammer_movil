import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';

class Https_Controllers extends GetxController {
  final type = "Content-Type";
  final app = "application/json";
  Future<http.Response> Https_Post(
    String token,
    Map<String, dynamic> body,
    String url,
  ) async {
    return await http
        .post(
          Uri.parse(url),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(body),
        )
        .timeout(const Duration(seconds: 15));
  }

  Future<http.Response> Https_Get(String token, String url) async {
    return await http
        .get(
          Uri.parse(url),
          headers: {
            'Authorization': 'Bearer $token',
            "Content-Type": "application/json",
          },
        )
        .timeout(const Duration(seconds: 15));
  }
}
