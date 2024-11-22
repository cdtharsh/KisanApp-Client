import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/authentication/logout_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LogoutController logoutController = Get.put(LogoutController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              logoutController.logout(); // Call the public logout method
            },
          ),
        ],
      ),
      body: Center(
        child: Obx(
          () {
            final hours = (logoutController.remainingSeconds.value ~/ 3600)
                .toString()
                .padLeft(2, '0');
            final minutes =
                ((logoutController.remainingSeconds.value % 3600) ~/ 60)
                    .toString()
                    .padLeft(2, '0');
            final seconds = (logoutController.remainingSeconds.value % 60)
                .toString()
                .padLeft(2, '0');

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Session Expires In:",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Text(
                  "$hours:$minutes:$seconds",
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .copyWith(color: Colors.red),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
