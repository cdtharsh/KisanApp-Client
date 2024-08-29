import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kisanapp/constants/sizes.dart';
import 'package:kisanapp/constants/text_strings.dart';
import 'package:kisanapp/controller/authentication/login_controller.dart';

class LoginForm extends StatelessWidget {
  LoginForm({super.key});

  final LoginController _loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: kFormHeight - 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Username field
            TextFormField(
              controller: _loginController.usernameController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person_outline_outlined),
                labelText: kEmail,
                hintText: kEmail,
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: kFormHeight - 20),

            // Password field
            TextFormField(
              controller: _loginController.passwordController,
              obscureText: true, // Hide password text
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.fingerprint),
                labelText: kPass,
                hintText: kPass,
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.remove_red_eye_sharp),
              ),
            ),
            const SizedBox(height: kFormHeight - 20),

            // Forgot password link
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  // Handle forgot password logic here
                },
                child: const Text(kForgetPass),
              ),
            ),

            // Login button with loading indicator
            SizedBox(
              width: double.infinity,
              child: ValueListenableBuilder<bool>(
                valueListenable: _loginController.isLoading,
                builder: (context, isLoading, child) {
                  return ElevatedButton(
                    onPressed: isLoading
                        ? null
                        : () {
                            // Trigger the login process
                            _loginController.login();
                          },
                    child: isLoading
                        ? const CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          )
                        : Text(kLogin.toUpperCase()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
