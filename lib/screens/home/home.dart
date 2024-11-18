import 'dart:async';
import 'package:flutter/material.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import '../../controller/authentication/logout_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
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
                logout();
              }
            });
          });
        } else {
          // Token already expired
          logout();
        }
      } catch (e) {
        // Handle invalid token
        logout();
      }
    } else {
      // No token found
      logout();
    }
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
        actions: const [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: logout,
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
