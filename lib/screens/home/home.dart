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
            KAppBar(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Welcome to the app!',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  // Displaying the user's name with proper capitalization
                  Text(
                    '${capitalize(firstName)} ${capitalize(lastName)}',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ],
              ),
              actions: [
                IconButton(
                    onPressed: logoutController.logout,
                    icon: Icon(Icons.logout))
              ],
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
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      color: isDark ? kDarkColor : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  Icon(Icons.photo,
                                      size: 40, color: Colors.green),
                                  SizedBox(height: 8),
                                  Text(
                                    'Image',
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                ],
                              ),
                              Icon(Icons.arrow_forward, size: 30),
                              Column(
                                children: [
                                  Icon(Icons.assignment,
                                      size: 40, color: Colors.blue),
                                  SizedBox(height: 8),
                                  Text(
                                    'Diagnosis',
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                ],
                              ),
                              Icon(Icons.arrow_forward, size: 30),
                              Column(
                                children: [
                                  Icon(Icons.medical_services,
                                      size: 40, color: Colors.orange),
                                  SizedBox(height: 8),
                                  Text(
                                    'Medicine',
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
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
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              minimumSize: const Size(double.infinity, 50),
                            ),
                            child: const Text(
                              'Take a Picture',
                              style: TextStyle(fontSize: 18),
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
              padding: EdgeInsets.all(8),
              child: GridCard(
                  title: 'Crop Information',
                  icon: Icons.info,
                  iconColor: Colors.green,
                  height: 80),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: GridCard(
                  title: 'Pest and diseases',
                  icon: Icons.bug_report,
                  iconColor: Colors.red,
                  height: 80),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: GridCard(
                  title: 'Soil Testing',
                  icon: Icons.medical_information,
                  iconColor: Colors.orange,
                  height: 80),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: GridCard(
                  title: 'Alerts',
                  icon: Icons.error,
                  iconColor: Colors.pink,
                  height: 80),
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
