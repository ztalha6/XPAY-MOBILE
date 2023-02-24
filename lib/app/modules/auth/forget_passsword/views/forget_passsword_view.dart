import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:serveeasy_app/app/data/widgets/custom_text_form_field.dart';
import 'package:serveeasy_app/app/data/widgets/primary_button.dart';
import 'package:sizer/sizer.dart';

import '../controllers/forget_passsword_controller.dart';

class ForgetPassswordView extends GetView<ForgetPassswordController> {
  const ForgetPassswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<ForgetPassswordController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Forgot Password',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.060),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                Wrap(
                  children: [
                    Text(
                      'Enter email address to receive a 4 digit code for verification',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
                CustomTextFormField(
                  label: 'Email',
                  errorText: controller.emailErrorText.value,
                  controller: controller.emailController,
                  hintText: "Enter email address",
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  onDone: (s) => controller.onRecoverNowTap(),
                ),
                SizedBox(
                  height: Get.height * 0.078,
                ),
                PrimaryButton(
                  onTap: () => controller.onRecoverNowTap(),
                  text: 'Submit',
                  isLoading: controller.isLoading.value,
                  textStyle: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
