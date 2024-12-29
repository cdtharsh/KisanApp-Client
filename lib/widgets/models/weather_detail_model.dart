import 'package:flutter/material.dart';
import 'package:kisanapp/constants/colors.dart';

class WeatherDetail extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const WeatherDetail({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    // Apply colors based on dark or light theme
    Color iconColor = isDark
        ? kLightText
        : kDarkPurple; // Light color for dark theme, Dark Purple for light theme
    Color labelColor = isDark
        ? kAccentCoolGray
        : kDarkSlateGray; // Soft gray for dark theme, dark slate gray for light theme
    Color valueColor =
        kVividBlue; // Vivid Blue for the value to ensure good contrast on both backgrounds

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: iconColor,
          size: 30,
        ),
        SizedBox(height: 5),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: labelColor,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: valueColor,
          ),
        ),
      ],
    );
  }
}
