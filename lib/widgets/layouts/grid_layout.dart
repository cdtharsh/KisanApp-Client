import 'package:flutter/material.dart';

class GridCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconColor;
  final double height;
  final double? width; // Optional width for flexibility
  final double borderRadius;
  final Color? backgroundColor;
  final Color? textColor;
  final VoidCallback? onTap; // For click actions
  final TextStyle? textStyle; // Custom text style

  const GridCard({
    super.key,
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.height,
    this.width, // Optional parameter for width
    this.borderRadius = 12.0, // Default rounded corners
    this.backgroundColor, // Optional background color
    this.textColor, // Optional text color
    this.onTap, // Optional tap action
    this.textStyle, // Optional text style for title
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width, // Uses specified width or defaults to flexible width
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.blue.shade200, // Default color
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: iconColor.withOpacity(0.2),
                child: Icon(icon, color: iconColor),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: textStyle ??
                      Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: textColor ?? Colors.black,
                          fontWeight: FontWeight.bold),
                ),
              ),
              const Icon(Icons.arrow_forward, color: Colors.black54),
            ],
          ),
        ),
      ),
    );
  }
}
