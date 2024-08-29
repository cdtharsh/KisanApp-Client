import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthApiService {
  final String _baseUrl = 'https://api.kisanwale.in';

  Future<Map<String, dynamic>> registerUser({
    required String username,
    required String password,
    required String email,
    required String mobile,
    required String firstName,
    required String lastName,
    required String address,
    required String profileImg,
    required String location,
  }) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'password': password,
        'email': email,
        'mobile': mobile,
        'firstName': firstName,
        'lastName': lastName,
        'address': address,
        'profileImg': profileImg,
        'location': location,
      }),
    );

    final responseBody = jsonDecode(response.body);

    if (response.statusCode == 201) {
      return {'success': true, 'msg': responseBody['msg']};
    } else {
      return {
        'success': false,
        'error': responseBody['error'] ?? 'An error occurred'
      };
    }
  }

  Future<Map<String, dynamic>> checkEmailVerification(String email) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/check-email-verification?email=$email'),
    );

    final responseBody = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return {'success': true, 'msg': responseBody['message']};
    } else if (response.statusCode == 404) {
      return {'success': false, 'error': 'User not found'};
    } else {
      return {
        'success': false,
        'error': responseBody['error'] ?? 'An error occurred'
      };
    }
  }

  Future<Map<String, dynamic>> login({
    required String username,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );

    final responseBody = jsonDecode(response.body);

    if (response.statusCode == 200) {
      // Adjusted the status code check
      return {'success': true, 'msg': responseBody['msg']};
    } else {
      return {
        'success': false,
        'error': responseBody['error'] ?? 'An error occurred'
      };
    }
  }
}
