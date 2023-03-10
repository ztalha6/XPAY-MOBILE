import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:serveeasy_app/app/data/widgets/custom_text_form_field.dart';
import 'package:serveeasy_app/app/data/widgets/primary_button.dart';
import 'package:serveeasy_app/app/routes/app_pages.dart';
import 'package:serveeasy_app/core/constants/asset_constants.dart';

import 'package:sizer/sizer.dart';

import '../controllers/sign_in_controller.dart';

class SignInView extends GetView<SignInController> {
  const SignInView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<SignInController>(
      builder: (model) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            toolbarHeight: 2.h,
          ),
          body: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sign In',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Happy to see you again!',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      SizedBox(height: 5.h),
                      CustomTextFormField(
                        label: 'Email',
                        errorText: model.emailErrorText.value,
                        controller: model.emailController,
                        hintText: "Enter email address",
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                      ),
                      SizedBox(height: 2.h),
                      CustomTextFormField(
                        label: 'Password',
                        errorText: model.passwordErrorText.value,
                        controller: model.passwordController,
                        hintText: "Enter Password",
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        onDone: (s) => model.onSignInTap(),
                      ),
                      Row(
                        children: [
                          TextButton(
                            onPressed: () =>
                                Get.toNamed(Routes.FORGET_PASSSWORD),
                            child: Text(
                              'Forgot Password?',
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall!
                                  .copyWith(
                                    // fontSize: 11,
                                    color: model.configs.secondaryColor,
                                  ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      PrimaryButton(
                        isLoading: model.isLoading.value,
                        buttonColor:
                            model.configs.secondaryColor.withOpacity(0.8),
                        text: 'Sign In',
                        textStyle: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                        onTap: () => model.onSignInTap(),
                      ),
                      const SizedBox(height: 15),
                      PrimaryButton(
                        isLoading: model.isPerformingGuestSignIn.value,
                        buttonColor:
                            model.configs.primaryColor.withOpacity(0.8),
                        text: 'Continue as Guest',
                        textStyle: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                        onTap: () => model.onGuestButtonTap(),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('____' * 4),
                            SizedBox(width: 2.w),
                            Transform.translate(
                              offset: const Offset(0, 6),
                              child: Text(
                                'or',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .copyWith(fontSize: 16),
                              ),
                            ),
                            SizedBox(width: 2.w),
                            Text('____' * 4),
                          ],
                        ),
                      ),
                      PrimaryButton(
                        buttonColor: Colors.white,
                        isLoading: controller.isPerformingGoogleSignIn.value,
                        text: 'Countinue with Apple',
                        borderColor: Colors.black,
                        leadingWidget: const Icon(
                          Icons.apple,
                          size: 30,
                        ),
                        textStyle: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                        onTap: () => model.signInWithApple(),
                      ),
                      SizedBox(height: 2.h),
                      PrimaryButton(
                        buttonColor: Colors.white,
                        isLoading: controller.isPerformingGoogleSignIn.value,
                        text: 'Countinue with Goolge',
                        borderColor: const Color(0xFFD9D9D9),
                        leadingWidget: Image.asset(
                          googleLogo,
                          scale: 3,
                        ),
                        textStyle: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                              fontSize: 16,
                              color: const Color(0xFF757575),
                            ),
                        onTap: () => model.doGoogleSignIn(),
                      ),
                      SizedBox(height: 2.h),
                      PrimaryButton(
                        buttonColor: const Color(0xFF1877F2),
                        // isLoading: controller.isLoading.value,
                        text: 'Countinue with Facebook',
                        leadingWidget: Image.asset(
                          facebookLogo,
                          scale: 3,
                        ),
                        textStyle: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                        onTap: () => model.doFacebookSignIn(),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RichText(
                              text: TextSpan(
                                text: 'Not registered yet?',
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                                children: <TextSpan>[
                                  TextSpan(
                                    text: ' Sign up',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall!
                                        .copyWith(
                                          color: model.configs.secondaryColor,
                                        ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Get.toNamed(Routes.SIGN_UP);
                                      },
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
