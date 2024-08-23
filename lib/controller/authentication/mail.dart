import 'dart:async';

import 'package:get/get.dart';

import '../../services/api_services.dart';

class MailVerificationController extends GetxController {
  final AuthApiService _authApiService = AuthApiService();
  late Timer _timer;
  final String email;

  MailVerificationController(this.email);

  @override
  void onInit() {
    super.onInit();
    startEmailVerificationCheck();
  }

  @override
  void onClose() {
    _timer.cancel();
    super.onClose();
  }

  void startEmailVerificationCheck() {
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) async {
      final response = await checkEmailVerificationStatus();
      if (response['success'] == true) {  // Check for success as a boolean
        if (response['msg'] == 'Email is verified.') {
          _timer.cancel();
          Get.offNamed('/home');
        }
      } else {
        // Handle unsuccessful response
        //print(response['error']);
      }
    });
  }

  Future<Map<String, dynamic>> checkEmailVerificationStatus() async {
    try {
      final response = await _authApiService.checkEmailVerification(email);
      return response;  // Ensure response structure is correct
    } catch (e) {
      return {'success': false, 'error': e.toString()};
    }
  }

  Future<void> manuallyCheckEmailVerificationStatus() async {
    final response = await checkEmailVerificationStatus();
    if (response['success'] == true) {
      if (response['msg'] == 'Email is verified.') {
        Get.offNamed('/home');
      }
    } else {
      // Handle unsuccessful response
      //print(response['error']);
    }
  }

  Future<void> sendVerificationEmail() async {
    try {
      //await _authApiService.resendVerificationEmail();
      Get.snackbar("Email Sent", "A verification email has been sent.");
    } catch (e) {
      Get.snackbar("Error", "Failed to send verification email.");
    }
  }
}
