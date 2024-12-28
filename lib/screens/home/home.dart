import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kisanapp/constants/colors.dart';
import 'package:kisanapp/controller/authentication/logout_controller.dart';
import 'package:kisanapp/widgets/layouts/grid_layout.dart';
import 'package:kisanapp/widgets/layouts/product_coursel.dart';

import '../../controller/data/user_data_controller.dart';
import '../../widgets/common/app_bar.dart';

class HomeScreen extends StatelessWidget {
  final UserController userController = Get.put(UserController());
  final LogoutController logoutController = Get.put(LogoutController());
  final List<Map<String, String>> products = [
    {
      'image': 'https://via.placeholder.com/150', // Dummy image URL
      'title': 'Product 1',
      'price': '\₹20'
    },
    {
      'image': 'https://via.placeholder.com/150',
      'title': 'Product 2',
      'price': '\₹30'
    },
    {
      'image': 'https://via.placeholder.com/150',
      'title': 'Product 3',
      'price': '\₹40'
    },
    {
      'image': 'https://via.placeholder.com/150',
      'title': 'Product 4',
      'price': '\₹50'
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
      backgroundColor: isDark ? kDarkPurple : kLavender,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SafeArea(
                child: KAppBar(
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'Make Crop Healthy',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : Colors.black,
                            fontSize: 24,
                            fontFamily: 'Poppins', // Modern font
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      color: isDark ? kDarkColor : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  Icon(Icons.photo,
                                      size: 40, color: Colors.pink.shade300),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Image',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: isDark
                                              ? Colors.white
                                              : Colors.black87,
                                          fontFamily: 'Poppins', // Modern font
                                        ),
                                  ),
                                ],
                              ),
                              Icon(Icons.arrow_forward,
                                  size: 30, color: Colors.purple.shade200),
                              Column(
                                children: [
                                  Icon(Icons.assignment,
                                      size: 40, color: Colors.blue.shade300),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Diagnosis',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: isDark
                                              ? Colors.white
                                              : Colors.black87,
                                          fontFamily: 'Poppins',
                                        ),
                                  ),
                                ],
                              ),
                              Icon(Icons.arrow_forward,
                                  size: 30, color: Colors.purple.shade200),
                              Column(
                                children: [
                                  Icon(Icons.medical_services,
                                      size: 40, color: Colors.orange.shade300),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Medicine',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: isDark
                                              ? Colors.white
                                              : Colors.black87,
                                          fontFamily: 'Poppins',
                                        ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              // Handle button press
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal.shade300,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              minimumSize: const Size(double.infinity, 50),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            child: const Text(
                              'Take a Picture',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.purple.shade100, Colors.blue.shade50],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final double gridItemHeight =
                        (constraints.maxHeight - 30) / 2;
                    final double gridItemWidth =
                        (constraints.maxWidth - 24) / 2;
                    final double aspectRatio = gridItemWidth / gridItemHeight;

                    return GridView.builder(
                      itemCount: 4,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: aspectRatio,
                      ),
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(8),
                      itemBuilder: (context, index) {
                        final items = [
                          {
                            'title': 'Crop Information',
                            'icon': Icons.info,
                            'color': Colors.green.shade300,
                            'background': Colors.green.shade100
                          },
                          {
                            'title': 'Pest and Diseases',
                            'icon': Icons.bug_report,
                            'color': Colors.red.shade300,
                            'background': Colors.red.shade100
                          },
                          {
                            'title': 'Soil Testing',
                            'icon': Icons.medical_information,
                            'color': kDarkColor,
                            'background': Colors.orange.shade100
                          },
                          {
                            'title': 'Alerts',
                            'icon': Icons.error,
                            'color': Colors.pink.shade300,
                            'background': Colors.pink.shade100
                          },
                        ];

                        final item = items[index];
                        return GridCard(
                          title: item['title'] as String,
                          icon: item['icon'] as IconData,
                          iconColor: item['color'] as Color,
                          backgroundColor: item['background'] as Color,
                          height: gridItemHeight,
                          onTap: () {},
                        );
                      },
                    );
                  },
                ),
              ),
            ),
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
