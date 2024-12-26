import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kisanapp/controller/authentication/logout_controller.dart';

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

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            KAppBar(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome to the app!',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  // Displaying the user's name with proper capitalization
                  Text(
                    '${capitalize(firstName)} ${capitalize(lastName)}',
                    style: Theme.of(context).textTheme.headlineSmall!,
                  ),
                ],
              ),
              actions: [
                IconButton(
                    onPressed: logoutController.logout,
                    icon: Icon(Icons.logout))
              ],
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
