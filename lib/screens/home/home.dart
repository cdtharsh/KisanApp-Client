import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kisanapp/constants/colors.dart';
import 'package:kisanapp/controller/authentication/logout_controller.dart';
import 'package:kisanapp/widgets/layouts/grid_layout.dart';

import '../../controller/data/user_data_controller.dart';
import '../../widgets/common/app_bar.dart';

class HomeScreen extends StatelessWidget {
  final UserController userController = Get.put(UserController());
  final LogoutController logoutController = Get.put(LogoutController());

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Retrieve the user data from GetStorage
    final box = GetStorage();
    String firstName = box.read('firstName') ?? 'Guest';
    String lastName = box.read('lastName') ?? '';
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
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
                      SizedBox(height: 10),
                      Text(
                        'Welcome to the app!',
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge
                            ?.copyWith(color: kWhiteColor),
                      ),
                      // Displaying the user's name with proper capitalization
                      Text(
                        '${capitalize(firstName)} ${capitalize(lastName)}',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
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
            SizedBox(
              height: 8,
            ),
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
                  )
                ],
              ),
            ),
            // Replace the current card layout with a GridView
            Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
                height: 200, // Fixed height of the grid container
                width: double.infinity, // Full width of the parent container
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.purple.shade100, Colors.blue.shade50],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius:
                      BorderRadius.circular(16), // Rounded edges for container
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 12,
                      offset:
                          const Offset(0, 6), // Slight shadow offset for depth
                    ),
                  ],
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    // Calculate dynamic aspect ratio for the grid items
                    final double gridItemHeight = (constraints.maxHeight - 30) /
                        2; // Two rows with spacing
                    final double gridItemWidth = (constraints.maxWidth - 24) /
                        2; // Two columns with spacing
                    final double aspectRatio = gridItemWidth / gridItemHeight;

                    return GridView.builder(
                      itemCount: 4, // Total number of cards
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Two items per row
                        crossAxisSpacing: 12, // Spacing between columns
                        mainAxisSpacing: 12, // Spacing between rows
                        childAspectRatio: aspectRatio, // Dynamically calculated
                      ),
                      physics:
                          const NeverScrollableScrollPhysics(), // Prevent grid scrolling
                      padding:
                          const EdgeInsets.all(8), // Padding around the grid
                      itemBuilder: (context, index) {
                        // Data for the grid items
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
                            'color': Colors.orange.shade300,
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
                          height:
                              gridItemHeight, // Dynamically calculated height
                          onTap: () {
                            // Handle tap actions here
                            debugPrint('${item['title']} clicked!');
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper function to capitalize the first letter of a string
  String capitalize(String text) {
    if (text.isEmpty) {
      return text;
    }
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }
}
