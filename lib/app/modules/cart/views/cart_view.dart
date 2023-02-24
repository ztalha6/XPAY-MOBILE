import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:serveeasy_app/app/data/widgets/cart_item_widget.dart';
import 'package:serveeasy_app/app/data/widgets/deal_item_widget.dart';
import 'package:serveeasy_app/app/data/widgets/primary_button.dart';
import 'package:serveeasy_app/app/modules/cart/controllers/cart_controller.dart';
import 'package:serveeasy_app/app/modules/home_summary/controllers/main_controller.dart';
import 'package:sizer/sizer.dart';

class CartView extends GetView<CartController> {
  const CartView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetX<MainController>(
      builder: (model) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              'Cart',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            centerTitle: false,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: TextButton(
                  onPressed: () {
                    model.clearCart();
                  },
                  child: Text(
                    "Clear",
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          color: Colors.black,
                        ),
                  ),
                ),
              )
            ],
          ),
          body: SizedBox(
            height: Get.height,
            child: Stack(
              children: [
                SizedBox(
                  height: Get.height * 0.53,
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: model.dealItems.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return Obx(
                            () => DealItemWidget(
                              dealItem: model.dealItems[index],
                              configuration: model.configuration,
                              onAdd: () {
                                model.addDealItemQuantity(index);
                              },
                              onDelete: () {
                                model.removeDeal(model.dealItems[index]);
                              },
                              onRemove: () {
                                model.removeDealItemQuantity(index);
                              },
                            ),
                          );
                        },
                      ),
                      ListView.builder(
                        padding: const EdgeInsets.all(16),
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: model.cartItems.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Obx(
                            () => CartItemWidget(
                              cartItem: model.cartItems[index],
                              configuration: model.configuration,
                              onAdd: () {
                                model.addCartItemQuantity(index);
                              },
                              onDelete: () {
                                model.remove(model.cartItems[index]);
                              },
                              onRemove: () {
                                model.removeCartItemQuantity(index);
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0.h,
                  child: const BottomWidget(),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class BottomWidget extends StatelessWidget {
  const BottomWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<MainController>(
      builder: (model) {
        return Column(
          children: [
            SizedBox(
              width: Get.width,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Sub Total:",
                                  style: Theme.of(context).textTheme.headlineMedium,
                                ),
                                Text(
                                  "\$ ${model.summry.value.grossAmount.toString()}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Tax GST:",
                                  style: Theme.of(context).textTheme.headlineMedium,
                                ),
                                Text(
                                  "\$ ${0.0}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Delivery Fee:",
                                  style: Theme.of(context).textTheme.headlineMedium,
                                ),
                                Text(
                                  "\$ ${model.summry.value.serviceCharges ?? 0.0.toString()}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total Amount:",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(
                                    color: Colors.black,
                                  ),
                            ),
                            Text(
                              "\$ ${model.summry.value.netAmount.toString()}",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
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
                                  'Total (VAT incl.)',
                                  style: Theme.of(context).textTheme.headlineMedium,
                                ),
                                Text(
                                  "\$ ${model.summry.value.netAmount.toString()}",
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
                            text: 'Checkout',
                            textStyle:
                                Theme.of(context).textTheme.headlineMedium!.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: model.configuration.secondaryColor,
                                    ),
                            onTap: model.cartItems.isEmpty &&
                                    model.dealItems.isEmpty
                                ? null
                                : () {
                                    model.proceedToCheckout();
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
