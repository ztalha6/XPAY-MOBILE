import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:serveeasy_app/app/modules/order/order_detail/controllers/order_detail_controller.dart';

class OrderDeatilWidget extends StatelessWidget {
  OrderDeatilWidget({
    Key? key,
  }) : super(key: key);

  OrderDetailController model = Get.find<OrderDetailController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Order Details",
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                const SizedBox(height: 10),
                // for (int i = 0; i < model.cartItems.length; i++)
                for (int i = 0;
                    i < model.orderDetail.value!.orderItems!.length;
                    i++)
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${model.orderDetail.value!.orderItems![i].product!.name} (x${model.orderDetail.value!.orderItems![i].purchasedQty})",
                            // "Name",
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          Text(
                            "\$ ${model.orderDetail.value!.orderItems![i].unitPrice}",
                            // "price",
                            style:
                                Theme.of(context).textTheme.headlineMedium!.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                Divider(color: Colors.grey.shade200),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Sub Total:",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Text(
                      "\$ ${model.orderDetail.value!.grossAmount.toString()}",
                      // "\$ 123",

                      style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Discount:",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Text(
                      "\$ ${model.orderDetail.value!.totalDiscount ?? 0.0}",
                      // "\$ 123",

                      style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Tip:",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Text(
                      "\$ ${model.orderDetail.value!.tip == null ? 0.0 : model.orderDetail.value!.tip!.toStringAsFixed(2)}",
                      // "\$ 123",

                      style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Delivery Fee:",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Text(
                      "\$ ${model.orderDetail.value!.serviceCharges ?? 0.0.toString()}",
                      // "\$ 123",

                      style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total Amount:",
                      style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                            color: Colors.black,
                          ),
                    ),
                    Text(
                      "\$ ${model.orderDetail.value!.netAmount!.toStringAsFixed(2)}",
                      // "\$ 123",
                      style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
