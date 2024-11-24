import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kisanapp/services/auth_api_service.dart';

import '../../router/routes.dart';
import '../../utils/notification/custome_snackbar.dart';
import 'login_controller.dart';

class MailVerificationController extends GetxController {
  var isEmailVerified = false.obs;
  var isLoading = false.obs;
  var isLoggedIn = false.obs; // Add this flag
  final String username;
  Timer? _timer;
  int _attempts = 0;
  final String password;

  MailVerificationController({required this.username, required this.password});

  @override
  void onInit() {
    super.onInit();
    _checkEmailVerificationStatus();
  }

  // Automatic check for email verification status
  Future<void> _checkEmailVerificationStatus() async {
    if (isLoggedIn.value) return; // Prevent further checks if logged in

    try {
      isLoading(true);
      final response = await AuthApiService().checkEmailVerification(username);
      if (response['isEmailVerified']) {
        isEmailVerified(true);
        _stopTimer();
        _autoLogin(username, password);
      } else {
        isEmailVerified(false);
        _attempts++;
        if (_attempts < 5) {
          _startTimer();
        }
      }
    } catch (e) {
      isEmailVerified(false);
      _stopTimer(); // Stop timer in case of error
    } finally {
      isLoading(false);
    }
  }

  // Manual check for email verification status
  Future<void> checkVerificationManually() async {
    if (!isLoggedIn.value) {
      await _checkEmailVerificationStatus();
    }
  }

  // Start a timer to check the verification status every 10 seconds for a maximum of 5 times
  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      if (_attempts < 5 && !isLoggedIn.value) {
        _checkEmailVerificationStatus();
      } else {
        _stopTimer();
      }
    });
  }

  // Stop the timer when no longer needed
  void _stopTimer() {
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
    }
  }

  // Auto login after email verification
  Future<void> _autoLogin(String username, String password) async {
    try {
      final loginController = LoginController();
      final response = await loginController.handleLogin(username, password);

      if (response['token'] != null) {
        final box = GetStorage();
        box.write('token', response['token']);
        box.write('user', response['user']);
        CustomSnackbar.show(
          title: 'Login Successful',
          message: response['msg'] ?? 'Welcome!',
          backgroundColor: Colors.green,
          iconData: Icons.check_circle,
        );
        isLoggedIn.value = true; // Set isLoggedIn to true
        _stopTimer();
        Get.offAllNamed(AppRoutes.home); // Navigate to home screen
      }
    } catch (e) {
      CustomSnackbar.show(
        title: 'Login Failed',
        error: e,
        backgroundColor: Colors.red,
        iconData: Icons.error,
      );
    }
  }

  Future<void> resendVerificationEmail() async {
    try {
      isLoading(true);
      await AuthApiService().resendVerificationEmail(username);
      Get.snackbar('Email Sent', 'Verification email has been resent.');
    } catch (e) {
      Get.snackbar('Error', 'Failed to resend verification email.');
    } finally {
      isLoading(false);
    }
  }
}
