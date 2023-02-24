import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:serveeasy_app/app/data/widgets/custom_text_form_field.dart';
import 'package:serveeasy_app/app/data/widgets/primary_button.dart';
import 'package:sizer/sizer.dart';
import '../controllers/create_password_controller.dart';

class CreatePasswordViewParams {
  final bool isResettingPassword;

  CreatePasswordViewParams({this.isResettingPassword = true});
}

class CreatePasswordView extends GetView<CreatePasswordController> {
  const CreatePasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetX<CreatePasswordController>(
      builder: (model) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Create new password',
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
                      'Your new password must be different from the previously used passwords',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ],
                ),
                SizedBox(
                  height: 4.h,
                ),
                Visibility(
                  visible: !model.params.isResettingPassword,
                  child: CustomTextFormField(
                    label: 'Old Password',
                    errorText: model.oldPasswordErrorText.value,
                    controller: model.oldPasswordController,
                    hintText: "Enter old Password",
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.next,
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                CustomTextFormField(
                  label: 'Password',
                  errorText: model.passwordErrorText.value,
                  controller: model.passwordController,
                  hintText: "Enter Password",
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(
                  height: 2.h,
                ),
                CustomTextFormField(
                  label: 'Confirm Password',
                  errorText: model.confirmPasswordErrorText.value,
                  controller: model.confirmPasswordController,
                  hintText: "Enter Password",
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                ),
                SizedBox(
                  height: Get.height * 0.078,
                ),
                PrimaryButton(
                  onTap: () => model.onUpdatePasswordTap(),
                  text: 'Update',
                  isLoading: model.isLoading.value,
                  textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
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
