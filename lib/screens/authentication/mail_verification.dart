import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import '../../constants/sizes.dart';
import '../../constants/text_strings.dart';
import '../../controller/authentication/mail_verification_controller.dart';

class MailVerificationScreen extends StatelessWidget {
  final String username;
  final String password;

  const MailVerificationScreen(
      {super.key, required this.username, required this.password});

  @override
  Widget build(BuildContext context) {
    // Initialize the controller
    final MailVerificationController controller = Get.put(
        MailVerificationController(username: username, password: password));

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
                Obx(() {
                  // Update UI based on email verification status
                  if (controller.isLoading.value) {
                    return const CircularProgressIndicator();
                  }

                  if (controller.isEmailVerified.value) {
                    return Text(
                      'Your email is verified. You can continue.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium,
                    );
                  } else {
                    return Text(
                      kEmailVerificationSubTitle.tr,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium,
                    );
                  }
                }),
                const SizedBox(height: kDefaultSize * 2),
                SizedBox(
                  width: 200,
                  child: OutlinedButton(
                    onPressed: controller.checkVerificationManually,
                    child: Text(kContinue.tr),
                  ),
                ),
                const SizedBox(height: kDefaultSize * 2),
                TextButton(
                  onPressed: controller.resendVerificationEmail,
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
