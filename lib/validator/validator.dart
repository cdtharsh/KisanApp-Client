import 'package:flutter/material.dart';
import 'package:phone_form_field/phone_form_field.dart';

class CustomValidator {
  /// Validator for phone numbers
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
      return errorMessage; // Return error message if the field is empty
    }

    // Regular expression for validating email
    const emailRegex = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';

    if (!RegExp(emailRegex).hasMatch(value)) {
      return 'Please enter a valid email address.';
    }

    return null; // If no errors, return null
  }

  /// Password validator
  static String? validatePassword(String? value, String errorMessage) {
    if (value == null || value.isEmpty) {
      return errorMessage;
    }

    // Regular expression for a strong password:
    // Minimum 8 characters, at least one uppercase letter, one lowercase letter, one number, and one special character.
    const passwordRegex =
        r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$';

    if (!RegExp(passwordRegex).hasMatch(value)) {
      return 'Password must be at least 8 characters long, include an uppercase letter, a number, and a special character.';
    }

    return null; // If no errors, return null
  }
}
