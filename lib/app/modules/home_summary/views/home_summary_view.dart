import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import 'package:get/get.dart';
import 'package:serveeasy_app/app/data/widgets/cached_image_widget.dart';
import 'package:serveeasy_app/app/data/widgets/custom_slider.dart';
import 'package:serveeasy_app/app/data/widgets/custom_video_player.dart';
import 'package:serveeasy_app/app/data/widgets/grid_view_delegate.dart';
import 'package:serveeasy_app/app/data/widgets/loading_widget.dart';
import 'package:serveeasy_app/app/data/widgets/pagination_list_widget.dart';
import 'package:serveeasy_app/app/data/widgets/primary_button.dart';
import 'package:serveeasy_app/app/data/widgets/shimmers.dart';
import 'package:serveeasy_app/app/modules/home_summary/controllers/main_controller.dart';
import 'package:serveeasy_app/app/modules/order/order_history/controllers/order_history_controller.dart';
import 'package:serveeasy_app/app/modules/order/order_history/views/order_history_item.dart';
import 'package:serveeasy_app/app/routes/app_pages.dart';
import 'package:serveeasy_app/core/constants/asset_constants.dart';
import 'package:sizer/sizer.dart';

class HomeSummaryView extends GetView<MainController> {
  const HomeSummaryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(MainController());
    OrderHistoryController orderDetail = Get.put(OrderHistoryController());

    return GetX<MainController>(
      builder: (model) {
        return Scaffold(
            appBar: AppBar(
              title: Image.asset(
                model.configuration.logoWithName,
                scale: 4,
              ),
              toolbarHeight: 70,
              centerTitle: true,
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
              bottom: PreferredSize(
                preferredSize: const Size(0, 50),
                child: Row(
                  children: [
                    TabBar(
                      isScrollable: true,
                      controller: orderDetail.tabController,
                      indicatorPadding:
                          const EdgeInsets.symmetric(horizontal: 16.0),
                      indicatorColor: orderDetail.configs.secondaryColor,
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.grey,
                      indicatorWeight: 2.5,
                      labelStyle: Theme.of(context).textTheme.displayLarge,
                      unselectedLabelStyle:
                          Theme.of(context).textTheme.headlineMedium,
                      tabs: const [
                        Tab(text: "Active Orders"),
                        Tab(text: 'Order History'),
                      ],
                    ),
                  ],
                ),
              ),
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
                : TabBarView(
                    controller: orderDetail.tabController,
                    children: <Widget>[
                      PaginationListWidget(
                        isLoading: orderDetail.isLoadingActiveOrders.value,
                        padding: const EdgeInsets.all(16),
                        list: orderDetail.activeOrdersList,
                        controller: orderDetail.activeOrderRefreshController,
                        onRefresh: orderDetail.onRefreshActiveOrder,
                        onLoading: orderDetail.onLoadingActiveOrder,
                        listItemWidget: (index) {
                          return OrderHistoryItem(
                            onTap: () {
                              orderDetail.gotoOrderDetails(index,
                                  isActiveOrder: true);
                            },
                            order: orderDetail.activeOrdersList[index],
                            secondaryColor: orderDetail.configs.secondaryColor,
                          );
                        },
                      ),
                      PaginationListWidget(
                        isLoading: orderDetail.isLoadingOrderHistory.value,
                        padding: const EdgeInsets.all(16),
                        list: orderDetail.ordersHistoryList,
                        controller: orderDetail.orderHistoryRefreshController,
                        onRefresh: orderDetail.onRefreshOrderHistory,
                        onLoading: orderDetail.onLoadingOrderHistory,
                        listItemWidget: (index) {
                          return OrderHistoryItem(
                            onTap: () {
                              orderDetail.gotoOrderDetails(index);
                            },
                            order: orderDetail.ordersHistoryList[index],
                            secondaryColor: orderDetail.configs.secondaryColor,
                            isActiveOrder: true,
                          );
                        },
                      ),
                    ],
                  ));
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
