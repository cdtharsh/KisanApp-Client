// validator.dart

import 'package:flutter/material.dart';
import 'package:phone_form_field/phone_form_field.dart';

class CustomValidator {
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

  static String? validateField(String? value, String errorMessage) {
    if (value == null || value.isEmpty) {
      return errorMessage;
    }
    return null;
  }

  // Add more custom validators here if needed.
}
