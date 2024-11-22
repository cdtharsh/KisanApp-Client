import 'package:flutter/material.dart';
import 'package:phone_form_field/phone_form_field.dart';

import '../../services/auth_api_service.dart';

class SignupControllers {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController streetAddressController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();
  final PhoneController mobileController = PhoneController(
      initialValue: const PhoneNumber(isoCode: IsoCode.IN, nsn: ''));

  // Store country, state, and city values for Country Picker
  String countryValue = "";
  String stateValue = "";
  String cityValue = "";
  String address = "";

  final AuthApiService authApiService = AuthApiService();

  // Helper method to format the mobile number
  String formattedMobileNumber(PhoneNumber phoneNumber) {
    return '+${phoneNumber.countryCode}${phoneNumber.nsn}';
  }

  void updateAddress() {
    // Construct the full address string without the country flag
    address =
        "${streetAddressController.text.isNotEmpty ? streetAddressController.text : ''},"
                "${cityValue.isNotEmpty ? cityValue : ''},"
                "${stateValue.isNotEmpty ? stateValue : ''},"
                "${countryValue.isNotEmpty ? countryValue : ''},"
                "${postalCodeController.text.isNotEmpty ? postalCodeController.text : ''}"
            .replaceAll(', ,', ',')
            .trim();
  }

  Future<void> register() async {}

  void dispose() {
    usernameController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    streetAddressController.dispose();
    postalCodeController.dispose();
    mobileController.dispose();
  }
}
