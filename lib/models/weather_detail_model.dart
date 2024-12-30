import 'package:flutter/material.dart';

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
        ? Colors.white70 // Light color for dark theme
        : Colors.black87; // Dark color for light theme

    Color labelColor = isDark
        ? Colors.white60 // Soft white for dark theme
        : Colors.black54; // Gray for light theme

    Color valueColor = isDark
        ? Colors.cyanAccent // Bright color for dark theme
        : Colors.blueAccent; // Bright color for light theme

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
