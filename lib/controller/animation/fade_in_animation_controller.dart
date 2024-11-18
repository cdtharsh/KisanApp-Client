import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kisanapp/screens/home/home.dart';
import 'package:kisanapp/screens/startup/welcome_screen.dart';

class FadeInAnimationController extends GetxController {
  static FadeInAnimationController get find => Get.find();

  RxBool animate = false.obs;

  Future<void> startSplashAnimation() async {
    // Start the initial animation
    await Future.delayed(const Duration(milliseconds: 500));
    animate.value = true;

    // Wait for the full animation duration
    await Future.delayed(const Duration(milliseconds: 3000));

    // End the animation before navigation
    animate.value = false;

    // Ensure smooth transition before navigating
    await Future.delayed(const Duration(milliseconds: 1000));

    // Ensure GetStorage is initialized before accessing token
    final box = GetStorage();

    // Debugging: Check if token exists in GetStorage
    final token = box.read<String?>('token');

    // Navigate based on token existence
    if (token != null && token.isNotEmpty) {
      // Navigate to HomeScreen
      Get.off(
        () => const HomeScreen(),
        transition: Transition.fadeIn,
        duration: const Duration(milliseconds: 1000),
      );
    } else {
      // Navigate to WelcomeScreen
      Get.off(
        () => const WelcomeScreen(),
        transition: Transition.fadeIn,
        duration: const Duration(milliseconds: 1000),
      );
    }
  }

  // Animation-In Helper
  Future animationIn() async {
    await Future.delayed(const Duration(milliseconds: 500));
    animate.value = true;
  }

  // Animation-Out Helper
  Future animationOut() async {
    animate.value = false;
    await Future.delayed(const Duration(milliseconds: 100));
  }
}
