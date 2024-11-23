import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:kisanapp/constants/text_strings.dart';
import 'package:kisanapp/services/pass_api_service.dart';
import '../../router/routes.dart';
import '../../validator/validator.dart';
import '../../widgets/signup_form/text_feild.dart';

class EnterEmailScreen extends StatefulWidget {
  const EnterEmailScreen({super.key});

  @override
  EnterEmailScreenState createState() => EnterEmailScreenState();
}

class EnterEmailScreenState extends State<EnterEmailScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final PassApiService _apiService = PassApiService();
  bool _isLoading = false; // Track the loading status

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true; // Set loading to true when request starts
      });

      try {
        final response = await _apiService.forgetPasswithemail(
          email: _emailController.text,
        );

        setState(() {
          _isLoading = false; // Set loading to false when request finishes
        });

        if (response.containsKey('msg')) {
          Get.snackbar(
            'Success',
            response['msg'],
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );

          Get.toNamed(
            AppRoutes.otp,
            arguments: {
              'email': _emailController.text,
              'password': _passwordController.text,
            },
          );
        } else {
          Get.snackbar(
            'Error',
            'Unexpected server response. Please try again.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      } catch (error) {
        setState(() {
          _isLoading = false; // Set loading to false if there's an error
        });

        Get.snackbar(
          'Error',
          error.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Please enter your email address and new password to proceed',
                      style: Theme.of(context).textTheme.headlineSmall,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40.0),
                    CommonTextField(
                      controller: _emailController,
                      labelText: 'Email Address',
                      hintText: 'Enter your email here',
                      prefixIcon:
                          const Icon(Clarity.email_line, color: Colors.blue),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        return CustomValidator.validateEmail(
                            value, 'Email is required');
                      },
                    ),
                    const SizedBox(height: 20.0),
                    CommonTextField(
                      controller: _passwordController,
                      labelText: 'New Password',
                      hintText: 'Enter your new password here',
                      prefixIcon:
                          const Icon(Clarity.lock_line, color: Colors.blue),
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        return CustomValidator.validatePassword(
                            value, 'Password is required');
                      },
                    ),
                    const SizedBox(height: 20.0),
                    _isLoading
                        ? CircularProgressIndicator() // Show loading indicator when loading
                        : SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _handleSubmit,
                              child: Text(kSubmit),
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
