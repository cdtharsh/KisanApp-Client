import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/constants/image_strings.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/constants/text_strings.dart';
import '../../widgets/layouts/form_footer_widget.dart';
import '../../widgets/layouts/form_header_widget.dart';
import 'signup_form_widget.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true, // Makes the app bar float with scrolling
            snap: true, // Makes it appear immediately when you scroll up
            leading:
                IconButton(onPressed: Get.back, icon: Icon(Icons.arrow_back)),
            title: Text('Sign Up'), // Title for AppBar
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
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
                        onAccountTextTap: () async {
                          Get.toNamed('/login'); // Navigate to login screen
                        },
                        onGoogleSignIn: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
