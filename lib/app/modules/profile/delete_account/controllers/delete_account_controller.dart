import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeleteAccountController extends GetxController {
  TextEditingController passwordController = TextEditingController();
  RxnString passwordErrorText = RxnString();

  RxBool isLoading = false.obs;

  void onDeleteTap() {
    passwordErrorText.value = null;
    if (passwordController.text.isEmpty) {
      passwordErrorText.value = 'Password cannot be empty';
      return;
    }
  }
}
