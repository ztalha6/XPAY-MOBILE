import 'dart:async';

import 'package:get/get.dart';
import 'package:serveeasy_app/core/constants/configuration.dart';
import 'package:video_player/video_player.dart';

class OnboardingController extends GetxController {
  Configuration configs = Configuration();
  Rx<VideoPlayerController> controller = Rx<VideoPlayerController>(
    VideoPlayerController.network(
      "https://assets.mixkit.co/videos/preview/mixkit-abstract-video-of-unfocused-lights-flickering-in-the-dark-34380-large.mp4",
    ),
  );
  RxBool visible = false.obs;
  @override
  void onInit() {
    controller.value.initialize().then((_) {
      controller.value.setLooping(true);
      Timer(100.milliseconds, () {
        controller.value.play();
        visible.value = true;
      });
    });
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
    controller.value.dispose();
  }
}
