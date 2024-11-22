import 'dart:async';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:kisanapp/screens/startup/welcome_screen.dart'; // For navigation

class LogoutController extends GetxController {
  final box = GetStorage();
  late Timer _timer;
  var remainingSeconds = 0.obs;

  @override
  void onInit() {
    super.onInit();
    _startTimer();
  }

  @override
  void onClose() {
    _timer.cancel();
    super.onClose();
  }

  void _startTimer() {
    final token = box.read<String?>('token');

    if (token != null) {
      try {
        final jwt = JWT.decode(token);
        final expirationTime =
            DateTime.fromMillisecondsSinceEpoch(jwt.payload['exp'] * 1000);
        final currentTime = DateTime.now();
        remainingSeconds.value =
            expirationTime.difference(currentTime).inSeconds;

        if (remainingSeconds.value > 0) {
          _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
            if (remainingSeconds.value > 0) {
              remainingSeconds.value--;
            } else {
              _timer.cancel();
              logout();
            }
          });
        } else {
          logout(); // Token expired
        }
      } catch (e) {
        logout(); // Invalid token
      }
    } else {
      logout(); // No token found
    }
  }

  // Function to handle logout
  void logout() {
    box.remove('token');
    box.remove('username');
    Get.offAll(() => const WelcomeScreen());
  }
}
