import 'package:kisanapp/services/api/http_services.dart';

class PassApiService extends ApiServiceBase {
  PassApiService() : super(baseUrl: 'https://api.kisanwale.in');

  Future<Map<String, dynamic>> forgetPasswithemail({
    required String email,
  }) async {
    return await post('forget-password-email', body: {
      'email': email,
    });
  }

  Future<Map<String, dynamic>> resetPasswithEmail({
    required String email,
    required String otp,
    required String newPassword,
  }) async {
    return await post(
      'reset-with-email',
      body: {
        'email': email,
        'otp': otp,
        'newPassword': newPassword,
      },
    );
  }
}
