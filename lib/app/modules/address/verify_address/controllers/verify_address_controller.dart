import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:serveeasy_app/app/data/repositories/user_repository.dart';
import 'package:serveeasy_app/app/modules/address/verify_address/views/verify_address_view.dart';
import 'package:serveeasy_app/core/constants/configuration.dart';

class VerifyAddressController extends GetxController {
  Configuration config = Configuration();
  VerifyAddressViewParams? params;
  RxBool isLoading = false.obs;
  RxBool isResending = false.obs;
  TextEditingController otpController = TextEditingController();

  @override
  void onInit() {
    params = Get.arguments;
    startTimer();
    super.onInit();
  }

  Rxn<Timer>? timer = Rxn();

  // RxInt minutes = RxInt(1);

  RxInt start = RxInt(60);

  void startTimer() {
    // codeSentCount++;
    start.value = 30;
    // minutes.value = 1;
    const oneSec = Duration(seconds: 1);
    timer!.value = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (start.value == 0) {
          timer.cancel();
          // notifyListeners();
        } else {
          // if (start.value == 0) {
          //   minutes.value -= 1;
          //   start.value = 60;
          // }
          if (start.value > 0) {
            start.value--;
            // notifyListeners();
          }
        }
      },
    );
  }

  Future<void> onVerifyTap() async {
    if (otpController.text.isEmpty) return;
    isLoading.value = true;
    final bool response = await UserRepository()
        .verifyAddressOtp(params!.newAddressId, otpController.text);
    if (response) {
      Get.back(result: true);
    }
    isLoading.value = false;
  }

  Future<void> resendOtp() async {
    isResending.value = true;
    // if (await AuthRepository()
    //     .sendOtp((await UserManager().getUser())!.email!)) {
    startTimer();
    // }
    isResending.value = false;
  }
}
