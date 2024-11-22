import 'dart:convert';
import 'package:http/http.dart' as http;

import '../utils/error/api_error_parser.dart';

class ApiServiceBase {
  final String baseUrl;

  ApiServiceBase({required this.baseUrl});

  /// Send a POST request
  Future<Map<String, dynamic>> post(
    String endpoint, {
    required Map<String, dynamic> body,
  }) async {
    final url = Uri.parse('$baseUrl/$endpoint');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(body),
      );

      if (_isSuccess(response.statusCode)) {
        return json.decode(response.body);
      } else {
        throw http.Response(response.body, response.statusCode);
      }
    } catch (e) {
      throw Exception(ApiErrorParser.parseError(e));
    }
  }

  /// Send a GET request
  Future<Map<String, dynamic>> get(String endpoint) async {
    final url = Uri.parse('$baseUrl/$endpoint');
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (_isSuccess(response.statusCode)) {
        return json.decode(response.body);
      } else {
        throw http.Response(response.body, response.statusCode);
      }
    } catch (e) {
      throw Exception(ApiErrorParser.parseError(e));
    }
  }

  /// Utility to check if the status code indicates success
  bool _isSuccess(int statusCode) {
    return statusCode >= 200 && statusCode < 300;
  }
}
