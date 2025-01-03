import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kisanapp/utils/constants/sizes.dart';
import 'package:kisanapp/utils/constants/colors.dart';

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
    this.roundTopLeft = false,
    this.roundTopRight = false,
    this.roundBottomLeft = false,
    this.roundBottomRight = false,
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

  final bool roundTopLeft;
  final bool roundTopRight;
  final bool roundBottomLeft;
  final bool roundBottomRight;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [kBluePurple, kNeonPink], // Vibrant gradient colors
        ),
        borderRadius: _buildBorderRadius(),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 5.0,
            spreadRadius: 1.0,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        leading: _buildLeadingIcon(),
        title: _buildTitle(),
        actions: actions,
        elevation: elevation,
      ),
    );
  }

  BorderRadius _buildBorderRadius() {
    return BorderRadius.only(
      topLeft: roundTopLeft ? Radius.circular(borderRadius) : Radius.zero,
      topRight: roundTopRight ? Radius.circular(borderRadius) : Radius.zero,
      bottomLeft: roundBottomLeft ? Radius.circular(borderRadius) : Radius.zero,
      bottomRight:
          roundBottomRight ? Radius.circular(borderRadius) : Radius.zero,
    );
  }

  Widget? _buildLeadingIcon() {
    if (showBackArrow) {
      return IconButton(
        onPressed: () => Get.back(),
        icon: Icon(
          Icons.arrow_back,
          size: iconSize,
          color: kElectricBlue,
        ),
      );
    }
    if (leadingIcon != null) {
      return IconButton(
        onPressed: leadingOnPressed,
        icon: Icon(
          leadingIcon,
          size: iconSize,
          color: kElectricBlue,
        ),
      );
    }
    return null;
  }

  Widget? _buildTitle() {
    if (title != null) {
      return DefaultTextStyle(
        style: TextStyle(
          color: kLavender,
          fontSize: titleFontSize,
          fontWeight: titleFontWeight,
        ),
        child: title!,
      );
    }
    return null;
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + kDefaultSize);
}
