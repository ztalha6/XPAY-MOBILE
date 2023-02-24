import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:payment_card_validation/input_formatters.dart';
import 'package:payment_card_validation/payment_card.dart';
import 'package:serveeasy_app/app/data/widgets/custom_text_form_field.dart';
import 'package:serveeasy_app/app/data/widgets/primary_button.dart';

import '../controllers/payment_controller.dart';

class PaymentView extends GetView<PaymentController> {
  const PaymentView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(PaymentController());
    return GetX<PaymentController>(
      builder: (model) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Add a new Card',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            leading: IconButton(
              onPressed: () {
                Get.back(result: "");
              },
              icon: const Icon(Icons.close),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                CustomTextFormField(
                  label: 'Card Number',
                  errorText: model.cardNumberErrorText.value,
                  controller: model.cardNumberController,
                  hintText: "Card number here",
                  isMandatory: true,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(19),
                    CardNumberInputFormatter()
                  ],
                  // perfixIcon: CardUtils.getCardIcon(model.paymentCard.value.type),
                  onChanged: (value) {
                    model.getCardTypeFrmNumber();
                    model.paymentCard.value.number =
                        CardUtils.getCleanedNumber(value);
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextFormField(
                        label: 'MM / YY',
                        errorText: model.monthErrorText.value,
                        controller: model.monthController,
                        hintText: "MM / YY",
                        isMandatory: true,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(4),
                          CardMonthInputFormatter()
                        ],
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          final List<int> expiryDate =
                              CardUtils.getExpiryDate(value);
                          model.paymentCard.value.month = expiryDate[0];
                          model.paymentCard.value.year = expiryDate[1];
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: CustomTextFormField(
                        label: 'CVV',
                        errorText: model.cvvErrorText.value,
                        controller: model.cvvController,
                        hintText: "CVV",
                        isMandatory: true,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(4),
                        ],
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          model.paymentCard.value.cvv = int.parse(value);
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  label: 'Card Holder',
                  errorText: model.cardNameErrorText.value,
                  controller: model.cardNameController,
                  hintText: "Card holder name here",
                  isMandatory: true,
                  onChanged: (value) {
                    model.paymentCard.value.name = value;
                  },
                ),
                const SizedBox(height: 35),
                PrimaryButton(
                  text: 'Apply',
                  isLoading: model.isLoading.value,
                  textStyle: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                  onTap: () => model.saveCard(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
