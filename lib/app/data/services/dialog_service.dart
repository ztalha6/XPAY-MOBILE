import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:serveeasy_app/app/data/widgets/primary_button.dart';
import 'package:sizer/sizer.dart';

class DialogService {
  Future<bool?> showOrderServedDialog() {
    return showDialog<bool>(
      context: Get.context!,
      barrierColor: Colors.white.withOpacity(0.1),
      barrierDismissible: false,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
          child: Container(
            color: const Color.fromRGBO(0, 0, 0, 1).withOpacity(0.2),
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              contentPadding: EdgeInsets.zero,
              content: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFf7f7f7),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                ),
                // width: 50.w,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 4.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Image.asset(
                      //   success,
                      //   scale: 6,
                      // ),
                      SizedBox(height: 2.h),
                      Text(
                        'Ordered',
                        style: Theme.of(context).textTheme.displayLarge!.copyWith(
                              color: const Color(0xFF646C7C),
                              fontSize: 16.sp,
                            ),
                      ),
                      Text(
                        'Your order has been proceed to kitchen',
                        style: Theme.of(context).textTheme.displayLarge!.copyWith(
                              color: const Color(0xFF959597),
                              fontSize: 5.sp,
                            ),
                      ),
                      SizedBox(height: 8.h),
                      SizedBox(
                        height: 50,
                        width: 35.w,
                        child: PrimaryButton(
                          buttonColor: Theme.of(context).primaryColor,
                          // isLoading: model.isLoading.value,
                          onTap: () {
                            Get.back(result: true);
                          },
                          text: 'Back to Main Menu',
                          textStyle:
                              Theme.of(context).textTheme.headlineMedium!.copyWith(
                                    fontSize: 6.sp,
                                    color: Colors.white,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<bool?> showConfirmationDialog({
    required String title,
    required String description,
    bool onlyOK = false,
  }) {
    return showDialog<bool>(
      context: Get.context!,
      barrierColor: Colors.white.withOpacity(0.1),
      barrierDismissible: false,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
          child: Container(
            color: const Color.fromRGBO(0, 0, 0, 1).withOpacity(0.2),
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              contentPadding: EdgeInsets.zero,
              content: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFf7f7f7),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.warning_amber_rounded,
                        size: 50,
                        color: Colors.grey.shade500,
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        title,
                        style: Theme.of(context).textTheme.displayLarge!.copyWith(
                              color: const Color(0xFF646C7C),
                            ),
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        description,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                              color: const Color(0xFF959597),
                            ),
                      ),
                      SizedBox(height: 2.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          if (!onlyOK)
                            SizedBox(
                              height: 50,
                              width: 25.w,
                              child: PrimaryButton(
                                buttonColor: Colors.white.withOpacity(0.1),
                                // isLoading: model.isLoading.value,
                                onTap: () {
                                  Get.back(result: false);
                                },
                                text: 'No',
                                borderColor: Colors.grey.withOpacity(0.3),
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .copyWith(
                                      color: Colors.black,
                                    ),
                              ),
                            ),
                          SizedBox(
                            height: 50,
                            width: 25.w,
                            child: PrimaryButton(
                              buttonColor: Colors.grey.withOpacity(0.3),
                              // isLoading: model.isLoading.value,
                              onTap: () {
                                Get.back(result: true);
                              },
                              borderColor: Colors.grey.withOpacity(0.3),
                              text: onlyOK ? "OK" : 'Yes',
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(
                                    color: Colors.black,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
