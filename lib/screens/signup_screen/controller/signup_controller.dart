import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kisanapp/utils/constants/text_strings.dart';
import 'package:kisanapp/router/routes.dart';
import 'package:kisanapp/widgets/layouts/custome_snackbar.dart';
import 'package:phone_form_field/phone_form_field.dart';
import '../../../services/api/auth/auth_api_service.dart';

class SignupControllers {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController streetAddressController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();
  final PhoneController mobileController = PhoneController(
      initialValue: const PhoneNumber(isoCode: IsoCode.IN, nsn: ''));

  String countryValue = "";
  String stateValue = "";
  String cityValue = "";
  String address = "";

  final AuthApiService authApiService = AuthApiService();

  String formattedMobileNumber(PhoneNumber phoneNumber) {
    return '+${phoneNumber.countryCode}${phoneNumber.nsn}';
  }

  void updateAddress() {
    address =
        "${streetAddressController.text.isNotEmpty ? streetAddressController.text : ''},"
                "${cityValue.isNotEmpty ? cityValue : ''},"
                "${stateValue.isNotEmpty ? stateValue : ''},"
                "${countryValue.isNotEmpty ? countryValue : ''},"
                "${postalCodeController.text.isNotEmpty ? postalCodeController.text : ''}"
            .replaceAll(', ,', ',')
            .trim();
  }

  Future<Map<String, dynamic>> handleRegister() async {
    String mobileNumber = formattedMobileNumber(mobileController.value);

    try {
      final response = await authApiService.registerUser(
        username: usernameController.text.trim(),
        password: passwordController.text.trim(),
        email: emailController.text.trim(),
        mobile: mobileNumber,
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        address: address.trim(),
      );

      if (response['msg'] ==
          'User registered successfully. Please verify your email.') {
        CustomSnackbar.show(
          title: kSuccess,
          message: response['msg'],
          iconData: Icons.verified,
        );
        Get.toNamed(AppRoutes.email, parameters: {
          'username': usernameController.text.trim(),
          'password': passwordController.text.trim(),
        });
        return response;
      } else {
        throw Exception(response['error'] ?? 'An unknown error occurred.');
      }
    } catch (e) {
      CustomSnackbar.show(
          title: kError,
          error: e,
          iconData: Icons.error,
          backgroundColor: Colors.red);
      rethrow;
    }
  }

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
