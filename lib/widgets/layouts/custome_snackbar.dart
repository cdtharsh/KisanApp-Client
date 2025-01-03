import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSnackbar {
  static void show({
    dynamic error,
    required String title,
    Color backgroundColor = Colors.green,
    IconData? iconData,
    String? message,
  }) {
    String errorMessage = message ?? _extractErrorMessage(error);

    Get.snackbar(
      title,
      errorMessage,
      duration: const Duration(seconds: 3),
      snackPosition: SnackPosition.TOP,
      backgroundColor: backgroundColor,
      colorText: Colors.white,
      borderRadius: 20.0,
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      icon: iconData != null
          ? Icon(iconData, color: Colors.white, size: 28.0)
          : null,
    );
  }

  static String _extractErrorMessage(dynamic error) {
    if (error is String) return error;
    if (error is Exception) return error.toString().split(':').last.trim();
    if (error is Map && error.containsKey('error')) return error['error'];
    return 'An unknown error occurred.';
  }
}
