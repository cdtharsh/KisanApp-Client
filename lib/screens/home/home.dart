import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kisanapp/constants/text_strings.dart';

import '../../controller/authentication/logout_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final LogoutController logoutController = Get.put(LogoutController());
  int _currentIndex = 0;

  final List<Widget> _pages = [
    Center(
      child: Text(
        'Home Page',
        style: TextStyle(
            fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blueGrey),
      ),
    ),
    Center(
      child: Text(
        'AgriProduct Page',
        style: TextStyle(
            fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
      ),
    ),
    Center(
      child: Text(
        'Drip Accessories Page',
        style: TextStyle(
            fontSize: 24, fontWeight: FontWeight.bold, color: Colors.teal),
      ),
    ),
    Center(
      child: Text(
        'Community Page',
        style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // Detect the current theme mode (light or dark)
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          kAppName,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              logoutController.logout(); // Call the public logout method
            },
          ),
        ],
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _pages[_currentIndex],
        switchInCurve: Curves.easeIn,
        switchOutCurve: Curves.easeOut,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0), // Reduced padding for smaller bar
        child: Container(
          decoration: BoxDecoration(
            gradient: isDarkMode
                ? const LinearGradient(
                    colors: [Colors.deepPurple, Colors.black],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : const LinearGradient(
                    colors: [Colors.purple, Colors.blueAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
            borderRadius: BorderRadius.circular(12.0), // Slightly rounded edges
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.white,
              unselectedItemColor: isDarkMode ? Colors.grey[300] : Colors.grey,
              backgroundColor: Colors.transparent,
              showUnselectedLabels: true,
              selectedLabelStyle: const TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 12), // Smaller label
              unselectedLabelStyle:
                  const TextStyle(fontSize: 10), // Smaller unselected label
              items: [
                _buildBottomNavItem(
                    icon: Icons.home,
                    label: kHome,
                    isSelected: _currentIndex == 0,
                    isDarkMode: isDarkMode),
                _buildBottomNavItem(
                    icon: Icons.eco,
                    label: kAgri,
                    isSelected: _currentIndex == 1,
                    isDarkMode: isDarkMode),
                _buildBottomNavItem(
                    icon: Icons.water_drop,
                    label: kDrip,
                    isSelected: _currentIndex == 2,
                    isDarkMode: isDarkMode),
                _buildBottomNavItem(
                    icon: Icons.group,
                    label: kComminuty,
                    isSelected: _currentIndex == 3,
                    isDarkMode: isDarkMode),
              ],
            ),
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildBottomNavItem(
      {required IconData icon,
      required String label,
      required bool isSelected,
      required bool isDarkMode}) {
    return BottomNavigationBarItem(
      icon: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(
            horizontal: 6, vertical: 2), // Reduced padding
        decoration: isSelected
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                gradient: isDarkMode
                    ? const LinearGradient(
                        colors: [Colors.deepPurple, Colors.black],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : const LinearGradient(
                        colors: [Colors.purple, Colors.blueAccent],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
              )
            : null,
        child: Icon(
          icon,
          size: isSelected ? 20 : 18,
          color: isSelected
              ? Colors.white
              : (isDarkMode ? Colors.white : Colors.grey),
        ),
      ),
      label: label,
    );
  }
}
