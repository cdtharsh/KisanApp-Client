import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

import '../startup/welcome_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final box = GetStorage();
  late Timer _timer;
  int _remainingSeconds = 0;

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
          _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
            setState(() {
              if (_remainingSeconds > 0) {
                _remainingSeconds--;
              } else {
                _timer.cancel();
                _logout();
              }
            });
          });
        } else {
          // Token already expired
          _logout();
        }
      } catch (e) {
        // Handle invalid token
        _logout();
      }
    } else {
      // No token found
      _logout();
    }
  }

  void _logout() {
    box.remove('token');
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
            onPressed: _logout,
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
