import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil
import 'package:kisanapp/controller/animation/fade_in_animation_controller.dart';
import 'package:kisanapp/constants/colors.dart';
import 'package:kisanapp/constants/image_strings.dart';
import 'package:kisanapp/constants/text_strings.dart';

import '../../widgets/fade_in_animation/animation_widget.dart';
import '../../widgets/fade_in_animation/fade_in_animation_model.dart';

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
                topAfter: sHeight * 0.1,
                leftBefore: -sWidth,
                leftAfter: sWidth / 2,
              ),
              child: Align(
                alignment: Alignment.topCenter,
                child: FractionalTranslation(
                  translation: const Offset(-0.5, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 0.35.sh,
                        width: 0.8.sw,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
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
                            SizedBox(height: 8.h),
                            AutoSizeText(
                              kAppTagLine,
                              style: Theme.of(context).textTheme.titleSmall!,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                            ),
                            SizedBox(height: 8.h),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Second animation
            KFadeInAnimation(
              durationInMs: 2000,
              animate: KAnimatePosition(
                topBefore: sHeight,
                topAfter: sHeight / 2 - 0.5.sh / 2,
                leftBefore: sWidth,
                leftAfter: sWidth / 2 - 1.sw / 2,
              ),
              child: SizedBox(
                height: 0.5.sh,
                width: 1.sw,
                child: const Image(
                  image: AssetImage(kSplashLogo),
                  fit: BoxFit.contain,
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
                width: 0.1.sw,
                height: 0.1.sh,
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
