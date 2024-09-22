import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kisanapp/constants/image_strings.dart';
import 'package:kisanapp/constants/sizes.dart';
import 'package:kisanapp/constants/text_strings.dart';
import 'package:kisanapp/widgets/forms/header&footer/form_footer_widget.dart';
import 'package:kisanapp/widgets/forms/header&footer/form_header_widget.dart';
import 'package:kisanapp/widgets/forms/header&footer/login_form_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(kDefaultSize),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FormHeaderWidget(
                  image: kSplashLogo,
                  title: kLoginTitle,
                  subTitle: kLoginSubTitle,
                  size: height * 0.2,
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
                const LoginForm(),
                FormFooterWidget(
                  btText: kSignInWithGoogle,
                  accText: kDontHaveAccount,
                  opText: kSignup,
                  onGoogleSignIn: () {}, // Add your Google Sign-In logic here
                  onAccountTextTap: () async {
                    await Get.toNamed(
                        '/signup'); // Replace with your actual route
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
