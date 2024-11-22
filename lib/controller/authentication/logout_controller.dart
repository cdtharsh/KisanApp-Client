import 'dart:async';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kisanapp/screens/startup/welcome_screen.dart';

class LogoutController extends GetxController {
  Timer? _timer; // Timer to manage session expiration
  int _remainingSeconds = 0; // Track remaining session time
  RxBool isLoggedOut = false.obs; // Flag to track the logout state
  GetStorage box = GetStorage();
  @override
  void onInit() {
    super.onInit();
    _startTimer();
  }

  @override
  void onClose() {
    _timer?.cancel(); // Safely cancel the timer if it's initialized
    super.onClose();
  }

  // Function to start the timer
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
            if (_remainingSeconds > 0) {
              _remainingSeconds--;
            } else {
              _timer?.cancel();
              logout(); // Logout when session expires
            }
            update(); // Trigger UI update
          });
        } else {
          // Token already expired, manually logout
          logout();
        }
      } catch (e) {
        // Handle invalid token or decoding error
        logout();
      }
    } else {
      // No token found, logout
      logout();
    }
  }

  // Async logout function
  Future<void> logout() async {
    try {
      // Perform any necessary cleanup before logging out
      await Future.delayed(
          const Duration(milliseconds: 500)); // Simulate async operation

      // Remove the token and user data from storage
      await box.remove('token');
      await box.remove('user');

      // Set logout flag
      isLoggedOut.value = true;

      // Navigate to the Welcome screen
      Get.offAll(() => const WelcomeScreen());
    } catch (e) {
      // Handle any errors during logout (optional)
      print("Error during logout: $e");
    }
  }

  // Getters for remaining time
  String get remainingTime {
    final hours = (_remainingSeconds ~/ 3600).toString().padLeft(2, '0');
    final minutes =
        ((_remainingSeconds % 3600) ~/ 60).toString().padLeft(2, '0');
    final seconds = (_remainingSeconds % 60).toString().padLeft(2, '0');
    return "$hours:$minutes:$seconds";
  }
}
