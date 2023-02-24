import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:serveeasy_app/core/constants/asset_constants.dart';

import '../controllers/order_success_controller.dart';

class OrderSuccessView extends GetView<OrderSuccessController> {
  const OrderSuccessView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(OrderSuccessController());
    return GetX<OrderSuccessController>(
      builder: (model) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.close),
            ),
          ),
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  successIcon,
                  scale: 3,
                ),
                const SizedBox(height: 10),
                Text(
                  "Order Placed",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontSize: 20),
                ),
                const SizedBox(height: 10),
                Text(
                  "Your order #${model.lastOrderId} was placed with success.",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 10),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(),
                  ),
                  onPressed: () {
                    model.trackOrder();
                  },
                  child: Text(
                    'Track Order',
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
