import 'package:flutter/material.dart';
import 'package:serveeasy_app/app/data/models/order/dispute_list_response_model.dart';
import 'package:serveeasy_app/app/data/models/order/order_history_response_model.dart';
import 'package:serveeasy_app/app/data/models/order/transaction_history_response_model.dart';
import 'package:serveeasy_app/app/data/widgets/primary_button.dart';
import 'package:serveeasy_app/core/constants/asset_constants.dart';
import 'package:serveeasy_app/core/constants/configuration.dart';

class OrderHistoryItem extends StatelessWidget {
  const OrderHistoryItem({
    super.key,
    required this.order,
    required this.onTap,
    this.secondaryColor = Colors.black,
    this.isActiveOrder = false,
  });
  final Transaction order;
  final Function()? onTap;
  final Color secondaryColor;
  final bool isActiveOrder;
  TextTheme _textTheme(context) => Theme.of(context).textTheme;

  @override
  Widget build(BuildContext context) {
    Configuration configuration = Configuration();
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                children: [
                  // ClipRRect(
                  //   borderRadius: BorderRadius.circular(8),
                  //   child: Container(
                  //     height: 110,
                  //     width: 100,
                  //     decoration: const BoxDecoration(
                  //       image: DecorationImage(
                  //         image: AssetImage(
                  //           dummyFoodImage,
                  //         ),
                  //         fit: BoxFit.cover,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Order Number # ${order.id}",
                          overflow: TextOverflow.ellipsis,
                          style: _textTheme(context).headlineMedium,
                        ),
                        const SizedBox(height: 5),
                        SizedBox(
                          width: 200,
                          child: Text(
                            "Name: " +
                                order.vendorBusinessDetail!.businessName!,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: _textTheme(context)
                                .headlineMedium!
                                .copyWith(color: Colors.black, fontSize: 16),
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: Text(
                            "Phone: " + order.guestUser!.phone!,
                            overflow: TextOverflow.ellipsis,
                            style: _textTheme(context)
                                .headlineMedium!
                                .copyWith(fontSize: 16),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total transaction: ",
                              overflow: TextOverflow.ellipsis,
                              style: _textTheme(context).headlineMedium,
                            ),
                            Text(
                              "\$ ${order.amount}",
                              overflow: TextOverflow.ellipsis,
                              style: _textTheme(context).displaySmall!.copyWith(
                                    color: secondaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Visibility(
                visible: isActiveOrder,
                child: const SizedBox(height: 10),
              ),
              Visibility(
                visible: isActiveOrder,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "23 Nov 2022, 14:34",
                      overflow: TextOverflow.ellipsis,
                      style: _textTheme(context).headlineMedium,
                    ),
                    SizedBox(
                      height: 40,
                      width: 120,
                      child: PrimaryButton(
                        text: 'Dispute',
                        // isLoading: model.isPlacingOrder.value,
                        buttonColor: configuration.secondaryColor,
                        textStyle: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                        onTap: () {
                          // model.createOrder();
                        },
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DisputeItem extends StatelessWidget {
  const DisputeItem({
    super.key,
    required this.order,
    required this.onTap,
    this.secondaryColor = Colors.black,
    this.isActiveOrder = false,
  });
  final Dispute order;
  final Function()? onTap;
  final Color secondaryColor;
  final bool isActiveOrder;
  TextTheme _textTheme(context) => Theme.of(context).textTheme;

  @override
  Widget build(BuildContext context) {
    Configuration configuration = Configuration();
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                children: [
                  // ClipRRect(
                  //   borderRadius: BorderRadius.circular(8),
                  //   child: Container(
                  //     height: 110,
                  //     width: 100,
                  //     decoration: const BoxDecoration(
                  //       image: DecorationImage(
                  //         image: AssetImage(
                  //           dummyFoodImage,
                  //         ),
                  //         fit: BoxFit.cover,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Order Number # ${order.id}",
                          overflow: TextOverflow.ellipsis,
                          style: _textTheme(context).headlineMedium,
                        ),
                        const SizedBox(height: 5),
                        SizedBox(
                          width: 200,
                          child: Text(
                            order.comments == null
                                ? "No Comments"
                                : order.comments!,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: _textTheme(context)
                                .headlineMedium!
                                .copyWith(color: Colors.black, fontSize: 16),
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: Text(
                            "Phone: " + order.payment!.guestUser!.phone!,
                            overflow: TextOverflow.ellipsis,
                            style: _textTheme(context)
                                .headlineMedium!
                                .copyWith(fontSize: 16),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total transaction: ",
                              overflow: TextOverflow.ellipsis,
                              style: _textTheme(context).headlineMedium,
                            ),
                            Text(
                              "\$ ${order.payment!.amount}",
                              overflow: TextOverflow.ellipsis,
                              style: _textTheme(context).displaySmall!.copyWith(
                                    color: secondaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Visibility(
                visible: isActiveOrder,
                child: const SizedBox(height: 10),
              ),
              Visibility(
                visible: isActiveOrder,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "23 Nov 2022, 14:34",
                      overflow: TextOverflow.ellipsis,
                      style: _textTheme(context).headlineMedium,
                    ),
                    SizedBox(
                      height: 40,
                      width: 120,
                      child: PrimaryButton(
                        text: 'Dispute',
                        // isLoading: model.isPlacingOrder.value,
                        buttonColor: configuration.secondaryColor,
                        textStyle: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                        onTap: () {
                          // model.createOrder();
                        },
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
