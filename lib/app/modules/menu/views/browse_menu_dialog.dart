import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:serveeasy_app/app/data/widgets/cached_image_widget.dart';
import 'package:serveeasy_app/app/modules/home_summary/controllers/main_controller.dart';
import 'package:serveeasy_app/core/constants/asset_constants.dart';

class MenuPopupWidget extends StatelessWidget {
  const MenuPopupWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<MainController>(
      builder: (model) {
        return InkWell(
          onTap: model.isLoadingMenu.isTrue
              ? () {}
              : () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        content: SizedBox(
                          width: double.maxFinite,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Menu",
                                style: Theme.of(context)
                                    .textTheme
                                    .displayLarge!
                                    .copyWith(fontSize: 20),
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                height: Get.height / 1.5,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: model.menuData.value!.menu!.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return ListTile(
                                      onTap: () {
                                        Get.back();
                                        model.animateAndScrollTo(index);
                                      },
                                      contentPadding: EdgeInsets.zero,
                                      title: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SizedBox(
                                            height: 50,
                                            width: 50,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                8,
                                              ),
                                              child: CachedImageWidget(
                                                url: model
                                                            .menuData
                                                            .value!
                                                            .menu![index]
                                                            .categoryImage !=
                                                        null
                                                    ? model
                                                        .menuData
                                                        .value!
                                                        .menu![index]
                                                        .categoryImage!
                                                        .mediaUrl!
                                                    : "",
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            model.menuData.value!.menu![index]
                                                .name!,
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF2A2F35),
              borderRadius: const BorderRadius.all(
                Radius.circular(10.0),
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
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    browseIcon,
                    scale: 3,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "Browse Menu",
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall!
                        .copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
