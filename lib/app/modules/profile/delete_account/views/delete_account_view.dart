import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:serveeasy_app/app/data/widgets/custom_text_form_field.dart';
import 'package:serveeasy_app/app/data/widgets/primary_button.dart';
import 'package:sizer/sizer.dart';

import '../controllers/delete_account_controller.dart';

class DeleteAccountView extends GetView<DeleteAccountController> {
  const DeleteAccountView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetX<DeleteAccountController>(
      builder: (model) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Delete Account',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            backgroundColor: Colors.white,
          ),
          body: Container(
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.060),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                  Wrap(
                    children: [
                      Text(
                        'You must enter your password to delete an account.',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  CustomTextFormField(
                    label: 'Password',
                    errorText: controller.passwordErrorText.value,
                    controller: controller.passwordController,
                    hintText: "Enter Password",
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.done,
                    onDone: (s) => controller.onDeleteTap(),
                  ),
                  SizedBox(
                    height: Get.height * 0.078,
                  ),
                  PrimaryButton(
                    onTap: () => controller.onDeleteTap(),
                    text: 'Delete Account',
                    isLoading: controller.isLoading.value,
                    textStyle: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
