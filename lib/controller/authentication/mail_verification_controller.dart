import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kisanapp/services/auth_api_service.dart';

import '../../router/routes.dart';
import '../../utils/notification/custome_snackbar.dart';
import 'login_controller.dart';

class MailVerificationController extends GetxController {
  // Observable variables
  final RxBool isEmailVerified = false.obs;
  final RxBool isLoading = false.obs;
  final RxBool isLoggedIn = false.obs;

  // Constants
  static const int maxAttempts = 5;
  static const Duration timerDuration = Duration(seconds: 30);

  // Class variables
  final String username;
  final String password;
  Timer? _timer;
  int _attempts = 0;

  // Constructor
  MailVerificationController({required this.username, required this.password});

  @override
  void onInit() {
    super.onInit();

    // Register LoginController if it's not already registered
    if (!Get.isRegistered<LoginController>()) {
      Get.put(LoginController());
    }

    _checkEmailVerificationStatus();
  }

  /// Check the status of email verification
  Future<void> _checkEmailVerificationStatus() async {
    // Avoid checking verification if already logged in or if a request is in progress
    if (isLoggedIn.value || isLoading.value) return;

    try {
      isLoading(true);
      final response = await AuthApiService().checkEmailVerification(username);
      final emailVerified = response['isEmailVerified'] ?? false;

      if (emailVerified) {
        isEmailVerified(true);
        _stopTimer();
        await _autoLogin();
      } else {
        isEmailVerified(false);
        if (_attempts < maxAttempts) {
          _attempts++;
          _startTimer();
        }
      }
    } catch (e) {
      isEmailVerified(false);
      CustomSnackbar.show(
        title: 'Verification Error',
        message: 'There was an error verifying your email.',
        backgroundColor: Colors.red,
        iconData: Icons.error,
      );
      _stopTimer();
    } finally {
      isLoading(false);
    }
  }

  /// Manually trigger the email verification check
  Future<void> checkVerificationManually() async {
    if (!isLoggedIn.value && !isLoading.value) {
      await _checkEmailVerificationStatus();
    }
  }

  /// Start a timer to retry email verification
  void _startTimer() {
    _timer = Timer.periodic(timerDuration, (timer) {
      if (_attempts < maxAttempts && !isLoggedIn.value && !isLoading.value) {
        _checkEmailVerificationStatus();
      } else {
        _stopTimer();
      }
    });
  }

  /// Stop the timer
  void _stopTimer() {
    _timer?.cancel();
  }

  /// Perform auto-login after email verification
  Future<void> _autoLogin() async {
    try {
      final loginController = Get.find<
          LoginController>(); // Fetching the registered LoginController
      final response = await loginController.handleLogin(username, password);

      if (response['token'] != null) {
        final box = GetStorage();
        box.write('token', response['token']);
        box.write('user', response['user']);

        CustomSnackbar.show(
          title: 'Login Successful',
          message: 'Welcome!',
          backgroundColor: Colors.green,
          iconData: Icons.check_circle,
        );

        isLoggedIn.value = true;
        _stopTimer();
        Get.offAllNamed(AppRoutes.home);
      } else {
        _handleLoginError('Invalid credentials or token not found.');
      }
    } catch (e) {
      _handleLoginError(e.toString());
    }
  }

  /// Handle login failure
  void _handleLoginError(String error) {
    CustomSnackbar.show(
      title: 'Login Failed',
      message: error,
      backgroundColor: Colors.red,
      iconData: Icons.error,
    );
  }

  /// Resend the verification email
  Future<void> resendVerificationEmail() async {
    if (isLoading.value) {
      return; // Prevent resending while a request is in progress
    }

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

  /// Clean up resources when the controller is closed
  @override
  void onClose() {
    _stopTimer();
    super.onClose();
  }
}
