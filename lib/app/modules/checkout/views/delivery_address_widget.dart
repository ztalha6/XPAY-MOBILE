import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:serveeasy_app/app/data/widgets/custom_text_form_field.dart';
import 'package:serveeasy_app/app/data/widgets/loading_widget.dart';
import 'package:serveeasy_app/app/modules/checkout/controllers/checkout_controller.dart';
import 'package:serveeasy_app/core/constants/asset_constants.dart';

class DeliveryAddressWidget extends StatelessWidget {
  const DeliveryAddressWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<CheckoutController>(
      builder: (model) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(15.0),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Delivery Address",
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge!
                      .copyWith(fontSize: 16),
                ),
                const SizedBox(height: 10),
                if (model.isUpadtingAddress.isTrue)
                  const LoadingWidget()
                else
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            locationImage,
                            scale: 2.3,
                          ),
                          const SizedBox(width: 20),
                          SizedBox(
                            width: Get.width * 0.45,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  model.addressDetails.value!.address!,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style:
                                      Theme.of(context).textTheme.displaySmall,
                                ),
                                Text(
                                  model.addressDetails.value!.landmark!,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {
                          model.updateAddress();
                        },
                        icon: Image.asset(
                          editIcon,
                          scale: 3,
                        ),
                      )
                    ],
                  ),
                const SizedBox(height: 20),
                Text(
                  "Add Comments",
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Give us additional information about your order",
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        fontSize: 14,
                        color: const Color(
                          0xFF707581,
                        ),
                      ),
                ),
                CustomTextFormField(
                  // controller: model.commentsController,
                  hintText: "Your comments here",
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
