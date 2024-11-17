import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kisanapp/constants/sizes.dart';
import 'package:kisanapp/constants/text_strings.dart';
import 'package:kisanapp/router/routes.dart';
import '../../../controller/authentication/login_controller.dart';

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

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response['msg'])),
        );
        Get.offAllNamed(AppRoutes.home);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('HTTP Exception: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
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
        padding: const EdgeInsets.symmetric(vertical: kFormHeight - 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            const SizedBox(height: kFormHeight - 20),
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
                        ? Icons.visibility_off_sharp
                        : Icons.remove_red_eye_sharp,
                  ),
                  onPressed: _togglePasswordVisibility,
                ),
              ),
            ),
            const SizedBox(height: kFormHeight - 20),
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
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
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
