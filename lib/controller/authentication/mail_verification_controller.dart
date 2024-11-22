import 'dart:async';
import 'package:get/get.dart';
import 'package:kisanapp/services/auth_api_service.dart';

class MailVerificationController extends GetxController {
  var isEmailVerified = false.obs;
  var isLoading = false.obs;
  final String username;
  Timer? _timer;
  int _attempts = 0;

  MailVerificationController({required this.username});

  @override
  void onInit() {
    super.onInit();
    _checkEmailVerificationStatus(); // Automatically check status on init
  }

  // Automatic check for email verification status
  Future<void> _checkEmailVerificationStatus() async {
    try {
      isLoading(true);
      final response = await AuthApiService().checkEmailVerification(username);
      if (response['isEmailVerified']) {
        isEmailVerified(true);
        _stopTimer(); // Stop timer if email is verified
      } else {
        isEmailVerified(false);
        _attempts++;
        if (_attempts < 5) {
          _startTimer(); // Retry after 10 seconds if not verified
        }
      }
    } catch (e) {
      isEmailVerified(false);
      // Handle error or show message if needed
      _stopTimer(); // Stop timer in case of error
    } finally {
      isLoading(false);
    }
  }

  // Manual check for email verification status
  Future<void> checkVerificationManually() async {
    await _checkEmailVerificationStatus();
  }

  // Start a timer to check the verification status every 10 seconds for a maximum of 5 times
  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      if (_attempts < 5) {
        _checkEmailVerificationStatus();
      } else {
        _stopTimer(); // Stop timer after 5 attempts
      }
    });
  }

  // Stop the timer when no longer needed
  void _stopTimer() {
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
    }
  }

  // Resend verification email
  // Future<void> resendVerificationEmail() async {
  //   try {
  //     isLoading(true);
  //     await AuthApiService().resendVerificationEmail(email); // API to resend email
  //     Get.snackbar('Email Sent', 'Verification email has been resent.');
  //   } catch (e) {
  //     Get.snackbar('Error', 'Failed to resend verification email.');
  //   } finally {
  //     isLoading(false);
  //   }
  // }
}
