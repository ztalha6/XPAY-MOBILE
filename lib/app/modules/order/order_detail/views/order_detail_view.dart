import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:serveeasy_app/app/modules/order/order_detail/views/order_detail_widget.dart';
import 'package:serveeasy_app/app/modules/order/order_detail/views/order_status_indicator_widget.dart';
import 'package:serveeasy_app/core/constants/asset_constants.dart';

import '../controllers/order_detail_controller.dart';

class OrderDetailViewParams {
  final int orderId;

  OrderDetailViewParams(this.orderId);
}

class OrderDetailView extends GetView<OrderDetailController> {
  const OrderDetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: Text(
            'Order Status',
            style: Theme.of(context).textTheme.displayLarge,
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            controller.onInit();
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                child: controller.isLoading.isTrue
                    ? LinearProgressIndicator(
                        color: controller.configs.secondaryColor,
                        backgroundColor:
                            controller.configs.secondaryColor.withOpacity(0.5),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Order ID:",
                                  style: Theme.of(context).textTheme.headlineMedium,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "#${controller.orderDetail.value!.id!}",
                                      style:
                                          Theme.of(context).textTheme.displaySmall,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Estimated Pickup Time:",
                                  style: Theme.of(context).textTheme.headlineMedium,
                                ),
                                Text(
                                  "30 - 40 mins",
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayLarge!
                                      .copyWith(fontSize: 14),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          shopIcon,
                                          scale: 2.3,
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          controller.orderDetail.value!
                                              .establishment!.name!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayLarge!
                                              .copyWith(fontSize: 14),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    SizedBox(
                                      width: 300,
                                      child: Text(
                                        controller.orderDetail.value!
                                            .establishment!.address!,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                            DeliveryProcessWidget(
                              status: controller.getOrderStatus,
                            ),
                            OrderDeatilWidget()
                          ],
                        ),
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
