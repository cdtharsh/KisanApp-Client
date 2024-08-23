import 'package:flutter/material.dart';

import '../../constants/image_strings.dart';
import '../../constants/sizes.dart';
import '../../constants/text_strings.dart';
import '../../widgets/forms/header&footer/form_footer_widget.dart';
import '../../widgets/forms/header&footer/form_header_widget.dart';
import '../../widgets/forms/signup_form_widget.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(kDefaultSize),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              FormHeaderWidget(
                image: kSplashLogo,
                title: kSignupTitle,
                subTitle: kSignupSubTitle,
                size: height * 0.2,
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
              const SignupFormWidget(),
              FormFooterWidget(
                btText: kSignUpWithGoogle,
                accText: kAlreadyHaveAnAccount,
                opText: kLogin,
                onAccountTextTap: () {
                  //Get.toNamed(AppRoutes.login); // Navigate to login screen
                },
                onGoogleSignIn: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
