import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kisanapp/services/pass_api_service.dart';
import 'package:kisanapp/utils/notification/custome_snackbar.dart';
import 'package:pinput/pinput.dart';
import 'package:get/get.dart';

import '../../constants/sizes.dart';
import '../../constants/text_strings.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key, required String email, required String password});

  @override
  OTPScreenState createState() => OTPScreenState();
}

class OTPScreenState extends State<OTPScreen> {
  final TextEditingController _otpController = TextEditingController();
  final PassApiService _apiservice = PassApiService();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    // Get the parameters from the route
    final String email = Get.parameters['email'] ?? '';
    final String password = Get.parameters['password'] ?? '';

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
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            padding: const EdgeInsets.all(kDefaultSize),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  kOtpTitle,
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                Text(
                  kOtpSubTitle.toUpperCase(),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 40.0),
                Text(
                  "$kOtpMessage $email",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 20.0),
                Pinput(
                  controller: _otpController,
                  length: 6,
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: focusedPinTheme,
                  submittedPinTheme: submittedPinTheme,
                  showCursor: true,
                ),
                const SizedBox(height: 20.0),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading
                        ? null
                        : () async {
                            final String otp = _otpController.text;

                            if (otp.isEmpty || password.isEmpty) {
                              CustomSnackbar.show(
                                title: kError,
                                message: 'Please fill complete OTP',
                                backgroundColor: Colors.red,
                                iconData: Icons.error,
                              );
                              return;
                            }

                            setState(() => _isLoading = true);

                            try {
                              final response =
                                  await _apiservice.resetPasswithEmail(
                                email: email,
                                otp: otp,
                                newPassword: password,
                              );

                              if (response['msg'] ==
                                  'Password has been reset successfully.') {
                                CustomSnackbar.show(
                                  title: kSuccess,
                                  message: response['msg'],
                                  iconData: Icons.verified,
                                );
                                Get.toNamed('/login');
                              } else {
                                CustomSnackbar.show(
                                  title: kError,
                                  message: 'Please provide correct OTP',
                                  backgroundColor: Colors.red,
                                  iconData: Icons.error,
                                );
                              }
                            } catch (e) {
                              CustomSnackbar.show(
                                title: kError,
                                error: e,
                                backgroundColor: Colors.red,
                                iconData: Icons.error,
                              );
                            } finally {
                              setState(() => _isLoading = false);
                            }
                          },
                    child: _isLoading
                        ? const CircularProgressIndicator()
                        : const Text(kNext),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
