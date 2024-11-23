import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:kisanapp/constants/text_strings.dart';
import '../../router/routes.dart';
import '../../widgets/signup_form/text_feild.dart';

class EnterEmailScreen extends StatefulWidget {
  const EnterEmailScreen({super.key});

  @override
  EnterEmailScreenState createState() => EnterEmailScreenState();
}

class EnterEmailScreenState extends State<EnterEmailScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController =
      TextEditingController(); // Password controller

  @override
  void dispose() {
    _emailController.dispose(); // Don't forget to dispose the controllers
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black, // Ensures the back button is visible
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Please enter your email address and new password to proceed',
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40.0),
                  // Email TextField
                  CommonTextField(
                    controller:
                        _emailController, // Use the controller for email
                    labelText: 'Email Address',
                    hintText: 'Enter your email here',
                    prefixIcon:
                        const Icon(Clarity.email_line, color: Colors.blue),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 20.0),
                  // Password TextField with "New Password" hint
                  CommonTextField(
                    controller:
                        _passwordController, // Use the controller for password
                    labelText: 'New Password',
                    hintText:
                        'Enter your new password here', // Updated hint text
                    prefixIcon:
                        const Icon(Clarity.lock_line, color: Colors.blue),
                    obscureText: true, // Hides the password text
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(height: 20.0),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Validate email and password before navigating
                        if (_emailController.text.isNotEmpty &&
                            _passwordController.text.isNotEmpty) {
                          Get.toNamed(AppRoutes.otp); // Navigate to OTP screen
                        } else {
                          // Handle the error, maybe show a snackbar
                          Get.snackbar('Error',
                              'Please enter a valid email and new password');
                        }
                      },
                      child: Text(
                        kSubmit,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
