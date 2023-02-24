import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:serveeasy_app/app/modules/checkout/controllers/checkout_controller.dart';
import 'package:serveeasy_app/core/constants/asset_constants.dart';

class SelectCouponWidget extends StatelessWidget {
  const SelectCouponWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<CheckoutController>(
      builder: (model) {
        return Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: ListTile(
            onTap: model.promoCode.isNotEmpty
                ? null
                : () {
                    model.applyPromoCode();
                  },
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: model.promoCode.isEmpty ? null : 50,
                  child: Text(
                    model.promoCode.isEmpty
                        ? "Apply Coupons"
                        : model.promoCode.value.toUpperCase(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .displayLarge!
                        .copyWith(fontSize: 14),
                  ),
                ),
                if (model.promoCode.isNotEmpty)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(width: 6),
                      TextButton(
                        onPressed: () {
                          model.removePromoCode();
                        },
                        child: Text(
                          "Remove",
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ),
                    ],
                  )
              ],
            ),
            subtitle: model.promoCode.isEmpty
                ? Text(
                    "Apply coupon & avail great offers",
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(fontSize: 12),
                  )
                : null,
            leading: Image.asset(
              couponIcon,
              scale: 1.8,
            ),
            trailing: model.promoCode.isEmpty
                ? const Icon(Icons.arrow_forward_ios_rounded)
                : Container(
                    decoration: BoxDecoration(
                      color: model.configs.secondaryColor.withOpacity(0.2),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "- \$ ${model.summary.value.discount}",
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(color: model.configs.secondaryColor),
                      ),
                    ),
                  ),
          ),
        );
      },
    );
  }
}
