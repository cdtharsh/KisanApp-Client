import 'package:get/get.dart';
import 'package:kisanapp/pages/spray_conditions.dart';
import 'package:kisanapp/pages/weather_forcast.dart';
import 'package:kisanapp/screens/authentication/email_input_screen.dart';
import 'package:kisanapp/screens/authentication/otp_screen.dart';
import 'package:kisanapp/screens/authentication/login_screen.dart';
import 'package:kisanapp/screens/authentication/mail_verification.dart';
import 'package:kisanapp/screens/authentication/signup_screen.dart';
import 'package:kisanapp/screens/home/home.dart';
import 'package:kisanapp/screens/startup/splash_screen.dart';
import 'package:kisanapp/screens/startup/welcome_screen.dart';
import 'package:kisanapp/widgets/layouts/nav_bar.dart';

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
  ];
}
