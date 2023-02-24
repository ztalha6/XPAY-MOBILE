import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:rect_getter/rect_getter.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:serveeasy_app/app/data/models/menu/menu_data_response_model.dart';
import 'package:serveeasy_app/app/modules/home_summary/controllers/main_controller.dart';
import 'package:serveeasy_app/app/modules/menu/views/bottom_cart_widget.dart';
import 'package:serveeasy_app/app/modules/menu/views/browse_menu_dialog.dart';
import 'package:serveeasy_app/app/modules/menu/views/menu_section_widget.dart';
import 'package:serveeasy_app/app/routes/app_pages.dart';
import 'package:serveeasy_app/core/constants/asset_constants.dart';
import 'package:sizer/sizer.dart';

class MenuView extends GetView {
  const MenuView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(MainController());
    return GetX<MainController>(
      builder: (model) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              "Explore Menu",
              style: Theme.of(context).textTheme.displayLarge,
            ),
            centerTitle: false,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: IconButton(
                  onPressed: () {
                    Get.toNamed(Routes.SEARCH_PRODUCT);
                  },
                  icon: Image.asset(
                    searchIcon,
                    scale: 3,
                    color: model.configuration.secondaryColor,
                  ),
                ),
              )
            ],
          ),
          body: Stack(
            children: [
              Column(
                children: [
                  Container(
                    color: Colors.white,
                    child: Row(
                      children: [
                        Expanded(
                          child: TabBar(
                            isScrollable: true,
                            controller: model.tabController,
                            indicatorPadding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            indicatorColor: model.configuration.secondaryColor,
                            labelColor: Theme.of(context).primaryColor,
                            unselectedLabelColor: Colors.grey,
                            indicatorWeight: 3.0,
                            labelStyle: Theme.of(context).textTheme.displayLarge,
                            unselectedLabelStyle:
                                Theme.of(context).textTheme.headlineMedium,
                            tabs: model.menuData.value!.menu!.map((e) {
                              return Tab(text: e.name);
                            }).toList(),
                            onTap: (index) => model.animateAndScrollTo(index),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: RectGetter(
                      key: model.listViewKey,
                      child: NotificationListener<ScrollNotification>(
                        onNotification: model.onScrollNotification,
                        child: CustomScrollView(
                          controller: model.scrollController,
                          slivers: [
                            SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (context, index) {
                                  model.itemKeys[index] =
                                      RectGetter.createGlobalKey();
                                  final Menu menu =
                                      model.menuData.value!.menu![index];
                                  return Padding(
                                    padding: EdgeInsets.only(
                                      bottom:
                                          model.menuData.value!.menu!.length !=
                                                  (index + 1)
                                              ? 0.0
                                              : 80.0,
                                    ),
                                    child: RectGetter(
                                      key: model.itemKeys[index],
                                      child: AutoScrollTag(
                                        key: ValueKey(index),
                                        index: index,
                                        controller: model.scrollController,
                                        child: MenuSection(
                                          menu: menu,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                childCount: model.menuData.value!.menu!.length,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Positioned(
                bottom: 0.h,
                child: SizedBox(
                  width: Get.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const MenuPopupWidget(),
                      SizedBox(height: 2.h),
                      if (model.cartItems.isNotEmpty ||
                          model.dealItems.isNotEmpty)
                        const BottomCartWidget(),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
