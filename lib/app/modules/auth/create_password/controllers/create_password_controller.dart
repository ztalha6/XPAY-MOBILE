import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:serveeasy_app/app/data/repositories/auth_repository.dart';
import 'package:serveeasy_app/app/data/services/validator_service.dart';
import 'package:serveeasy_app/app/modules/auth/create_password/views/create_password_view.dart';

class CreatePasswordController extends GetxController {
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  RxnString oldPasswordErrorText = RxnString();
  RxnString passwordErrorText = RxnString();
  RxnString confirmPasswordErrorText = RxnString();
  RxBool isLoading = false.obs;
  CreatePasswordViewParams params = CreatePasswordViewParams();
  Validator validator = Validator();

  @override
  void onInit() {
    params = Get.arguments ?? CreatePasswordViewParams();
    super.onInit();
  }

  Future<void> onUpdatePasswordTap() async {
    final bool isValid = checkErrors();
    if (!isValid) return;
    isLoading.value = true;
    if (await AuthRepository().resetPassword(
      passwordController.text,
      confirmPasswordController.text,
      Get.arguments,
    )) {
      Get.back();
    }
    isLoading.value = false;
  }

  bool checkErrors() {
    oldPasswordErrorText.value = null;
    passwordErrorText.value = null;
    confirmPasswordErrorText.value = null;
    final List<String?> errors = validator.validatePasswords(
      passwordController.text,
      confirmPasswordController.text,
      withOldPassword: !params.isResettingPassword,
      oldPassword: oldPasswordController.text,
    );
    if (!params.isResettingPassword) {
      oldPasswordErrorText.value = errors[0];
      passwordErrorText.value = errors[1];
      confirmPasswordErrorText.value = errors[2];
    } else {
      passwordErrorText.value = errors[0];
      confirmPasswordErrorText.value = errors[1];
    }
    return passwordErrorText.value == null &&
        confirmPasswordErrorText.value == null &&
        (!params.isResettingPassword && oldPasswordErrorText.value == null);
  }
}
