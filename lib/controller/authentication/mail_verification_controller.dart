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
  var isLoggedIn = false.obs;
  final String username;
  final String password;
  Timer? _timer;
  int _attempts = 0;

  MailVerificationController({required this.username, required this.password});

  @override
  void onInit() {
    super.onInit();
    _checkEmailVerificationStatus();
  }

  Future<void> _checkEmailVerificationStatus() async {
    if (isLoggedIn.value) return;

    try {
      isLoading(true);
      final response = await AuthApiService().checkEmailVerification(username);
      if (response['isEmailVerified']) {
        isEmailVerified(true);
        _stopTimer();
        await _autoLogin();
      } else {
        isEmailVerified(false);
        if (_attempts < 5) {
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

  Future<void> checkVerificationManually() async {
    if (!isLoggedIn.value) await _checkEmailVerificationStatus();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      if (_attempts < 5 && !isLoggedIn.value) {
        _checkEmailVerificationStatus();
      } else {
        _stopTimer();
      }
    });
  }

  void _stopTimer() {
    _timer?.cancel();
  }

  Future<void> _autoLogin() async {
    try {
      final loginController = LoginController();
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

  @override
  void onClose() {
    _stopTimer();
    super.onClose();
  }
}
