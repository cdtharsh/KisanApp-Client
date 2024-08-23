import 'package:flutter/material.dart';

import '../../../constants/colors.dart';

class KElevatedButtonTheme {
  KElevatedButtonTheme._();

  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        foregroundColor: kWhiteColor,
        backgroundColor: kSecondaryColor,
        side: const BorderSide(color: kSecondaryColor),
        padding: const EdgeInsets.symmetric(vertical: 10)),
  );

  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        foregroundColor: kSecondaryColor,
        backgroundColor: kWhiteColor,
        side: const BorderSide(color: kWhiteColor),
        padding: const EdgeInsets.symmetric(vertical: 10)),
  );
}
