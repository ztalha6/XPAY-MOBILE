import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:serveeasy_app/app/data/models/user_model.dart';
import 'package:serveeasy_app/app/data/repositories/auth_repository.dart';
import 'package:serveeasy_app/app/data/services/user_manager.dart';
import 'package:serveeasy_app/app/data/services/validator_service.dart';
import 'package:serveeasy_app/app/routes/app_pages.dart';

class ForgetPassswordController extends GetxController {
  TextEditingController emailController = TextEditingController();
  RxnString emailErrorText = RxnString();
  RxBool isLoading = false.obs;

  Future<void> onRecoverNowTap() async {
    final bool isValid = checkForValidation();
    if (!isValid) return;
    isLoading.value = true;
    if (await AuthRepository().sendOtp(emailController.text)) {
      await UserManager().saveUser(User(email: emailController.text));
      Get.offAndToNamed(
        Routes.VERIFY_OTP,
        arguments: [false, false, emailController.text],
      );
    }
    isLoading.value = false;
  }

  bool checkForValidation() {
    emailErrorText.value = Validator().validateEmail(emailController.text);
    return emailErrorText.value == null;
  }
}
