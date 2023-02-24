import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:serveeasy_app/app/data/widgets/custom_phone_field.dart';
import 'package:serveeasy_app/app/data/widgets/custom_text_form_field.dart';
import 'package:serveeasy_app/app/data/widgets/primary_button.dart';
import 'package:serveeasy_app/app/routes/app_pages.dart';

import 'package:sizer/sizer.dart';

import '../controllers/sign_up_controller.dart';

class SignUpView extends GetView<SignUpController> {
  const SignUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<SignUpController>(
      builder: (model) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 2.h,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          ),
          body: ListView(
            padding: EdgeInsets.only(bottom: Get.height * 0.030),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sign Up',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Create your account, It takes less than a minutes. Enter your personal info.',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    SizedBox(height: 5.h),
                    CustomTextFormField(
                      isMandatory: true,
                      label: 'Fullname',
                      errorText: model.fullNameErrorText.value,
                      controller: model.fullnameController,
                      hintText: "Enter Full Name",
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(height: 2.h),
                    CustomTextFormField(
                      isMandatory: true,
                      label: 'Email',
                      errorText: model.emailErrorText.value,
                      controller: model.emailController,
                      hintText: "Enter email address",
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(height: 2.h),
                    CustomPhoneField(
                      onInputChanged: (number) {
                        model.phone.value = number;
                      },
                      controller: model.phoneController,
                      errorText: model.phoneErrorText.value,
                      label: 'Phone',
                      hintText: 'Enter Phone Number',
                    ),
                    SizedBox(height: 2.h),
                    CustomTextFormField(
                      isMandatory: true,
                      label: 'Password',
                      errorText: model.passwordErrorText.value,
                      controller: model.passwordController,
                      hintText: "Enter Password",
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      onDone: (s) => model.onSignInTap(),
                    ),
                    SizedBox(height: 5.h),
                    PrimaryButton(
                      isLoading: model.isLoading.value,
                      text: 'Sign Up',
                      textStyle:
                          Theme.of(context).textTheme.bodyLarge!.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                      onTap: () => model.onSignInTap(),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: 'Already have an account?',
                              style: Theme.of(context).textTheme.headlineMedium,
                              children: <TextSpan>[
                                TextSpan(
                                  text: ' Sign in',
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall!
                                      .copyWith(
                                        color: model.configs.secondaryColor,
                                      ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Get.offAllNamed(Routes.SIGN_IN);
                                    },
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: 'By continuing you agree to Our ',
                        style: Theme.of(context).textTheme.headlineMedium,
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Terms of Use ',
                            style:
                                Theme.of(context).textTheme.displaySmall!.copyWith(
                                      color: model.configs.secondaryColor,
                                    ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.offAllNamed(Routes.SIGN_IN);
                              },
                          ),
                          TextSpan(
                            text: 'and ',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          TextSpan(
                            text: 'Privacy Policy',
                            style:
                                Theme.of(context).textTheme.displaySmall!.copyWith(
                                      color: model.configs.secondaryColor,
                                    ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.offAllNamed(Routes.SIGN_IN);
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
      },
    );
  }
}
