import 'package:flutter/material.dart';
import 'package:kisanapp/constants/text_strings.dart';

class NavigationBarWidget extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final bool isDarkMode;

  const NavigationBarWidget({
    Key? key,
    required this.currentIndex,
    required this.onTap,
    required this.isDarkMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
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
            currentIndex: currentIndex,
            onTap: onTap,
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
                  isSelected: currentIndex == 0,
                  isDarkMode: isDarkMode),
              _buildBottomNavItem(
                  icon: Icons.eco,
                  label: kAgri,
                  isSelected: currentIndex == 1,
                  isDarkMode: isDarkMode),
              _buildBottomNavItem(
                  icon: Icons.water_drop,
                  label: kDrip,
                  isSelected: currentIndex == 2,
                  isDarkMode: isDarkMode),
              _buildBottomNavItem(
                  icon: Icons.group,
                  label: kComminuty,
                  isSelected: currentIndex == 3,
                  isDarkMode: isDarkMode),
            ],
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildBottomNavItem({
    required IconData icon,
    required String label,
    required bool isSelected,
    required bool isDarkMode,
  }) {
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
