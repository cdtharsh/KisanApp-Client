import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kisanapp/constants/colors.dart';
import 'package:kisanapp/controller/authentication/logout_controller.dart';
import 'package:kisanapp/widgets/layouts/product_coursel.dart';

import '../../controller/data/user_data_controller.dart';
import '../../widgets/layouts/app_bar.dart';
import '../../widgets/layouts/drawer_left.dart';
import '../../widgets/layouts/information_section.dart';
import '../../widgets/layouts/picture_section.dart';

class HomeScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final UserController userController = Get.put(UserController());
  final LogoutController logoutController = Get.put(LogoutController());
  final List<Map<String, String>> products = [
    {
      'image': 'https://via.placeholder.com/150', // Dummy image URL
      'title': 'Product 1',
      'price': '₹20'
    },
    {
      'image': 'https://via.placeholder.com/150',
      'title': 'Product 2',
      'price': '₹30'
    },
    {
      'image': 'https://via.placeholder.com/150',
      'title': 'Product 3',
      'price': '₹40'
    },
    {
      'image': 'https://via.placeholder.com/150',
      'title': 'Product 4',
      'price': '₹50'
    },
  ];

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Retrieve the user data from GetStorage
    final box = GetStorage();
    String firstName = box.read('firstName') ?? 'Guest';
    String lastName = box.read('lastName') ?? '';
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: isDark ? kDarkPurple : kLavender,
      drawer: CustomDrawer(logoutController: logoutController),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SafeArea(
                child: KAppBar(
                  leadingIcon: Icons.menu,
                  leadingOnPressed: () {
                    _scaffoldKey.currentState
                        ?.openDrawer(); // Open the drawer using the GlobalKey
                  },
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 5),
                      Text(
                        'Welcome to the app!',
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge
                            ?.copyWith(color: kWhiteColor, fontSize: 10),
                      ),
                      // Displaying the user's name with proper capitalization
                      Text(
                        '${capitalize(firstName)} ${capitalize(lastName)}',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 15),
                      ),
                    ],
                  ),
                  actions: [
                    IconButton(
                      onPressed: logoutController.logout,
                      icon: Icon(Icons.logout, size: 30, color: Colors.white),
                    ),
                  ],
                  iconSize: 30.0, // Customizable icon size
                  titleFontSize: 26.0, // Customizable title font size
                  titleFontWeight: FontWeight.bold, // Customizable font weight
                  backgroundColor: Colors.transparent, // Gradient background
                  elevation: 10.0, // Custom elevation
                  borderRadius: 25.0, // Rounded corners at the bottom
                  roundBottomLeft: true,
                  roundTopLeft: true,
                  roundBottomRight: true,
                  roundTopRight: true,
                ),
              ),
            ),
            SizedBox(height: 8),
            PictureSection(isDark: isDark),
            InformationSectionCard(),
            ProductCarousel(products: products)
          ],
        ),
      ),
    );
  }

  String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }
}
