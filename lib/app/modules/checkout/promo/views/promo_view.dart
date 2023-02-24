import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:serveeasy_app/app/data/widgets/custom_text_form_field.dart';
import 'package:serveeasy_app/app/data/widgets/primary_button.dart';
import 'package:serveeasy_app/app/modules/checkout/promo/views/coupon_widget.dart';
import 'package:serveeasy_app/core/constants/asset_constants.dart';

import '../controllers/promo_controller.dart';

class PromoView extends GetView<PromoController> {
  const PromoView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetX<PromoController>(
      builder: (model) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Coupons & Vouchers',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            leading: IconButton(
              onPressed: () {
                Get.back(result: "");
              },
              icon: const Icon(Icons.close),
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomTextFormField(
                        label: 'Voucher',
                        errorText: model.promoErrorText.value,
                        controller: model.promoController,
                        hintText: "Apply your voucher here",
                        onDone: (s) => model.setCode(),
                      ),
                      const SizedBox(height: 15),
                      PrimaryButton(
                        text: 'Apply',
                        isDisabled: model.isValid.isFalse,
                        textStyle:
                            Theme.of(context).textTheme.headlineMedium!.copyWith(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                        onTap: () => model.setCode(),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              if (model.promos.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(
                    "Available Vouchers",
                    style: Theme.of(context)
                        .textTheme
                        .displayLarge!
                        .copyWith(fontSize: 14),
                  ),
                ),
              if (model.promos.isEmpty)
                Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 40),
                      Image.asset(
                        noDiscountImage,
                        scale: 3,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "No coupons Available!",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(color: Colors.black),
                      ),
                    ],
                  ),
                )
              else
                Expanded(
                  child: ListView.builder(
                    itemCount: 10,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return CouponWidget(
                        secondaryColor: model.configuration.secondaryColor,
                      );
                    },
                  ),
                )
            ],
          ),
        );
      },
    );
  }
}
