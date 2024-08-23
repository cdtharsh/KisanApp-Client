import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/colors.dart';

class CustomSnackbar {
  static void show({
    required String title,
    required String message,
    Color backgroundColor = kSnakbarBgGreen,
    IconData? iconData,
    VoidCallback? onPressed,
  }) {
    Get.snackbar(
      title,
      message,
      duration: const Duration(seconds: 3),
      snackPosition: SnackPosition.TOP,
      backgroundColor: backgroundColor,
      colorText: Colors.white,
      borderRadius: 20.0,
      margin: const EdgeInsets.all(20.0),
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.easeInOut,
      reverseAnimationCurve: Curves.easeIn,
      animationDuration: const Duration(milliseconds: 500),
      snackStyle: SnackStyle.FLOATING,
      icon: iconData != null ? Icon(iconData, color: Colors.white, size: 28.0) : null,
      shouldIconPulse: true,
      snackbarStatus: (status) {
        if (status == SnackbarStatus.CLOSING) {
        }
      },
    );
  }
}
