import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:serveeasy_app/app/data/widgets/custom_pin_code_field.dart';
import 'package:serveeasy_app/app/data/widgets/loading_widget.dart';
import 'package:serveeasy_app/app/data/widgets/primary_button.dart';
import 'package:sizer/sizer.dart';

import '../controllers/verify_address_controller.dart';

class VerifyAddressViewParams {
  final bool forAddressVerification;
  final int newAddressId;
  VerifyAddressViewParams(
      {this.forAddressVerification = false, required this.newAddressId});
}

class VerifyAddressView extends GetView<VerifyAddressController> {
  const VerifyAddressView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(VerifyAddressController());
    return GetX<VerifyAddressController>(
      builder: (model) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Address Verification',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.060),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                Wrap(
                  children: [
                    Text(
                      'Please enter the OTP you recived on SMS',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    // Text(
                    //   email,
                    //   style: Theme.of(context)
                    //       .textTheme
                    //       .headline4!
                    //       .copyWith(fontWeight: FontWeight.w500),
                    // ),
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.033,
                ),
                Center(
                  child: SizedBox(
                    width: Get.width / 1.5,
                    child: CustomPinCodeField(
                      controller: model.otpController,
                      validator: (s) =>
                          s!.isEmpty ? 'Field cannot be empty' : null,
                      onCompleted: (s) => model.onVerifyTap(),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (model.start.value != 0)
                      RichText(
                        text: TextSpan(
                          text: "Expires in: ",
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    fontSize: 14,
                                    color: const Color(0xFF707581),
                                  ),
                          children: <TextSpan>[
                            TextSpan(
                              text: '${model.start} sec',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                    fontSize: 14,
                                    color: model.config.secondaryColor,
                                  ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {
                                  await model.resendOtp();
                                },
                            )
                          ],
                        ),
                      )
                    else
                      const SizedBox.shrink(),
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.048,
                ),
                if (model.isLoading.isTrue)
                  Center(
                    child: Column(
                      children: [
                        const LoadingWidget(),
                        SizedBox(height: 2.h),
                        Text(
                          "Verifying OTP",
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(fontSize: 16, color: Colors.black),
                        ),
                      ],
                    ),
                  )
                else
                  PrimaryButton(
                    onTap: () => model.onVerifyTap(),
                    text: 'Verify',
                    isLoading: model.isLoading.value,
                    isDisabled: model.isResending.isTrue,
                    textStyle:
                        Theme.of(context).textTheme.headlineMedium!.copyWith(
                              color: Colors.white,
                            ),
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: "Didn't receive code?",
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(color: Colors.black),
                          children: <TextSpan>[
                            TextSpan(
                              text: ' Resend',
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall!
                                  .copyWith(
                                    color: model.config.secondaryColor,
                                  ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {
                                  await model.resendOtp();
                                },
                            )
                          ],
                        ),
                      ),
                    ],
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
