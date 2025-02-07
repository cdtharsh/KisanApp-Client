import 'package:flutter/material.dart';

import 'widget_theme/elevated_button_theme.dart';
import 'widget_theme/outlined_button_theme.dart';
import 'widget_theme/text_theme.dart';

class KAppTheme {
  KAppTheme._();

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    textTheme: KTextTheme.lightTextTheme,
    outlinedButtonTheme: KOutlineedButtonTheme.lightOutlinedButtonTheme,
    elevatedButtonTheme: KElevatedButtonTheme.lightElevatedButtonTheme,
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    textTheme: KTextTheme.darkTextTheme,
    outlinedButtonTheme: KOutlineedButtonTheme.darkOutlinedButtonTheme,
    elevatedButtonTheme: KElevatedButtonTheme.darkElevatedButtonTheme,
  );
}
