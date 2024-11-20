import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/colors.dart';
import '../../router/routes.dart'; // Ensure your routes file is imported

class CustomSnackbar {
  // Function to extract the error message from the exception
  static String _extractErrorMessage(dynamic e) {
    String errorMessage = 'An error occurred, please try again later.';

    try {
      // If the error is a string, simply return it
      if (e is String) {
        return e;
      }

      // If it's a Map (e.g., the error response is in JSON format)
      if (e is Map && e.containsKey('error')) {
        return e['error'];
      }

      // If the error is an Exception, clean it up and extract the message
      if (e is Exception) {
        final errorString = e.toString();

        // Use regex to extract the error content from nested exceptions
        final match = RegExp(r'{"error":"(.*?)"}').firstMatch(errorString);

        if (match != null) {
          return match.group(1) ?? 'Unknown error occurred';
        } else {
          // Fallback if regex doesn't find a match
          return errorString.split(":").last.trim();
        }
      }
    } catch (jsonError) {
      // If parsing fails, fallback to a generic error message
      return 'Failed to process the error: ${jsonError.toString()}';
    }

    return errorMessage; // Default fallback message
  }

  // Function to show snackbar with extracted error message
  static void show({
    dynamic error,
    required String title,
    Color backgroundColor = kSnakbarBgGreen, // Default color
    IconData? iconData,
    VoidCallback? onPressed,
    String? message,
  }) {
    // Ensure backgroundColor has proper opacity
    if (backgroundColor.opacity == 1.0) {
      backgroundColor = backgroundColor.withOpacity(0.5);
    }

    String extractedMessage = message ?? _extractErrorMessage(error);

    // Check for specific error message
    if (extractedMessage ==
        "Email not verified. A new verification email has been sent to your email address.") {
      Get.snackbar(
        title,
        extractedMessage,
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
        icon: iconData != null
            ? Icon(iconData, color: Colors.white, size: 28.0)
            : null,
        onTap: (_) {
          // Navigate to the email verification page
          Get.toNamed(AppRoutes.email);
        },
      );
      return;
    }

    // Default snackbar for other error messages
    Get.snackbar(
      title,
      extractedMessage,
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
      icon: iconData != null
          ? Icon(iconData, color: Colors.white, size: 28.0)
          : null,
    );
  }
}
