import 'package:get/get.dart';
import 'package:kisanapp/screens/spray_condition_screen/spray_conditions.dart';
import 'package:kisanapp/screens/weather_screen/weather_forcast.dart';
import 'package:kisanapp/screens/forget_pass_screen/email_input_screen.dart';
import 'package:kisanapp/screens/otp_screen/otp_screen.dart';
import 'package:kisanapp/screens/login_screen/login_screen.dart';
import 'package:kisanapp/screens/mail_verification_screen/mail_verification.dart';
import 'package:kisanapp/screens/signup_screen/signup_screen.dart';
import 'package:kisanapp/screens/home_screen/home_screen.dart';
import 'package:kisanapp/screens/splash_screen/splash_screen.dart';
import 'package:kisanapp/screens/welcome_screen/welcome_screen.dart';
import 'package:kisanapp/widgets/bars/nav_bar.dart';

import '../screens/preview_screen/preview_screen.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String welcome = '/welcome';
  static const String signup = '/signup';
  static const String home = '/home';
  static const String email = '/email';
  static const String login = '/login';
  static const String inputEmail = '/inputEmail';
  static const String otp = '/otp';
  static const String navbar = '/nav';
  static const String sprayCondition = '/sprayCondition';
  static const String weatherForcast = '/weatherForecast';
  static const String preview = '/preview';

  static List<GetPage> routes = [
    GetPage(name: splash, page: () => const SplashScreen()),
    GetPage(name: welcome, page: () => const WelcomeScreen()),
    GetPage(name: signup, page: () => const SignupScreen()),
    GetPage(name: home, page: () => HomeScreen()),
    GetPage(
      name: email,
      page: () {
        final username = Get.parameters['username'] ?? '';
        final password = Get.parameters['password'] ?? '';
        return MailVerificationScreen(
          username: username,
          password: password,
        );
      },
    ),
    GetPage(name: login, page: () => const LoginScreen()),
    GetPage(name: inputEmail, page: () => EnterEmailScreen()),
    GetPage(
        name: otp,
        page: () {
          final email = Get.parameters['email'] ?? '';
          final password = Get.parameters['password'] ?? '';
          return OTPScreen(
            email: email,
            password: password,
          );
        }),
    GetPage(name: navbar, page: () => const NavigationMenu()),
    GetPage(name: sprayCondition, page: () => const SprayConditionsScreen()),
    GetPage(name: weatherForcast, page: () => const WeatherForcast()),
    GetPage(
      name: preview,
      page: () {
        final imagePath = Get.parameters['imagePath'] ?? '';
        return PreviewPage(imagePath: imagePath);
      },
    ),
  ];
}
