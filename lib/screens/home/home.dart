import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kisanapp/constants/text_strings.dart';
import '../../controller/authentication/logout_controller.dart';

class HomeScreen extends StatelessWidget {
  final LogoutController logoutController = Get.put(LogoutController());

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              logoutController.logout(); // Call the logout method
            },
          ),
        ],
      ),
      body: Center(
        child: Text('Home Screen'),
      ),
    );
  }
}
