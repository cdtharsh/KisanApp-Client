import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kisanapp/screens/home/agri.dart';
import 'package:kisanapp/screens/home/community.dart';
import 'package:kisanapp/screens/home/drip.dart';
import 'package:kisanapp/screens/home/home.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());

    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) =>
              controller.selectedIndex.value = index,
          destinations: [
            NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
            NavigationDestination(icon: Icon(Icons.eco), label: 'Agri'),
            NavigationDestination(icon: Icon(Icons.water_drop), label: 'Drip'),
            NavigationDestination(
                icon: Icon(Icons.shopping_cart), label: 'Community')
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
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
