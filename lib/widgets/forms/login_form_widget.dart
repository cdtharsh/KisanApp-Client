import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../controller/authentication/login_controller.dart';
import '../../constants/text_strings.dart';
import '../../router/routes.dart';
import '../../utils/notification/custome_snackbar.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  LoginFormState createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final LoginController loginController = LoginController();
  bool isLoading = false;

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await loginController.handleLogin(
        usernameController.text,
        passwordController.text,
      );

      // If login is successful and email is verified, proceed
      if (response['token'] != null) {
        final box = GetStorage();
        box.write('token', response['token']);
        box.write('user', response['user']);

        CustomSnackbar.show(
          title: 'Login Successful',
          message: response['msg'] ?? 'Welcome!',
          backgroundColor: Colors.green,
          iconData: Icons.check_circle,
        );
        Get.offAllNamed(AppRoutes.home);
      }
    } catch (e) {
      if (e.toString().contains('Email is not verified')) {
        // Redirect to email verification screen and pass the username
        Get.toNamed(AppRoutes.email, parameters: {
          'username': usernameController.text,
        });
      } else {
        // Handle other errors
        CustomSnackbar.show(
          title: 'Login Failed',
          error: e,
          backgroundColor: Colors.red,
          iconData: Icons.error,
        );
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _togglePasswordVisibility() {
    setState(() {
      loginController.togglePasswordVisibility();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Column(
          children: [
            TextFormField(
              controller: usernameController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person_outline_outlined),
                labelText: kUserName,
                hintText: kUserName,
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: passwordController,
              obscureText: !loginController.isPasswordVisible,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.fingerprint),
                labelText: kPass,
                hintText: kPass,
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                    loginController.isPasswordVisible
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                  onPressed: _togglePasswordVisibility,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Forgot Password Pressed')),
                  );
                },
                child: const Text(kForgetPass),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isLoading ? null : _handleLogin,
                child: isLoading
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                    : Text(kLogin.toUpperCase()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
