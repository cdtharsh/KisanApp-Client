import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kisanapp/utils/constants/image_strings.dart';
import 'package:kisanapp/utils/constants/sizes.dart';
import 'package:kisanapp/utils/constants/text_strings.dart';
import 'package:kisanapp/widgets/layouts/form_footer_widget.dart';
import 'package:kisanapp/widgets/layouts/form_header_widget.dart';
import 'package:kisanapp/screens/login_screen/login_form_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
            title: Text('Login'), // Title for AppBar
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
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
                        onGoogleSignIn: () {}, // Add Google Sign-In logic here
                        onAccountTextTap: () async {
                          await Get.toNamed(
                              '/signup'); // Navigate to Signup screen
                        },
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
