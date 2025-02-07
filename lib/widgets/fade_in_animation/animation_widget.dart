import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/animation/fade_in_animation_controller.dart';
import '../../models/animation/fade_in_animation_model.dart';

class KFadeInAnimation extends StatelessWidget {
  KFadeInAnimation({
    super.key,
    required this.durationInMs,
    required this.child,
    this.animate,
  });
  final controller = Get.put(FadeInAnimationController());
  final int durationInMs;
  final KAnimatePosition? animate;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AnimatedPositioned(
        duration: Duration(milliseconds: durationInMs),
        top: controller.animate.value ? animate!.topAfter : animate!.topBefore,
        left:
            controller.animate.value ? animate!.leftAfter : animate!.leftBefore,
        bottom: controller.animate.value
            ? animate!.bottomAfter
            : animate!.bottomBefore,
        right: controller.animate.value
            ? animate!.rightAfter
            : animate!.rightBefore,
        child: AnimatedOpacity(
          duration: Duration(milliseconds: durationInMs),
          opacity: controller.animate.value ? 1 : 0,
          child: child,
        ),
      ),
    );
  }
}
