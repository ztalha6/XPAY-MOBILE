import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'package:get/get.dart';
import 'package:serveeasy_app/core/constants/asset_constants.dart';
import 'package:sizer/sizer.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return GetX<HomeController>(
      builder: (model) {
        return Scaffold(
          body: Stack(
            children: [
              Container(
                foregroundDecoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.black,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0, 0.9],
                  ),
                ),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(homeBackgound),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset(
                    model.configs.logoWithName,
                    scale: 3,
                  ),
                  Text(
                    'Select your order type.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .displayLarge!
                        .copyWith(color: Colors.white),
                  ),
                  SizedBox(
                    height: Get.height / 3.5,
                    child: AnimationLimiter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6.w),
                        child: GridView.count(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          crossAxisCount: 2,
                          children: List.generate(
                            model.orderTypes.length,
                            (int index) {
                              return AnimationConfiguration.staggeredGrid(
                                position: index,
                                duration: const Duration(
                                  milliseconds: 375,
                                ),
                                columnCount: 2,
                                child: ScaleAnimation(
                                  child: FadeInAnimation(
                                    child: OrderTypeWidget(
                                      text: model.orderTypes[index].name
                                          .capitalizeFirst!,
                                      icon: Image.asset(
                                        model.orderTypes[index].image,
                                        // scale: 1,
                                      ),
                                      // icon: SvgPicture.asset(
                                      //   model.orderTypes[index].image,
                                      //   color: model.configs.secondaryColor,
                                      // ),
                                      onTap: () {
                                        model.gotoLocation(index);
                                      },
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 9.w, right: 9.w, bottom: 1.h),
                    child: Container(
                      decoration: BoxDecoration(
                        // border: Colors.white,
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      // height: 50.h,
                      width: Get.width,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              feedbackIcon,
                              scale: 2.5,
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              "Submit Feedback",
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall!
                                  .copyWith(color: Colors.black, fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}

class OrderTypeWidget extends StatelessWidget {
  const OrderTypeWidget({
    Key? key,
    required this.text,
    required this.icon,
    required this.onTap,
  }) : super(key: key);
  final String text;
  final Widget icon;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: BoxDecoration(
            // border: Colors.white,
            color: Colors.white.withOpacity(0.8),
            borderRadius: const BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          height: 50.h,
          width: 50.w,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon,
                SizedBox(height: 2.h),
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(color: Colors.black, fontSize: 14),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
