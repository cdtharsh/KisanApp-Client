import 'dart:async';
import 'package:flutter/material.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:get_storage/get_storage.dart'; // Assuming you're using GetStorage
import 'package:get/get.dart';
import 'package:kisanapp/screens/startup/welcome_screen.dart'; // For navigation

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  late Timer _timer;
  int _remainingSeconds = 0;
  final box = GetStorage();

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    final token = box.read<String?>('token');

    if (token != null) {
      try {
        final jwt = JWT.decode(token);
        final expirationTime =
            DateTime.fromMillisecondsSinceEpoch(jwt.payload['exp'] * 1000);
        final currentTime = DateTime.now();
        _remainingSeconds = expirationTime.difference(currentTime).inSeconds;

        if (_remainingSeconds > 0) {
          // Only update the UI when needed
          _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
            if (_remainingSeconds > 0) {
              setState(() {
                _remainingSeconds--;
              });
            } else {
              _timer.cancel();
              // Handle token expiration logic here if needed
            }
          });
        } else {
          // Token already expired
          // Handle token expiration logic here if needed
        }
      } catch (e) {
        // Handle invalid token and handle expiration logic
      }
    } else {
      // No token found
      // Handle logic when no token is available
    }
  }

  // Function to handle logout
  void _logout() {
    // Remove the token from GetStorage
    box.remove('token');
    box.remove('username');
    // Redirect to the welcome or login screen
    Get.offAll(() => const WelcomeScreen());
  }

  @override
  Widget build(BuildContext context) {
    final hours = (_remainingSeconds ~/ 3600).toString().padLeft(2, '0');
    final minutes =
        ((_remainingSeconds % 3600) ~/ 60).toString().padLeft(2, '0');
    final seconds = (_remainingSeconds % 60).toString().padLeft(2, '0');

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout, // Call the _logout function on button press
          ),
        ],
      ),
      body: Center(
        child: Column(
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
        ),
      ),
    );
  }
}
