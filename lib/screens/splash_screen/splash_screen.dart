import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kisanapp/utils/constants/image_strings.dart';
import 'controller/fade_in_animation_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize ScreenUtil to get screen dimensions
    ScreenUtil.init(context);

    //final sHeight = ScreenUtil().screenHeight;

    // Initialize the controller
    final controller = Get.put(FadeInAnimationController());
    controller.startSplashAnimation(); // Start navigation logic

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // First widget - Top Center
            // SizedBox(
            //   height: sHeight * 0.4, // Allocating 40% of the screen height
            //   child: Center(
            //     child: Column(
            //       mainAxisSize: MainAxisSize.min,
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       children: [
            //         AutoSizeText(
            //           kAppName,
            //           style: Theme.of(context).textTheme.displayLarge,
            //           textAlign: TextAlign.center,
            //           maxLines: 1,
            //         ),
            //         SizedBox(height: 8.h),
            //         AutoSizeText(
            //           kAppTagLine,
            //           style: Theme.of(context).textTheme.titleSmall!,
            //           textAlign: TextAlign.center,
            //           maxLines: 2,
            //         ),
            //         SizedBox(height: 8.h),
            //       ],
            //     ),
            //   ),
            // ),
            // // Second widget - Center of the screen
            Center(
              child: SizedBox(
                height: 0.8.sh, // Adjusted size for the image
                width: 0.8.sw, // Reduced width to fit within allocated space
                child: const Image(
                  image: AssetImage(kSplashLogo),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
