import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:serveeasy_app/app/data/widgets/loading_widget.dart';
import 'package:serveeasy_app/app/modules/checkout/views/bottom_widget.dart';
import 'package:serveeasy_app/app/modules/checkout/views/select_coupon_widget.dart';
import 'package:serveeasy_app/app/modules/checkout/views/delivery_address_widget.dart';
import 'package:serveeasy_app/app/modules/checkout/views/order_summary_wiget.dart';
import 'package:serveeasy_app/app/modules/checkout/views/payment_method_widget.dart';
import 'package:serveeasy_app/app/modules/checkout/views/tip_section_widget.dart';
import 'package:sizer/sizer.dart';

import '../controllers/checkout_controller.dart';

class CheckoutView extends GetView<CheckoutController> {
  const CheckoutView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(CheckoutController());
    return GetX<CheckoutController>(
      builder: (model) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Checkout',
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ),
          body: model.isLoading.isTrue
              ? const Center(
                  child: LoadingWidget(),
                )
              : Stack(
                  children: [
                    ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              const DeliveryAddressWidget(),
                              const SizedBox(height: 10),
                              const SelectCouponWidget(),
                              const SizedBox(height: 10),
                              const PaymentMethodWidget(),
                              const SizedBox(height: 10),
                              const TipSection(),
                              const SizedBox(height: 10),
                              if (model.isSyncing.isTrue)
                                const Center(
                                  child: LoadingWidget(),
                                )
                              else
                                const OrderSummaryWidget(),
                              const SizedBox(height: 90),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      bottom: 0.h,
                      child: const BottomWidget(),
                    ),
                    if (model.isSyncing.isTrue)
                      LinearProgressIndicator(
                        color: model.configs.secondaryColor,
                        backgroundColor:
                            model.configs.secondaryColor.withOpacity(0.5),
                      ),
                  ],
                ),
        );
      },
    );
  }
}
