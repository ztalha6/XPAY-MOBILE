import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import 'package:get/get.dart';
import 'package:serveeasy_app/app/data/widgets/pagination_list_widget.dart';
import 'package:serveeasy_app/app/modules/order/order_history/views/order_history_item.dart';
import 'package:serveeasy_app/core/constants/asset_constants.dart';

import '../controllers/disputes_controller.dart';

class DisputesView extends GetView<DisputesController> {
  const DisputesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(DisputesController());
    return GetX<DisputesController>(
      // dispose: (s) {
      //   Get.delete<DisputesController>();
      // },
      builder: (model) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Disputes',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            leading: InkWell(
              onTap: () => ZoomDrawer.of(context)!.toggle(),
              child: Image.asset(
                menuIcon,
                scale: 2.5,
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size(0, 50),
              child: Row(
                children: [
                  TabBar(
                    isScrollable: true,
                    controller: model.tabController,
                    indicatorPadding:
                        const EdgeInsets.symmetric(horizontal: 16.0),
                    indicatorColor: model.configs.secondaryColor,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    indicatorWeight: 2.5,
                    labelStyle: Theme.of(context).textTheme.displayLarge,
                    unselectedLabelStyle:
                        Theme.of(context).textTheme.headlineMedium,
                    tabs: const [
                      Tab(text: "Active Disputes"),
                      Tab(text: 'Closed Disputes'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          body: TabBarView(
            controller: model.tabController,
            children: <Widget>[
              PaginationListWidget(
                isLoading: model.isLoadingActiveOrders.value,
                padding: const EdgeInsets.all(16),
                list: model.activeOrdersList,
                controller: model.activeOrderRefreshController,
                onRefresh: model.onRefreshActiveOrder,
                onLoading: model.onLoadingActiveOrder,
                listItemWidget: (index) {
                  return DisputeItem(
                    onTap: () {
                      // model.gotoOrderDetails(index, isActiveOrder: true);
                    },
                    order: model.activeOrdersList[index],
                    secondaryColor: model.configs.secondaryColor,
                  );
                },
              ),
              PaginationListWidget(
                isLoading: model.isLoadingOrderHistory.value,
                padding: const EdgeInsets.all(16),
                list: model.ordersHistoryList,
                controller: model.orderHistoryRefreshController,
                onRefresh: model.onRefreshOrderHistory,
                onLoading: model.onLoadingOrderHistory,
                listItemWidget: (index) {
                  return DisputeItem(
                    onTap: () {
                      // model.gotoOrderDetails(index);
                    },
                    order: model.ordersHistoryList[index],
                    secondaryColor: model.configs.secondaryColor,
                    isActiveOrder: true,
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
