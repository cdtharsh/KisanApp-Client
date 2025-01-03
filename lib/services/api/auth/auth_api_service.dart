import '../http_services.dart';

class AuthApiService extends ApiServiceBase {
  AuthApiService() : super(baseUrl: 'https://api.kisanwale.in');

  /// Register User
  Future<Map<String, dynamic>> registerUser({
    required String username,
    required String password,
    required String email,
    required String mobile,
    required String firstName,
    required String lastName,
    required String address,
  }) async {
    return await post(
      'register',
      body: {
        'username': username,
        'password': password,
        'email': email,
        'mobile': mobile,
        'firstName': firstName,
        'lastName': lastName,
        'address': address,
      },
    );
  }

  /// Login User
  Future<Map<String, dynamic>> loginUser({
    required String username,
    required String password,
  }) async {
    return await post(
      'login',
      body: {
        'username': username,
        'password': password,
      },
    );
  }

  /// Check Email Verification
  Future<Map<String, dynamic>> checkEmailVerification(String username) async {
    return await get('check-email-verification?username=$username');
  }

  //resend Email verification mail
  Future<Map<String, dynamic>> resendVerificationEmail(String username) async {
    return await post('resend-verification-email?username=$username', body: {});
  }
}
