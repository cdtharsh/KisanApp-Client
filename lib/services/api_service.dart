import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthApiService {
  final String baseUrl = 'https://api.kisanwale.in';

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

    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to register user: ${response.body}');
    }
  }
}
