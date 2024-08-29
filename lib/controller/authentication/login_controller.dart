import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/colors.dart';
import '../../services/api_services.dart';
import '../../utils/notification/custome_snackbar.dart';

class LoginController extends GetxController {
  // TextEditingControllers to manage input fields
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Instance of AuthApiService to handle API requests
  final AuthApiService _authApiService = AuthApiService();

  // ValueNotifier to manage the loading state
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  // Method to handle user login
  Future<void> login() async {
    if (usernameController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty) {
      CustomSnackbar.show(
        title: "Error",
        message: "Username and Password cannot be empty",
        backgroundColor: kSnakbarBgRed,
        iconData: Icons.error_outline,
      );
      return;
    }

    isLoading.value = true;

    try {
      final response = await _authApiService.login(
        username: usernameController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (response['success']) {
        CustomSnackbar.show(
          title: "Login Successful",
          message: response['msg'] ?? "Login successful.",
          backgroundColor: kSnakbarBgGreen,
          iconData: Icons.check_circle_outline,
        );

        Get.offAllNamed('/home');
      } else {
        CustomSnackbar.show(
          title: "Login Error",
          message: response['error'] ?? 'An error occurred',
          backgroundColor: kSnakbarBgRed,
          iconData: Icons.error_outline,
        );
      }
    } catch (error) {
      CustomSnackbar.show(
        title: "Login Error",
        message: error.toString(),
        backgroundColor: kSnakbarBgRed,
        iconData: Icons.error_outline,
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    // Dispose of the TextEditingControllers when the controller is disposed
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
