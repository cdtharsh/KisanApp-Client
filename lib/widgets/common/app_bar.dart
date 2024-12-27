import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kisanapp/constants/sizes.dart';
import 'package:kisanapp/constants/colors.dart'; // Import color palette

class KAppBar extends StatelessWidget implements PreferredSizeWidget {
  const KAppBar({
    super.key,
    this.title,
    this.actions,
    this.leadingIcon,
    this.leadingOnPressed,
    this.showBackArrow = false,
    this.iconSize = 30.0,
    this.titleFontSize = 24.0,
    this.titleFontWeight = FontWeight.w700,
    this.backgroundColor = Colors.transparent,
    this.elevation = 8.0,
    this.borderRadius = 40.0,
    this.roundTopLeft = false, // Flag for top-left corner
    this.roundTopRight = false, // Flag for top-right corner
    this.roundBottomLeft = false, // Flag for bottom-left corner
    this.roundBottomRight = false, // Flag for bottom-right corner
  });

  final Widget? title;
  final bool showBackArrow;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback? leadingOnPressed;
  final double iconSize;
  final double titleFontSize;
  final FontWeight titleFontWeight;
  final Color backgroundColor;
  final double elevation;
  final double borderRadius;

  // Flags for deciding which corners to round
  final bool roundTopLeft;
  final bool roundTopRight;
  final bool roundBottomLeft;
  final bool roundBottomRight;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // Apply gradient for a stylish background
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [kBluePurple, kNeonPink], // Gen Z-inspired colors
        ),
        borderRadius: BorderRadius.only(
          topLeft: roundTopLeft ? Radius.circular(borderRadius) : Radius.zero,
          topRight: roundTopRight ? Radius.circular(borderRadius) : Radius.zero,
          bottomLeft:
              roundBottomLeft ? Radius.circular(borderRadius) : Radius.zero,
          bottomRight:
              roundBottomRight ? Radius.circular(borderRadius) : Radius.zero,
        ), // Dynamically round corners based on flags
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 5.0,
            spreadRadius: 1.0,
            offset: Offset(0, 3), // Slight shadow for floating effect
          ),
        ],
      ),
      child: AppBar(
        backgroundColor: Colors
            .transparent, // Make the AppBar background transparent to show the gradient
        automaticallyImplyLeading: false,
        leading: showBackArrow
            ? IconButton(
                onPressed: () => Get.back(),
                icon: Icon(Icons.arrow_left,
                    size: iconSize,
                    color: kElectricBlue)) // Bold icon with electric blue color
            : leadingIcon != null
                ? IconButton(
                    onPressed: leadingOnPressed,
                    icon: Icon(leadingIcon,
                        size: iconSize,
                        color: kElectricBlue)) // Customizable icon
                : null,
        title: title != null
            ? DefaultTextStyle(
                style: TextStyle(
                    color: kLavender,
                    fontSize: titleFontSize,
                    fontWeight: titleFontWeight),
                child: title!)
            : null,
        actions: actions,
        elevation: elevation, // Modern elevation for shadow effect
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + kDefaultSize); // Height of the AppBar
}
