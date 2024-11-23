import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kisanapp/services/pass_api_service.dart';
import 'package:pinput/pinput.dart';
import 'package:get/get.dart'; // Import GetX for handling arguments

import '../../constants/sizes.dart';
import '../../constants/text_strings.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key});

  @override
  OTPScreenState createState() => OTPScreenState();
}

class OTPScreenState extends State<OTPScreen> {
  // TextEditingController to hold OTP input
  final TextEditingController _otpController = TextEditingController();

  // New password
  final TextEditingController _newPasswordController = TextEditingController();

  // Create the PassApiService instance
  final PassApiService _apiservice = PassApiService();

  @override
  Widget build(BuildContext context) {
    // Extract the passed arguments (email)
    final Map<String, dynamic> arguments = Get.arguments;
    final String email = arguments['email'] ?? '';

    // Define the default styling for the PIN input fields
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: GoogleFonts.montserrat(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black.withOpacity(0.3)),
      ),
    );

    // Define focused and submitted styles for better UX
    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.blue),
        color: Colors.blue.withOpacity(0.1),
      ),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.green),
        color: Colors.green.withOpacity(0.1),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
        ),
        title: Text(
          "Verify OTP",
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: Container(
        padding: const EdgeInsets.all(kDefaultSize),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              kOtpTitle,
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.bold,
                fontSize: 40.0,
              ),
            ),
            Text(
              kOtpSubTitle.toUpperCase(),
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 40.0),
            Text(
              "$kOtpMessage $email",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20.0),
            Pinput(
              controller: _otpController,
              length: 6, // Number of OTP fields
              defaultPinTheme: defaultPinTheme,
              focusedPinTheme: focusedPinTheme,
              submittedPinTheme: submittedPinTheme,
              showCursor: true,
              cursor: Column(
                children: [
                  Container(
                    height: 1,
                    width: 30,
                    color: Colors.blue,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            TextField(
              controller: _newPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'New Password',
                hintText: 'Enter your new password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  // Get the OTP and new password
                  final String otp = _otpController.text;
                  final String newPassword = _newPasswordController.text;

                  if (otp.isEmpty || newPassword.isEmpty) {
                    // Display error if OTP or password is empty
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please fill in all fields')),
                    );
                    return;
                  }

                  try {
                    // Call the reset password API method
                    final response = await _apiservice.resetPasswithEmail(
                      email: email,
                      otp: otp,
                      newPassword: newPassword,
                    );

                    if (response['msg'] ==
                        'Password has been reset successfully.') {
                      // Handle successful reset
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Password reset successful')),
                      );
                      // Navigate to the login screen or any other screen
                      Get.toNamed('/login'); // Adjust route if needed
                    } else {
                      // Handle failure (e.g., incorrect OTP)
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('OTP or password is incorrect')),
                      );
                    }
                  } catch (e) {
                    // Handle errors like no internet connection
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text('An error occurred, please try again')),
                    );
                  }
                },
                child: const Text(kNext),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
