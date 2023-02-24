import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:serveeasy_app/app/modules/checkout/controllers/checkout_controller.dart';
import 'package:serveeasy_app/app/routes/app_pages.dart';
import 'package:serveeasy_app/core/constants/asset_constants.dart';

class PaymentMethodWidget extends StatelessWidget {
  const PaymentMethodWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<CheckoutController>(
      builder: (model) {
        return Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: ListTile(
            onTap: () {
              Get.toNamed(Routes.PAYMENT);
            },
            title: Text(
              model.paymentCard.value.number!.isEmpty
                  ? "Payment Method"
                  : model.paymentCard.value.name!.toUpperCase(),
              style:
                  Theme.of(context).textTheme.displayLarge!.copyWith(fontSize: 14),
            ),
            subtitle: Text(
              model.paymentCard.value.number!.isEmpty
                  ? "Add your payment method"
                  : model.paymentCard.value.number!,
              style:
                  Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: 12),
            ),
            leading: Image.asset(
              cardIcon,
              scale: 1.8,
            ),
            trailing: model.paymentCard.value.number!.isEmpty
                ? const Icon(Icons.arrow_forward_ios_rounded)
                : TextButton(
                    onPressed: () {
                      model.removeCard();
                    },
                    child: Text(
                      "Remove",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
          ),
        );
      },
    );
  }
}
