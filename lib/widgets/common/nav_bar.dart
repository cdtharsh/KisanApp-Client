import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kisanapp/constants/colors.dart';
import 'package:kisanapp/screens/home/agri.dart';
import 'package:kisanapp/screens/home/community.dart';
import 'package:kisanapp/screens/home/drip.dart';
import 'package:kisanapp/screens/home/home.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      bottomNavigationBar: Obx(
        () => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors:
                    isDark ? [kDarkPurple, kDeepBlue] : [kMintGreen, kLavender],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.vertical(
                  top: Radius.circular(25), bottom: Radius.circular(25)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: Offset(0, -3),
                ),
              ],
            ),
            child: NavigationBar(
              height: 70,
              elevation: 0,
              selectedIndex: controller.selectedIndex.value,
              onDestinationSelected: (index) =>
                  controller.selectedIndex.value = index,
              backgroundColor: Colors.transparent,
              indicatorColor: isDark
                  ? kLavender
                  : kLightPink
                      .withOpacity(0.5), // Soft indicator for light mode
              labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
              destinations: [
                _buildNavigationItem(Icons.home_rounded, 'Home', isDark),
                _buildNavigationItem(Icons.eco_rounded, 'Agri', isDark),
                _buildNavigationItem(Icons.water_drop_rounded, 'Drip', isDark),
                _buildNavigationItem(
                    Icons.shopping_cart_rounded, 'Community', isDark),
              ],
            ),
          ),
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }

  NavigationDestination _buildNavigationItem(
      IconData icon, String label, bool isDark) {
    return NavigationDestination(
      icon: Icon(
        icon,
        size: 28,
        color: isDark ? kLavender : kDeepBlue,
      ),
      selectedIcon: Icon(
        icon,
        size: 32,
        color:
            isDark ? kElectricBlue : kDarkPurple, // High contrast in light mode
      ),
      label: label,
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    HomeScreen(),
    AgriProductPage(),
    DripProductPage(),
    CommunityPage()
  ];
}
