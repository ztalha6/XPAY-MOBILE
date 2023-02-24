import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import 'package:get/get.dart';
import 'package:serveeasy_app/app/data/widgets/cached_image_widget.dart';
import 'package:serveeasy_app/app/data/widgets/custom_slider.dart';
import 'package:serveeasy_app/app/data/widgets/custom_video_player.dart';
import 'package:serveeasy_app/app/data/widgets/grid_view_delegate.dart';
import 'package:serveeasy_app/app/data/widgets/loading_widget.dart';
import 'package:serveeasy_app/app/data/widgets/primary_button.dart';
import 'package:serveeasy_app/app/data/widgets/shimmers.dart';
import 'package:serveeasy_app/app/modules/home_summary/controllers/main_controller.dart';
import 'package:serveeasy_app/app/routes/app_pages.dart';
import 'package:serveeasy_app/core/constants/asset_constants.dart';
import 'package:sizer/sizer.dart';

class HomeSummaryView extends GetView<MainController> {
  const HomeSummaryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(MainController());
    return GetX<MainController>(
      builder: (model) {
        return Scaffold(
          appBar: AppBar(
            title: InkWell(
              onTap: () async {
                model.addressBottomsheet();
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.getAddress,
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  Text(
                    model.getAddress,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
            ),
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
            leading: InkWell(
              onTap: () => ZoomDrawer.of(context)!.toggle(),
              child: Image.asset(
                menuIcon,
                scale: 2.5,
              ),
            ),
          ),
          body: model.isLoading.isTrue
              ? const Center(
                  child: LoadingWidget(),
                )
              : RefreshIndicator(
                  onRefresh: () async {
                    await model.getData();
                  },
                  child: Stack(
                    children: [
                      ListView(
                        children: [
                          Column(
                            children: [
                              Container(
                                color: Colors.grey.shade200,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: Get.width / 1.5,
                                        child: Text(
                                          model.getBranch,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineMedium!
                                              .copyWith(
                                                color: Colors.black,
                                              ),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          model.gotoBranchListing();
                                        },
                                        child: Text(
                                          "Change",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineMedium!
                                              .copyWith(
                                                color: model.configuration
                                                    .secondaryColor,
                                              ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0.0),
                                ),
                                margin: EdgeInsets.zero,
                                elevation: 0,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8.0,
                                    horizontal: 16,
                                  ),
                                  child: Row(
                                    children: List.generate(
                                      model.orderTypes.length,
                                      (index) {
                                        return Row(
                                          children: [
                                            FilterChip(
                                              label: Padding(
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                child: Row(
                                                  children: [
                                                    Image.asset(
                                                      model.orderTypes[index]
                                                          .image,
                                                      scale: 2.5,
                                                    ),
                                                    // SvgPicture.asset(
                                                    //   model.orderTypes[index].image,
                                                    //   color: model
                                                    //       .configs.secondaryColor,
                                                    // ),
                                                    const SizedBox(width: 10),
                                                    Text(
                                                      model
                                                          .orderTypes[index]
                                                          .name
                                                          .capitalizeFirst!,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headlineMedium!
                                                          .copyWith(
                                                            color: model.selectedOrderTypeIndex
                                                                        .value ==
                                                                    index
                                                                ? Colors.black
                                                                : Colors.grey,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              backgroundColor:
                                                  Colors.transparent,
                                              shape:
                                                  model.selectedOrderTypeIndex
                                                              .value ==
                                                          index
                                                      ? const StadiumBorder(
                                                          side: BorderSide(),
                                                        )
                                                      : null,
                                              onSelected: (bool value) {
                                                model.changeOrderType(index);
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Text(
                                    'Exclusive Offers',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge,
                                  ),
                                ),
                                CustomSlider(
                                  imgList: model.imgList,
                                  currentIndex: model.current.value,
                                  activeDotColor:
                                      model.configuration.secondaryColor,
                                  onPageChanged: (index, s) {
                                    model.current(index);
                                  },
                                  showDots: true,
                                  autoPlay: false,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16.0,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Explore Menu',
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayLarge,
                                      ),
                                      TextButton(
                                        onPressed: model.isLoadingMenu.isTrue
                                            ? null
                                            : () {
                                                model.gotoMenu();
                                              },
                                        child: Text(
                                          "View All",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineMedium!
                                              .copyWith(
                                                color: model.configuration
                                                    .secondaryColor,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 280,
                                  child: model.isLoadingMenu.isTrue
                                      ? const GridShimmerWidget()
                                      : GridView.builder(
                                          itemCount: model
                                              .menuData.value!.menu!.length,
                                          scrollDirection: Axis.horizontal,
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                                            crossAxisCount: 2,
                                            height: 120,
                                          ),
                                          itemBuilder: (
                                            BuildContext context,
                                            int index,
                                          ) {
                                            return InkWell(
                                              onTap: model.isLoadingMenu.isTrue
                                                  ? null
                                                  : () {
                                                      model.gotoMenu(
                                                        menuIndex: index,
                                                      );
                                                    },
                                              child: Column(
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      8,
                                                    ),
                                                    child: SizedBox(
                                                      width: 100,
                                                      child: CachedImageWidget(
                                                        url: model
                                                                    .menuData
                                                                    .value!
                                                                    .menu![
                                                                        index]
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
                                                  const SizedBox(height: 3),
                                                  SizedBox(
                                                    width: 80,
                                                    child: Text(
                                                      model.menuData.value!
                                                          .menu![index].name!,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headlineMedium!
                                                          .copyWith(
                                                            color: Colors.black,
                                                          ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Text(
                                    'Top Deals',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge,
                                  ),
                                ),
                                CustomSlider(
                                  imgList: model.imgList,
                                  currentIndex: model.current.value,
                                  activeDotColor:
                                      model.configuration.secondaryColor,
                                  onPageChanged: (index, s) {
                                    model.current(index);
                                  },
                                  autoPlay: false,
                                ),
                                SizedBox(height: 1.5.h),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Container(
                                    width: Get.width,
                                    height: 180.0,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFFFFF8E6),
                                    ),
                                    child: Stack(
                                      children: [
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: Image.asset(
                                            dummyFoodImage,
                                            scale: 2.5,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(18.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '20% off on entire menu',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displayLarge,
                                              ),
                                              SizedBox(
                                                width: 250,
                                                child: Text(
                                                  'When you order \$20+, Automatically applied. Ending on 31/10',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headlineMedium!
                                                      .copyWith(
                                                        color: Colors.black,
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16.0,
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 4,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade300,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          height: 120.0,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Stack(
                                              children: [
                                                Align(
                                                  alignment: Alignment.topRight,
                                                  child: SizedBox(
                                                    width: 65,
                                                    child: Text(
                                                      '100% safe contactless delivery',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headlineMedium!
                                                          .copyWith(
                                                            fontSize: 10,
                                                            color: Colors.black,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                                Align(
                                                  alignment:
                                                      Alignment.bottomLeft,
                                                  child: Image.asset(
                                                    deliveryIcon,
                                                    scale: 2.5,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        flex: 3,
                                        child: Container(
                                          height: 120.0,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                safetyIcon,
                                                scale: 2.5,
                                              ),
                                              const SizedBox(height: 5),
                                              Text(
                                                'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                                                textAlign: TextAlign.center,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headlineMedium!
                                                    .copyWith(fontSize: 10),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        flex: 3,
                                        child: Container(
                                          height: 120.0,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                healthIcon,
                                                scale: 2.5,
                                              ),
                                              const SizedBox(height: 5),
                                              Text(
                                                'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                                                textAlign: TextAlign.center,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headlineMedium!
                                                    .copyWith(fontSize: 10),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: const CustomVideoPlayer(),
                                ),
                                if (model.cartItems.isNotEmpty)
                                  const SizedBox(height: 100)
                              ],
                            ),
                          ),
                        ],
                      ),
                      if (model.cartItems.isNotEmpty ||
                          model.dealItems.isNotEmpty)
                        Positioned(
                          bottom: 0.h,
                          child: const BottomWidget(),
                        )
                    ],
                  ),
                ),
        );
      },
    );
  }
}

class BottomWidget extends StatelessWidget {
  const BottomWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<MainController>(
      builder: (model) {
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
                offset: const Offset(0, 3), // changes position of shadow
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
                                  borderRadius: BorderRadius.circular(
                                    50,
                                  ),
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
                              "\$ ${model.summry.value.netAmount}",
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                  .copyWith(
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
                        textStyle: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                              color: model.configuration.secondaryColor,
                            ),
                        onTap: () {
                          model.gotoCart();
                        },
                      ),
                    ),
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
