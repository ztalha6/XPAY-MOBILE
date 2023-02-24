import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:serveeasy_app/app/data/models/user_model.dart';
import 'package:serveeasy_app/app/data/services/user_manager.dart';
import 'package:serveeasy_app/app/modules/auth/create_password/views/create_password_view.dart';
import 'package:serveeasy_app/app/routes/app_pages.dart';
import 'package:serveeasy_app/core/constants/configuration.dart';

class ProfileMenuController extends GetxController {
  Configuration configuration = Configuration();
  RxBool isLoading = false.obs;
  RxString userName = "S".obs;
  Rxn<User> user = Rxn<User>();

  String get getFirstLetter => userName.value.characters.first;

  @override
  Future<void> onInit() async {
    isLoading(true);
    user.value = await UserManager().getUser();
    userName.value = user.value!.fullName ?? "S";
    isLoading(false);
    super.onInit();
  }

  void gotoDeleteAccount() {
    Get.toNamed(Routes.DELETE_ACCOUNT);
  }

  void gotoChangePassword() {
    Get.toNamed(
      Routes.CREATE_PASSWORD,
      arguments: CreatePasswordViewParams(isResettingPassword: false),
    );
  }

  void gotoPayment() {}

  void gotoAddresses() {
    Get.toNamed(Routes.ADDRESS_LIST);
  }

  void gotoEditProfile() {
    Get.toNamed(Routes.EDIT_PROFILE);
  }
}
