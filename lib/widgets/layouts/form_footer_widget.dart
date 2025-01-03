import 'package:flutter/material.dart';
import '../../utils/constants/sizes.dart';

class FormFooterWidget extends StatelessWidget {
  const FormFooterWidget({
    super.key,
    required this.btText,
    required this.accText,
    required this.opText,
    required this.onGoogleSignIn,
    required this.onAccountTextTap,
  });

  final String btText, accText, opText;
  final VoidCallback onGoogleSignIn;
  final VoidCallback onAccountTextTap; // Changed from Future to VoidCallback

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("OR"),
        const SizedBox(height: kDefaultSize - 20),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: onGoogleSignIn,
            label: Text(btText),
          ),
        ),
        const SizedBox(height: kDefaultSize - 20),
        TextButton(
          onPressed: onAccountTextTap, // Now it's a VoidCallback
          child: Text.rich(
            TextSpan(
              text: accText,
              style: Theme.of(context).textTheme.bodyLarge,
              children: [
                TextSpan(
                  text: opText,
                  style: const TextStyle(color: Colors.blue),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
