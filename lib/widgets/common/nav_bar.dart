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
      body: Obx(() => Stack(
            children: [
              // Screen content with swipeable pages
              SafeArea(
                child: PageView(
                  controller: controller.pageController,
                  onPageChanged: (index) {
                    controller.selectedIndex.value = index;
                  },
                  physics: BouncingScrollPhysics(),
                  children: controller.screens,
                ),
              ),
              // Floating Navigation Bar
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 50.0, vertical: 10.0),
                  child: Container(
                    height: 80,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: isDark
                            ? [Colors.purple, Colors.blue]
                            : [Colors.pinkAccent, Colors.lightBlue],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 6.0,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildNavigationItem(
                          Icons.home_rounded,
                          'Home',
                          isDark,
                          0,
                          controller,
                        ),
                        _buildNavigationItem(
                          Icons.eco_rounded,
                          'Agri',
                          isDark,
                          1,
                          controller,
                        ),
                        _buildNavigationItem(
                          Icons.water_drop_rounded,
                          'Drip',
                          isDark,
                          2,
                          controller,
                        ),
                        _buildNavigationItem(
                          Icons.group,
                          'Community',
                          isDark,
                          3,
                          controller,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }

  Widget _buildNavigationItem(IconData icon, String label, bool isDark,
      int index, NavigationController controller) {
    bool isSelected = controller.selectedIndex.value == index;

    return GestureDetector(
      onTap: () {
        // Check if the tapped page is already selected to avoid unnecessary transition
        if (controller.selectedIndex.value != index) {
          // Jump directly to the selected page without animating through intermediate pages
          controller.pageController.jumpToPage(index);
          controller.selectedIndex.value = index;
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: isSelected ? 32 : 28, // Slightly larger icon for selected
            color: isSelected
                ? (isDark ? kElectricBlue : kDarkPurple)
                : (isDark ? kLavender : kDeepBlue),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: isSelected
                  ? (isDark ? kElectricBlue : kDarkPurple)
                  : (isDark ? kLavender : kDeepBlue),
            ),
          ),
        ],
      ),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;
  final PageController pageController = PageController();

  final screens = [
    HomeScreen(),
    AgriProductPage(),
    DripProductPage(),
    CommunityPage(),
  ];
}
