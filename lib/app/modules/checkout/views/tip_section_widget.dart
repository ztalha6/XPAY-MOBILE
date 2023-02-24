import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:serveeasy_app/app/data/widgets/custom_text_form_field.dart';
import 'package:serveeasy_app/app/modules/checkout/controllers/checkout_controller.dart';
import 'package:serveeasy_app/core/constants/asset_constants.dart';

class TipSection extends StatelessWidget {
  const TipSection({
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
            title: Text(
              "Tip Your Rider",
              style:
                  Theme.of(context).textTheme.displayLarge!.copyWith(fontSize: 14),
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 5),
                Text(
                  "Add tip to your rider this totally goes to him",
                  maxLines: 2,
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .copyWith(fontSize: 12),
                ),
                const SizedBox(height: 5),
                SizedBox(
                  height: 60,
                  child: ListView.builder(
                    itemCount: model.tips.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return Obx(
                        () => Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                FilterChip(
                                  label: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          model.tips[index] == 0
                                              ? "Not now"
                                              : "${model.tips[index].toString()} %",
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayLarge!
                                              .copyWith(
                                                color:
                                                    model.selectedTip.value ==
                                                            index
                                                        ? model.configs
                                                            .secondaryColor
                                                        : Colors.grey,
                                                fontSize: 14,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  backgroundColor: Colors.transparent,
                                  shape: model.selectedTip.value == index
                                      ? StadiumBorder(
                                          side: BorderSide(
                                            color: model.configs.secondaryColor,
                                          ),
                                        )
                                      : null,
                                  onSelected: (bool value) {
                                    model.onTipChange(index);
                                  },
                                ),
                                const SizedBox(width: 5)
                              ],
                            ),
                            if (index == 2)
                              Text(
                                "Most Common",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .copyWith(
                                      color: model.configs.secondaryColor,
                                      fontSize: 10,
                                    ),
                              )
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  "Custom Amount:",
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        fontSize: 14,
                        color: const Color(
                          0xFF707581,
                        ),
                      ),
                ),
                CustomTextFormField(
                  controller: model.customTipController,
                  hintText: "Your tip here",
                  keyboardType: TextInputType.number,
                  onChanged: (s) {
                    model.onTipChange(-2);
                  },
                  textInputAction: TextInputAction.next,
                ),
              ],
            ),
            leading: Image.asset(
              cardIcon,
              scale: 1.8,
            ),
          ),
        );
      },
    );
  }
}
