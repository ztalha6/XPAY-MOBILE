import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payment_card_validation/my_strings.dart';
import 'package:payment_card_validation/payment_card.dart';
import 'package:serveeasy_app/app/data/repositories/order_repository.dart';
import 'package:serveeasy_app/app/modules/checkout/controllers/checkout_controller.dart';
import 'package:serveeasy_app/core/constants/configuration.dart';

class PaymentController extends GetxController {
  RxBool isLoading = false.obs;
  Configuration configuration = Configuration();

  RxnString cardNameErrorText = RxnString();
  RxnString monthErrorText = RxnString();
  RxnString cvvErrorText = RxnString();
  RxnString cardNumberErrorText = RxnString();

  TextEditingController cardNameController = TextEditingController();
  TextEditingController monthController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  TextEditingController cardNumberController = TextEditingController();

  Rx<PaymentCard> paymentCard = Rx<PaymentCard>(PaymentCard());

  @override
  void onInit() {
    paymentCard.value.type = CardType.Others;
    cardNameController.addListener(getCardTypeFrmNumber);
    super.onInit();
  }

  void getCardTypeFrmNumber() {
    final String input = CardUtils.getCleanedNumber(cardNameController.text);
    final CardType cardType = CardUtils.getCardTypeFrmNumber(input);
    paymentCard.value.type = cardType;
  }

  Future<void> saveCard() async {
    cardNumberErrorText(null);
    monthErrorText(null);
    cvvErrorText(null);
    cardNameErrorText(null);
    final bool isValid = validateFields();
    if (!isValid) return;
    isLoading(true);
    if (await OrderRepository().getCardToken(paymentCard.value)) {
      final CheckoutController checkourController =
          Get.find<CheckoutController>();
      checkourController.paymentCard(paymentCard.value);
      checkourController.selectedPayMethod(1);
      checkourController.cartSummary();
      Get.back();
    }
    isLoading(false);
  }

  bool validateFields() {
    cardNumberErrorText(CardUtils.validateCardNum(cardNumberController.text));
    monthErrorText(CardUtils.validateDate(monthController.text));
    cvvErrorText(CardUtils.validateCVV(cvvController.text));
    cardNameErrorText(
      cardNameController.text.isEmpty ? Strings.fieldReq : null,
    );
    return cardNumberErrorText.value == null &&
        monthErrorText.value == null &&
        cvvErrorText.value == null &&
        cardNameErrorText.value == null;
  }
}
