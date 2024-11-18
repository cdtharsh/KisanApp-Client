import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widgets/fade_in_animation/animation_widget.dart';
import '../../controller/animation/fade_in_animation_controller.dart';
import '../../widgets/fade_in_animation/fade_in_animation_model.dart';
import '../../constants/colors.dart';
import '../../constants/image_strings.dart';
import '../../constants/text_strings.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FadeInAnimationController());
    controller.animationIn();
    controller.animationOut();

    var mediaQuery = MediaQuery.of(context);
    var brightness = mediaQuery.platformBrightness;
    final isDark = brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? kSecondaryColor : kWhiteColor,
      body: Stack(
        children: [
          KFadeInAnimation(
            durationInMs: 1200,
            animate: KAnimatePosition(
              bottomBefore: -100.h,
              bottomAfter: 0.h,
              leftBefore: 0.w,
              leftAfter: 0.w,
              topBefore: 0.h,
              topAfter: 0.h,
              rightAfter: 0.w,
              rightBefore: 0.w,
            ),
            child: Container(
              padding: EdgeInsets.all(10.w), // Responsive padding
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    kSplashLogo,
                    fit: BoxFit.contain,
                    height: 0.5.sh, // Responsive height (60% of screen height)
                    width: 1.sw,
                  ),
                  AutoSizeText(
                    kWelcomeTitle,
                    style: Theme.of(context).textTheme.displaySmall,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  AutoSizeText(
                    kWelcomeSubTitle,
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                  ),
                  SizedBox(
                    height: 0.1.sh,
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: 10.h), // Optional padding from the bottom
              child: Padding(
                padding: EdgeInsets.all(10.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: Theme.of(context).outlinedButtonTheme.style,
                        onPressed: () {
                          Get.toNamed('/login');
                        },
                        child: AutoSizeText(
                          kLogin.toUpperCase(),
                          maxLines: 1,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w), // Responsive spacing
                    Expanded(
                      child: ElevatedButton(
                        style: Theme.of(context).elevatedButtonTheme.style,
                        onPressed: () {
                          Get.toNamed('/signup');
                        },
                        child: AutoSizeText(
                          kSignup.toUpperCase(),
                          maxLines: 1,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                  color:
                                      isDark ? kSecondaryColor : kWhiteColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
