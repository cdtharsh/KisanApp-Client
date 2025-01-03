import 'package:flutter/material.dart';

import '../../login_screen/controller/logout_controller.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
    required this.logoutController,
  });

  final LogoutController logoutController;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Adding Drawer to the Scaffold
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: Text('Home'),
            onTap: () {
              // Close the drawer when tapped
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Profile'),
            onTap: () {
              // Navigate to Profile page
            },
          ),
          ListTile(
            title: Text('Settings'),
            onTap: () {
              // Navigate to Settings page
            },
          ),
          ListTile(
            title: Text('Logout'),
            onTap: () {
              logoutController.logout();
            },
          ),
        ],
      ),
    );
  }
}
