import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:serveeasy_app/app/data/widgets/primary_button.dart';
import 'package:serveeasy_app/core/constants/asset_constants.dart';

import '../controllers/ask_location_controller.dart';

class AskLocationView extends GetView<AskLocationController> {
  const AskLocationView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(AskLocationController());
    return GetX<AskLocationController>(
      builder: (model) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      findLocationImage,
                      scale: 2.5,
                    ),
                    const SizedBox(height: 50),
                    Text(
                      "Find food near you!",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Would you like to explore places nearby you?",
                      style: Theme.of(context).textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Visibility(
                      visible: model.hasDevicePermission.value,
                      child: PrimaryButton(
                        buttonColor: model.configuration.secondaryColor,
                        isLoading: model.isLoading.value,
                        leadingWidget: const Icon(
                          Icons.my_location_rounded,
                          size: 30,
                          color: Colors.white,
                        ),
                        text: 'Device Location',
                        textStyle: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                        onTap: () => model.onDeviceLocationTap(),
                      ),
                    ),
                    TextButton(
                      onPressed: () => model.onManualLocationTap(),
                      child: Text(
                        "Enter Your Location Manually",
                        style:
                            Theme.of(context).textTheme.displaySmall!.copyWith(
                                  color: model.configuration.secondaryColor,
                                ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
