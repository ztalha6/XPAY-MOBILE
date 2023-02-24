import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:serveeasy_app/app/data/widgets/primary_button.dart';
import 'package:serveeasy_app/app/routes/app_pages.dart';
import 'package:serveeasy_app/core/constants/asset_constants.dart';

import 'package:sizer/sizer.dart';
import 'package:video_player/video_player.dart';

import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<OnboardingController>(
      builder: (model) {
        return Center(
          child: Stack(
            children: [
              AnimatedOpacity(
                opacity: model.visible.isTrue ? 1.0 : 0.0,
                duration: 1000.milliseconds,
                child: VideoPlayer(model.controller.value),
              ),
              Scaffold(
                backgroundColor: Colors.transparent,
                extendBodyBehindAppBar: true,
                appBar: AppBar(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  actions: [
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Skip',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Colors.white,
                            ),
                      ),
                    )
                  ],
                ),
                body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Image.asset(model.configs.logoWithName),

                      SizedBox(height: Get.height * 0.026),
                      Text(
                        'Discover food from your near by branches..',
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(color: Colors.white),
                      ),

                      SizedBox(height: Get.height * 0.051),
                      PrimaryButton(
                        buttonColor: Colors.white,
                        // isLoading: controller.isLoading.value,
                        text: 'Countinue with Goolge',
                        leadingWidget: Image.asset(
                          googleLogo,
                          scale: 3,
                        ),
                        textStyle:
                            Theme.of(context).textTheme.bodyLarge!.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: const Color(0xFF757575),
                                ),
                        // onTap: () => Get.offAllNamed(Routes.SIGN_UP),
                      ),
                      SizedBox(height: Get.height * 0.023),
                      PrimaryButton(
                        buttonColor: const Color(0xFF1877F2),
                        // isLoading: controller.isLoading.value,
                        text: 'Countinue with Facebook',
                        leadingWidget: Image.asset(
                          facebookLogo,
                          scale: 3,
                        ),
                        textStyle:
                            Theme.of(context).textTheme.bodyLarge!.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                        // onTap: () => Get.offAllNamed(Routes.SIGN_UP),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 22),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '_____' * 4,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(color: Colors.white),
                            ),
                            SizedBox(width: 2.w),
                            Transform.translate(
                              offset: const Offset(0, 6),
                              child: Text(
                                'or',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                            SizedBox(width: 2.w),
                            Text(
                              '_____' * 4,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      PrimaryButton(
                        // isLoading: controller.isLoading.value,
                        text: 'Sign In with Email',
                        fontSize: Get.height * 0.018,
                        textStyle:
                            Theme.of(context).textTheme.bodyLarge!.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                        onTap: () => Get.offAllNamed(Routes.SIGN_IN),
                      ),
                      // SizedBox(height: Get.height * 0.062),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 25),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: 'By continuing you agree to Our ',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: Colors.white),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Terms of Use ',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Get.offAllNamed(Routes.SIGN_IN);
                                  },
                              ),
                              TextSpan(
                                text: 'and ',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                              ),
                              TextSpan(
                                text: 'Privacy Policy',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Get.offAllNamed(Routes.SIGN_IN);
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
