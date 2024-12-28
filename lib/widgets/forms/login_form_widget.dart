import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kisanapp/screens/authentication/email_input_screen.dart';
import 'package:kisanapp/widgets/layouts/forget_card.dart';
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

      if (response['token'] != null) {
        final box = GetStorage();
        box.write('token', response['token']);
        box.write('user', response['user']);

        // Store specific user data (if needed separately)
        box.write('firstName', response['user']['firstName']);
        box.write('lastName', response['user']['lastName']);
        box.write('email', response['user']['email']);
        box.write('username', response['user']['username']);

        CustomSnackbar.show(
          title: 'Login Successful',
          message: response['msg'] ?? 'Welcome!',
          backgroundColor: Colors.green,
          iconData: Icons.check_circle,
        );
        Get.offAllNamed(AppRoutes.navbar);
      }
    } catch (e) {
      if (e.toString().contains('Email is not verified')) {
        Get.toNamed(AppRoutes.email, parameters: {
          'username': usernameController.text,
          'password': passwordController.text,
        });
      } else {
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

  void _showForgetPasswordSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomCard(
                title: kResetViaEmail,
                subtitle: kForgetMailSubTitle,
                leading: const Icon(Icons.email, size: 40, color: Colors.blue),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Handle email reset logic or navigate to the next screen
                  Navigator.pop(context);
                  Get.to(() =>
                      EnterEmailScreen()); // Passing a flag to indicate email
                },
              ),
            ],
          ),
        );
      },
    );
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
                onPressed: () => _showForgetPasswordSheet(context),
                child: const Text(kForgetPass),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isLoading ? null : _handleLogin,
                child: isLoading
                    ? const CircularProgressIndicator.adaptive()
                    : Text(kLogin.toUpperCase()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
