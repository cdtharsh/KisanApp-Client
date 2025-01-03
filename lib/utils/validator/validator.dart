import 'package:flutter/material.dart';
import 'package:phone_form_field/phone_form_field.dart';

class CustomValidator {
  /// General field validator
  static String? validateField(String? value, String errorMessage) {
    if (value == null || value.isEmpty) {
      return errorMessage;
    }
    return null;
  }

  /// Email validator
  static String? validateEmail(String? value, String errorMessage) {
    if (value == null || value.isEmpty) {
      return errorMessage;
    }

    const emailRegex = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    if (!RegExp(emailRegex).hasMatch(value)) {
      return 'Please enter a valid email address.';
    }

    return null;
  }

  /// Password validator
  static String? validatePassword(String? value, String errorMessage) {
    if (value == null || value.isEmpty) {
      return errorMessage;
    }

    // Password criteria: At least 8 characters, 1 uppercase, 1 lowercase, 1 digit, 1 special char
    const passwordRegex =
        r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$';
    if (!RegExp(passwordRegex).hasMatch(value)) {
      return 'Password must be at least 8 characters, include an uppercase letter, a number, and a special character.';
    }

    return null;
  }

  /// Confirm Password validator
  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != password) {
      return 'Passwords do not match';
    }
    return null;
  }

  /// Password requirements checker
  static List<bool> checkPasswordRequirements(String value) {
    List<bool> requirementsMet = [
      value.length >= 8, // At least 8 characters
      RegExp(r'[a-z]')
          .hasMatch(value), // Contains at least one lowercase letter
      RegExp(r'[0-9]').hasMatch(value), // Contains at least one digit
      RegExp(r'[!@#$%^&*(),.?":{}|<>]')
          .hasMatch(value), // Contains at least one special character
      RegExp(r'[A-Z]').hasMatch(value), // Contains at least one capital letter
    ];
    return requirementsMet;
  }

  /// Phone number validator
  static PhoneNumberInputValidator? getPhoneValidator(BuildContext context,
      {required bool mobileOnly}) {
    List<PhoneNumberInputValidator> validators = [];
    if (mobileOnly) {
      validators.add(PhoneValidator.validMobile(context));
    } else {
      validators.add(PhoneValidator.valid(context));
    }
    return validators.isNotEmpty ? PhoneValidator.compose(validators) : null;
  }
}
