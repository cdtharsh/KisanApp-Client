import 'package:get/get.dart';
import 'package:kisanapp/screens/authentication/login_screen.dart';
import 'package:kisanapp/screens/authentication/mail_verification.dart';
import 'package:kisanapp/screens/authentication/signup_screen.dart';
import 'package:kisanapp/screens/home/home.dart';
import 'package:kisanapp/screens/startup/splash_screen.dart';
import 'package:kisanapp/screens/startup/welcome_screen.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String welcome = '/welcome';
  static const String signup = '/signup';
  static const String home = '/home';
  static const String email = '/email';
  static const String login = '/login';

  static List<GetPage> routes = [
    GetPage(name: splash, page: () => const SplashScreen()),
    GetPage(name: welcome, page: () => const WelcomeScreen()),
    GetPage(name: signup, page: () => const SignupScreen()),
    GetPage(name: home, page: () => const HomeScreen()),
    GetPage(
      name: email,
      page: () {
        final email =
            Get.parameters['email'] ?? ''; // Retrieve the email parameter
        return MailVerificationScreen(email: email);
      },
    ),
    GetPage(name: login, page: ()=> const LoginScreen()),
  ];
}
