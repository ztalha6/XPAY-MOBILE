import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:serveeasy_app/app/data/widgets/primary_button.dart';
import 'package:serveeasy_app/app/modules/home_summary/controllers/main_controller.dart';
import 'package:serveeasy_app/app/routes/app_pages.dart';
import 'package:serveeasy_app/core/constants/asset_constants.dart';
import 'package:sizer/sizer.dart';

class BottomCartWidget extends StatelessWidget {
  const BottomCartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<MainController>(builder: (model) {
      return Container(
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
              offset: const Offset(
                0,
                3,
              ), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 5,
                child: SizedBox(
                  // width: 38.w,
                  child: Row(
                    children: [
                      Stack(
                        children: [
                          Image.asset(
                            cartIcon,
                            scale: 2.3,
                          ),
                          Transform.translate(
                            offset: const Offset(20, -8),
                            child: Container(
                              padding: const EdgeInsets.all(1),
                              decoration: BoxDecoration(
                                color: model.configuration.secondaryColor,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              constraints: const BoxConstraints(
                                minWidth: 18,
                                minHeight: 18,
                              ),
                              child: Text(
                                model.cartItems.length.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "\$ ${model.summry.value.netAmount.toString()}",
                            style:
                                Theme.of(context).textTheme.displayLarge!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                          ),
                          Text(
                            'Cart Total(VAT incl.)',
                            style: Theme.of(context).textTheme.headlineMedium,
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
                      text: 'View Cart',
                      textStyle:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                                color: model.configuration.secondaryColor,
                              ),
                      onTap: () {
                        Get.toNamed(Routes.CART);
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },);
  }
}
