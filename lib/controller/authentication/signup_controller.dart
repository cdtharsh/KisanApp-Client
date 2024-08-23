import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../constants/colors.dart';
import '../../services/api_services.dart';
import '../../utils/notification/custome_snackbar.dart';

class SignUpController extends GetxController {
  final username = TextEditingController();
  final password = TextEditingController();
  final email = TextEditingController();
  final mobile = TextEditingController();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final address = TextEditingController();
  final profileImg = TextEditingController();
  final location = TextEditingController();
  final streetAddress = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final country = TextEditingController();
  final postalCode = TextEditingController();

  PhoneNumber phoneNumber = PhoneNumber(isoCode: 'IN');

  void updateLocationFields(
      String countryName, String stateName, String cityName) {
    country.text = countryName;
    state.text = stateName;
    city.text = cityName;
  }

  final AuthApiService _authApiService = AuthApiService();

  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  Future<void> registerUser() async {
    isLoading.value = true;

    try {
      final response = await _authApiService.registerUser(
        username: username.text.trim(),
        password: password.text.trim(),
        email: email.text.trim(),
        mobile: phoneNumber.phoneNumber ?? '', // Use the formatted number
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        address: address.text.trim(),
        profileImg: profileImg.text.trim(),
        location: location.text.trim(),
      );

      if (response['error'] == null) {
        // Show success snackbar
        CustomSnackbar.show(
          title: "Registration Successful",
          message: response['msg'] ?? "User registration successful.",
          backgroundColor: kSnakbarBgGreen,
          iconData: Icons.check_circle_outline,
        );

        // Navigate to the email verification page with the email parameter
        Get.toNamed('/email', parameters: {'email': email.text.trim()});  // Pass the email parameter
      } else {
        CustomSnackbar.show(
          title: "Registration Error",
          message: response['error'] ?? 'An error occurred',
          backgroundColor: kSnakbarBgRed,
          iconData: Icons.error_outline,
        );
      }
    } catch (error) {
      CustomSnackbar.show(
        title: "Registration Error",
        message: error.toString(),
        backgroundColor: kSnakbarBgRed,
        iconData: Icons.error_outline,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
