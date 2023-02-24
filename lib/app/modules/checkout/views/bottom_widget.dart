import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:serveeasy_app/app/data/widgets/primary_button.dart';
import 'package:serveeasy_app/app/modules/checkout/controllers/checkout_controller.dart';
import 'package:sizer/sizer.dart';

class BottomWidget extends StatelessWidget {
  const BottomWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<CheckoutController>(
      builder: (model) {
        return Column(
          children: [
            Container(
              width: Get.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(15.0),
                  topLeft: Radius.circular(15.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 10,
                    blurRadius: 20,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 4,
                      child: SizedBox(
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Total (VAT incl.) ${model.isLoading.value}',
                                  style: Theme.of(context).textTheme.headlineMedium,
                                ),
                                Text(
                                  "\$ ${model.summary.value.netAmount!.toStringAsFixed(2)}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayLarge!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: SizedBox(
                        height: 12.h,
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: Get.height * 0.038,
                            bottom: Get.height * 0.028,
                            left: Get.width * 0.180,
                            right: Get.width * 0.040,
                          ),
                          child: PrimaryButton(
                            text: 'Place Order',
                            isLoading: model.isPlacingOrder.value,
                            textStyle:
                                Theme.of(context).textTheme.headlineMedium!.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: model.configs.secondaryColor,
                                    ),
                            onTap: () {
                              model.createOrder();
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
