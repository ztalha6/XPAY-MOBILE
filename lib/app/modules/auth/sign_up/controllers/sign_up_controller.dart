import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:serveeasy_app/app/data/repositories/auth_repository.dart';
import 'package:serveeasy_app/app/data/services/validator_service.dart';
import 'package:serveeasy_app/app/routes/app_pages.dart';
import 'package:serveeasy_app/core/constants/configuration.dart';
import 'package:serveeasy_app/core/env/env.dart';
import 'package:serveeasy_app/core/utils/utils.dart';

class SignUpController extends GetxController {
  Configuration configs = Configuration();
  Validator validator = Validator();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController fullnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  Rxn<PhoneNumber> phone = Rxn<PhoneNumber>();

  RxnString emailErrorText = RxnString();
  RxnString passwordErrorText = RxnString();
  RxnString fullNameErrorText = RxnString();
  RxnString phoneErrorText = RxnString();

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    if (Env.currentEnv.prefillForms) {
      emailController.text = 'talha.siddique@tekrevol.com';
      passwordController.text = '12345678';
      fullnameController.text = 'Muhammad Talha Siddique';
    }
    super.onInit();
  }

  Future<void> onSignInTap() async {
    Utils().clearKeyboardFocus();
    final bool isValid = checkForError();
    if (!isValid) return;
    isLoading.value = true;
    if (await AuthRepository().signUp(
      fullnameController.text,
      "${phone.value!.dialCode}${phoneController.text}",
      emailController.text,
      passwordController.text,
    )) {
      Get.toNamed(
        Routes.VERIFY_OTP,
        arguments: [true, false, emailController.text],
      );
      clearFields();
    }
    isLoading.value = false;
  }

  bool checkForError() {
    emailErrorText.value = null;
    passwordErrorText.value = null;
    fullNameErrorText.value = null;
    emailErrorText.value = validator.validateEmail(emailController.text);
    passwordErrorText.value =
        validator.validatePassword(passwordController.text);
    fullNameErrorText.value =
        validator.validateFullname(fullnameController.text);
    phoneErrorText.value = validator.validatePhoneNumber(phoneController.text);

    return emailErrorText.value == null &&
        passwordErrorText.value == null &&
        fullNameErrorText.value == null &&
        phoneErrorText.value == null;
  }

  void clearFields() {
    emailController.text = '';
    fullnameController.text = '';
    phoneController.text = '';
    passwordController.text = '';
  }

  doGuestLogin() {}
}
