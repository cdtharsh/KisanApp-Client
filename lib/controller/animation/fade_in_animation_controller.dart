import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kisanapp/screens/home/home.dart';
import 'package:kisanapp/screens/startup/welcome_screen.dart';

class FadeInAnimationController extends GetxController {
  static FadeInAnimationController get find => Get.find();

  RxBool animate = false.obs;

  Future<void> startSplashAnimation() async {
    await Future.delayed(const Duration(milliseconds: 500));
    animate.value = true;
    await Future.delayed(const Duration(milliseconds: 3000));
    animate.value = false;

    // Ensure GetStorage is initialized before accessing token
    final box = GetStorage();

    // Debugging: Check if token exists in GetStorage
    final token = box.read<String?>('token');

    // Navigate based on token existence
    if (token != null && token.isNotEmpty) {
      Get.off(
        () => const HomeScreen(),
        transition: Transition.fadeIn,
        duration: const Duration(milliseconds: 1000),
      );
    } else {
      Get.off(
        () => const WelcomeScreen(),
        transition: Transition.fadeIn,
        duration: const Duration(milliseconds: 1000),
      );
    }
  }

  Future animationIn() async {
    await Future.delayed(const Duration(milliseconds: 500));
    animate.value = true;
  }

  Future animationOut() async {
    animate.value = false;
    await Future.delayed(const Duration(milliseconds: 100));
  }
}
