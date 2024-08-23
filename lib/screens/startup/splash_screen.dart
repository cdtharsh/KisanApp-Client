import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../../widgets/fade_in_animation/animation_widget.dart';
import '../../controller/authentication/fade_in_animation_controller.dart';
import '../../widgets/fade_in_animation/fade_in_animation_model.dart';
import '../../constants/colors.dart';
import '../../constants/image_strings.dart';
import '../../constants/text_strings.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize ScreenUtil to get screen dimensions
    ScreenUtil.init(context);

    final sWidth = ScreenUtil().screenWidth;
    final sHeight = ScreenUtil().screenHeight;

    final controller = Get.put(FadeInAnimationController());
    controller.startSplashAnimation();

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // First animation
            KFadeInAnimation(
              durationInMs: 2000,
              animate: KAnimatePosition(
                topBefore: sHeight,
                topAfter: sHeight *
                    0.1, // Align vertically at 10% of the screen height
                leftBefore: -sWidth,
                leftAfter: sWidth / 2, // Align horizontally without offset
              ),
              child: Align(
                alignment: Alignment.topCenter,
                child: FractionalTranslation(
                  translation: const Offset(-0.5,
                      0), // Shift left by 50% of its width to center the content
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 0.35.sh, // Responsive height
                        width: 0.8.sw, // Responsive width
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              25), // Adjust the radius as needed
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AutoSizeText(
                              kAppName,
                              style: Theme.of(context).textTheme.displayLarge,
                              textAlign: TextAlign.center,
                              maxLines: 1,
                            ),
                            SizedBox(
                                height:
                                    8.h), // Vertical spacing between the texts
                            AutoSizeText(
                              kAppTagLine,
                              style: Theme.of(context).textTheme.titleSmall!,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // SizedBox between the first and second animation
            // Second animationa
            KFadeInAnimation(
              durationInMs: 2000,
              animate: KAnimatePosition(
                topBefore: sHeight,
                topAfter: sHeight / 2 -
                    0.5.sh / 2, // Align vertically based on specified height
                leftBefore: sWidth,
                leftAfter: sWidth / 2 - 1.sw / 2, // Align center horizontally
              ),
              child: SizedBox(
                height: 0.5.sh, // Responsive height
                width: 1.sw, // Responsive width
                child: const Image(
                  image: AssetImage(kSplashLogo),
                  fit: BoxFit.contain, // Ensure image scales properly
                ),
              ),
            ),
            // Third animation
            KFadeInAnimation(
              durationInMs: 2000,
              animate: KAnimatePosition(
                bottomBefore: -sHeight * 0.1,
                bottomAfter: sHeight * 0.1,
                rightBefore: -sWidth,
                rightAfter: sWidth * 0.1,
              ),
              child: Container(
                width: 0.1.sw, // Responsive width
                height: 0.1.sh, // Responsive height to maintain circular shape
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: kPrimaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
