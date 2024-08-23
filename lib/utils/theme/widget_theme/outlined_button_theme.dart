import 'package:flutter/material.dart';

import '../../../constants/colors.dart';

class KOutlineedButtonTheme {
  KOutlineedButtonTheme._();

  static final lightOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      foregroundColor: kSecondaryColor,
      side: const BorderSide(color: kSecondaryColor),
      padding: const EdgeInsets.symmetric(vertical: 10),
    ),
  );

  static final darkOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        foregroundColor: kWhiteColor,
        side: const BorderSide(color: kWhiteColor),
        padding: const EdgeInsets.symmetric(vertical: 10)),
  );
}
