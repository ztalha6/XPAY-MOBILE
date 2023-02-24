import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import 'package:get/get.dart';
import 'package:serveeasy_app/app/data/widgets/loading_widget.dart';
import 'package:serveeasy_app/core/constants/asset_constants.dart';

import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(SettingsController());
    return GetX<SettingsController>(
      builder: (model) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Settings',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            backgroundColor: Colors.white,
            leading: InkWell(
              onTap: () => ZoomDrawer.of(context)!.toggle(),
              child: Image.asset(
                menuIcon,
                scale: 2.5,
              ),
            ),
          ),
          body: model.isLoading.isTrue
              ? const LoadingWidget()
              : Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    children: [
                      Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: ListTile(
                          onTap: () {},
                          contentPadding:
                              const EdgeInsets.only(left: 8, right: 8),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                laguageIcon,
                                scale: 2.8,
                              ),
                              Text(
                                "Choose Laguage",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .copyWith(
                                      fontSize: 13,
                                      color: Colors.black,
                                    ),
                              ),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      model.setLang(1);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: model.selectedLang.value == 1
                                            ? model.configuration.secondaryColor
                                            : Colors.white,
                                        border: Border.all(
                                          color: model.selectedLang.value == 1
                                              ? model
                                                  .configuration.secondaryColor
                                              : Colors.black,
                                        ),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 8.0,
                                          horizontal: 16,
                                        ),
                                        child: Text(
                                          "English",
                                          style: Theme.of(context)
                                              .textTheme
                                              .displaySmall!
                                              .copyWith(
                                                fontSize: 13,
                                                color:
                                                    model.selectedLang.value ==
                                                            1
                                                        ? Colors.white
                                                        : null,
                                              ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  InkWell(
                                    onTap: () {
                                      model.setLang(2);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: model.selectedLang.value == 2
                                            ? model.configuration.secondaryColor
                                            : Colors.white,
                                        border: Border.all(
                                          color: model.selectedLang.value == 2
                                              ? model
                                                  .configuration.secondaryColor
                                              : Colors.black,
                                        ),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 8.0,
                                          horizontal: 16,
                                        ),
                                        child: Text(
                                          "العربية",
                                          style: Theme.of(context)
                                              .textTheme
                                              .displaySmall!
                                              .copyWith(
                                                fontSize: 13,
                                                color:
                                                    model.selectedLang.value ==
                                                            2
                                                        ? Colors.white
                                                        : null,
                                              ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          // leading: Image.asset(
                          //   laguageIcon,
                          //   scale: 2.8,
                          // ),
                        ),
                      )
                    ],
                  ),
                ),
        );
      },
    );
  }
}
