import 'package:flutter/material.dart';
import 'package:serveeasy_app/app/data/models/order/order_history_response_model.dart';
import 'package:serveeasy_app/app/data/widgets/primary_button.dart';
import 'package:serveeasy_app/core/constants/asset_constants.dart';

class OrderHistoryItem extends StatelessWidget {
  const OrderHistoryItem({
    super.key,
    required this.order,
    required this.onTap,
    this.secondaryColor = Colors.black,
    this.isActiveOrder = false,
  });
  final OrderData order;
  final Function()? onTap;
  final Color secondaryColor;
  final bool isActiveOrder;
  TextTheme _textTheme(context) => Theme.of(context).textTheme;

  @override
  Widget build(BuildContext context) {
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
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      height: 110,
                      width: 100,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            dummyFoodImage,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "# ${order.id}",
                          overflow: TextOverflow.ellipsis,
                          style: _textTheme(context).headlineMedium,
                        ),
                        const SizedBox(height: 5),
                        SizedBox(
                          width: 200,
                          child: Text(
                            order.establishment!.name!,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: _textTheme(context)
                                .headlineMedium!
                                .copyWith(color: Colors.black),
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: Text(
                            order.getItemsString,
                            overflow: TextOverflow.ellipsis,
                            style: _textTheme(context).headlineMedium,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total (Incl. VAT): ",
                              overflow: TextOverflow.ellipsis,
                              style: _textTheme(context).headlineMedium,
                            ),
                            Text(
                              "\$ ${order.netAmount}",
                              overflow: TextOverflow.ellipsis,
                              style: _textTheme(context)
                                  .displaySmall!
                                  .copyWith(color: secondaryColor),
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
                        text: 'Reorder',
                        // isLoading: model.isPlacingOrder.value,
                        textStyle:
                            Theme.of(context).textTheme.headlineMedium!.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: secondaryColor,
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
