import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  final double height;
  final double width;
  final Widget? child;
  final bool isDark;

  const ShimmerWidget({
    super.key,
    required this.height,
    required this.width,
    this.child,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return child ??
        Shimmer.fromColors(
          baseColor: isDark
              ? Colors.grey.shade800 // Darker grey base color for dark theme
              : Colors.grey.shade300, // Lighter grey base color for light theme
          highlightColor: isDark
              ? Colors.blueGrey
                  .shade400 // Subtle blue-grey highlight color for dark theme
              : Colors
                  .blue.shade200, // Light blue highlight color for light theme
          period: Duration(seconds: 2), // Slow shimmer for smoothness
          child: Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.grey.shade600, // Medium grey
                  Colors.blueGrey.shade300, // Blue-grey
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12), // Rounded corners
            ),
          ),
        );
  }
}
