import 'package:get/get.dart';

import '../utils/router/routes.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  late final Rx<User?> apiUser = Rx<User?>(null);

  @override
  void onReady() {
    super.onReady();
    Future.delayed(const Duration(seconds: 6));
    setInitialScreen(apiUser.value);
  }

  void setInitialScreen(User? user) async {
    if (user == null) {
      await Future.delayed(const Duration(milliseconds: 4000));
      Get.offNamed(AppRoutes.welcome);
    } else {
      await Future.delayed(const Duration(milliseconds: 4000));
      user.emailVerified
          ? Get.offAllNamed(AppRoutes.home)
          : Get.offAllNamed(AppRoutes.email);
    }
  }

  // Future<String?> createUserWithEmailAndPassword(
  //     String email, String password) async {
  //   try {
  //     final response = await _authApiService.registerUser(
  //       username: '', // Provide a username if required
  //       password: password,
  //       email: email,
  //       mobile: '', // Provide mobile number if required
  //       firstName: '', // Provide first name if required
  //       lastName: '', // Provide last name if required
  //       address: '', // Provide address if required
  //       profileImg: '', // Provide profile image if required
  //       location: '', // Provide location if required
  //     );

  //     if (response['success']) {
  //       // Handle successful registration (e.g., set user state)
  //       apiUser.value = User(email: email, emailVerified: false); // Adjust based on your user model
  //       await sendEmailVerification(); // Send verification email
  //       Get.offAllNamed(AppRoutes.email); // Navigate to email verification page
  //     } else {
  //       return response['error'];
  //     }
  //   } catch (error) {
  //     return "An unknown error occurred.";
  //   }
  //   return null;
  // }

  // Future<String?> loginWithEmailAndPassword(
  //     String email, String password) async {
  //   try {
  //     final response = await _authApiService.login(
  //       email: email,
  //       password: password,
  //     );

  //     if (response['success']) {
  //       // Handle successful login (e.g., set user state)
  //       apiUser.value = User(email: email, emailVerified: response['emailVerified']);
  //       return null;
  //     } else {
  //       return response['error'];
  //     }
  //   } catch (error) {
  //     return "An unknown error occurred.";
  //   }
  // }

  // Future<void> sendEmailVerification() async {
  //   try {
  //     final response = await _authApiService.sendEmailVerification(email: '');
  //     if (response['error'] != null) {
  //       throw response['error'];
  //     }
  //   } catch (error) {
  //     throw error.toString();
  //   }
  // }

  // Future<void> logout() async {
  //   try {
  //     final response = await _authApiService.logout();
  //     if (response['success']) {
  //       Get.offAllNamed(AppRoutes.welcome);
  //     } else {
  //       throw response['error'];
  //     }
  //   } catch (error) {
  //     throw error.toString();
  //   }
  // }
}

class User {
  final String email;
  final bool emailVerified;

  User({
    required this.email,
    required this.emailVerified,
  });
}
