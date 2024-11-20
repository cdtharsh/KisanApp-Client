import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import '../../constants/sizes.dart';
import '../../constants/text_strings.dart';

class MailVerificationScreen extends StatelessWidget {
  final String email;

  const MailVerificationScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              top: kDefaultSize * 5,
              left: kDefaultSize,
              right: kDefaultSize,
              bottom: kDefaultSize * 2,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  LineAwesome.envelope_open,
                  size: 100,
                ),
                const SizedBox(height: kDefaultSize * 2),
                Text(
                  kEmailVerificationTitle.tr,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: kDefaultSize),
                Text(
                  kEmailVerificationSubTitle.tr,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: kDefaultSize * 2),
                SizedBox(
                  width: 200,
                  child: OutlinedButton(
                    onPressed: () {
                      // Implement manual check for email verification status here
                    },
                    child: Text(kContinue.tr),
                  ),
                ),
                const SizedBox(height: kDefaultSize * 2),
                TextButton(
                  onPressed: () {
                    // Implement logic to resend verification email here
                  },
                  child: Text(kResendEmail.tr),
                ),
                TextButton(
                  onPressed: () => Get.back(),
                  child: const Text('Back'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
