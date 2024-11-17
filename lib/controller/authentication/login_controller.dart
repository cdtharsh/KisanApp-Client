import 'package:kisanapp/services/api_service.dart';

class LoginController {
  bool isPasswordVisible = false;

  Future<Map<String, dynamic>> handleLogin(
    String username,
    String password,
  ) async {
    try {
      final response = await AuthApiService().loginUser(
        username: username.trim(),
        password: password.trim(),
      );
      return response;
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
  }
}
