import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:serveeasy_app/core/constants/configuration.dart';

class PromoController extends GetxController {
  Configuration configuration = Configuration();
  RxnString promoErrorText = RxnString();
  TextEditingController promoController = TextEditingController();
  RxBool isValid = false.obs;
  RxList<dynamic> promos = [].obs;

  @override
  void onInit() {
    promoController.addListener(setValid);
    super.onInit();
  }

  void setCode() {
    promoErrorText(null);
    if (promoController.text.isEmpty) {
      promoErrorText("Field cannot be empty");
      return;
    }
    Get.back(result: promoController.text);
  }

  void setValid() {
    isValid(promoController.text.isNotEmpty);
  }
}
