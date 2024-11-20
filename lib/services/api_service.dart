import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthApiService {
  final String baseUrl = 'https://api.kisanwale.in';

  // Register User
  Future<Map<String, dynamic>> registerUser({
    required String username,
    required String password,
    required String email,
    required String mobile,
    required String firstName,
    required String lastName,
    required String address,
  }) async {
    final url = Uri.parse('$baseUrl/register');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'username': username,
          'password': password,
          'email': email,
          'mobile': mobile,
          'firstName': firstName,
          'lastName': lastName,
          'address': address,
        }),
      );

      // Check for a successful response
      if (response.statusCode == 201) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to register user: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error during registration: $e');
    }
  }

  // Login User
  Future<Map<String, dynamic>> loginUser({
    required String username,
    required String password,
  }) async {
    final url = Uri.parse('$baseUrl/login');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'username': username,
          'password': password,
        }),
      );

      // Check for a successful response
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to login: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error during login: $e');
    }
  }

  // Check Email Verification
  Future<Map<String, dynamic>> checkEmailVerification(String username) async {
    final url =
        Uri.parse('$baseUrl/check-email-verification?username=$username');
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to check email verification: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error during email verification check: $e');
    }
  }
}
