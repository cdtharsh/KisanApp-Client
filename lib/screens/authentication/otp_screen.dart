import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

import '../../constants/sizes.dart';
import '../../constants/text_strings.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
            const Text(
              "$kOtpMessage support@codingwitht.com",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20.0),
            Pinput(
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
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Add your OTP verification logic here
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
