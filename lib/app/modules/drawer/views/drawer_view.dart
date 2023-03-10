import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import 'package:get/get.dart';
import 'package:serveeasy_app/app/data/widgets/primary_button.dart';
import 'package:serveeasy_app/app/modules/drawer/controllers/drawer_controller.dart';
import 'package:sizer/sizer.dart';

class DrawerView extends GetView<DrawerViewController> {
  const DrawerView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(DrawerViewController());
    return GetX<DrawerViewController>(
      builder: (model) {
        return ZoomDrawer(
          controller: model.drawerController,
          mainScreenScale: 0.2,
          moveMenuScreen: false,
          openCurve: Curves.fastOutSlowIn,
          closeCurve: Curves.fastOutSlowIn,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 10,
              blurRadius: 50,
            ),
          ],
          menuScreen: Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () => model.changePage(5),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment:
                              // model.isGuest
                              //     ? CrossAxisAlignment.start
                              //     :

                              CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: model
                                  .configuration.secondaryColor
                                  .withOpacity(0.15),
                              child: Text(
                                model.getFirstLetter,
                                style: Theme.of(context)
                                    .textTheme
                                    .displayLarge!
                                    .copyWith(
                                      fontSize: 24,
                                      color: model.configuration.secondaryColor,
                                    ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            SizedBox(
                              width: 130,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    // model.isGuest
                                    //     ? "Sign in to unlock exclusive offers and discounts"
                                    //     :

                                    model.user.value!.fullName!,
                                    maxLines: 2,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall!
                                        .copyWith(fontSize: 16),
                                  ),
                                  // if (model.isGuest) SizedBox(height: 10),
                                  // if (model.isGuest)
                                  //   PrimaryButton(
                                  //     buttonColor: Colors.transparent,
                                  //     buttonWidth: 80,
                                  //     buttonHeight: 40,
                                  //     text: 'Sign In',
                                  //     borderColor: Colors.black,
                                  //     textStyle: Theme.of(context)
                                  //         .textTheme
                                  //         .headlineMedium!
                                  //         .copyWith(
                                  //           fontSize: 14,
                                  //           color: Colors.black,
                                  //         ),
                                  //     onTap: () => model.onSignInTap(),
                                  //   ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 5.h),
                      ...model.menuItems
                          .map(
                            (item) => TextButton(
                              onPressed: () {
                                model.changePage(item.index);
                              },
                              style: ButtonStyle(
                                overlayColor: MaterialStateColor.resolveWith(
                                  (states) => model.configuration.secondaryColor
                                      .withOpacity(0.1),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Image.asset(
                                    item.assetIcon,
                                    scale: 3,
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      item.title,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium!
                                          .copyWith(color: Colors.black),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                          .toList(),
                      SizedBox(height: 5.h),
                      TextButton(
                        onPressed: () {
                          model.logoutUser();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Icon(
                              Icons.logout,
                              color: Colors.red,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                "Logout",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .copyWith(color: Colors.red),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  Positioned(
                    bottom: 0.h,
                    child: const Padding(
                      padding: EdgeInsets.only(left: 16.0, bottom: 26),
                      child: Text("Powered by Searve Easy"),
                    ),
                  )
                ],
              ),
            ),
          ),
          menuBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
          mainScreen: model.menuItems[model.currentIndex.value].linkedPage,
          borderRadius: 24.0,
          angle: 0.0,
          slideWidth: MediaQuery.of(context).size.width * 0.72,
        );
      },
    );
  }
}
