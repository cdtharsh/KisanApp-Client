import 'package:get/get.dart';
import 'package:kisanapp/services/auth_api_service.dart';

class MailVerificationController extends GetxController {
  var isEmailVerified = false.obs;
  var isLoading = false.obs;

  final String username;

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
      } else {
        isEmailVerified(false);
      }
    } catch (e) {
      isEmailVerified(false);
      // Handle error or show message if needed
    } finally {
      isLoading(false);
    }
  }

  // Manual check for email verification status
  Future<void> checkVerificationManually() async {
    await _checkEmailVerificationStatus();
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
