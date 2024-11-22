import 'package:kisanapp/services/auth_api_service.dart';

class LoginController {
  bool isPasswordVisible = false;

  Future<Map<String, dynamic>> handleLogin(
      String username, String password) async {
    try {
      final response = await AuthApiService().loginUser(
        username: username.trim(),
        password: password.trim(),
      );

      // Check if email is verified or not
      if (response['isEmailVerified'] == false) {
        throw Exception(
            'Email is not verified. A new verification email has been sent to your email address.');
      }

      return response;
    } catch (e) {
      throw Exception(e); // Let the calling function handle the error
    }
  }

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
  }
}
