import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:serveeasy_app/app/data/models/order/dispute_list_response_model.dart';
import 'package:serveeasy_app/app/data/models/order/transaction_history_response_model.dart';
import 'package:serveeasy_app/app/data/repositories/order_repository.dart';
import 'package:serveeasy_app/app/modules/order/order_detail/views/order_detail_view.dart';
import 'package:serveeasy_app/app/routes/app_pages.dart';
import 'package:serveeasy_app/core/constants/configuration.dart';

class DisputesController extends GetxController
    with GetTickerProviderStateMixin {
  Configuration configs = Configuration();

  RxBool isLoadingOrderHistory = false.obs;
  RxBool isLoadingActiveOrders = false.obs;

  TabController? tabController;

  RxList<Dispute> ordersHistoryList = RxList<Dispute>([]);
  RxList<Dispute> activeOrdersList = RxList<Dispute>([]);

  RefreshController activeOrderRefreshController = RefreshController();
  RefreshController orderHistoryRefreshController = RefreshController();

  Rx<int> orderHistoryPage = Rx<int>(1);
  Rx<int> activeOrderPage = Rx<int>(1);

  @override
  Future<void> onInit() async {
    tabController = TabController(vsync: this, length: 2);
    getOrderHistory(withClear: true);
    getActiveOrders(withClear: true);
    super.onInit();
  }

  Future<void> getOrderHistory({
    bool withClear = false,
  }) async {
    if (withClear) isLoadingOrderHistory(true);
    final List<Dispute> data =
        await OrderRepository().getDisputes(orderHistoryPage.value);
    if (data.isEmpty) orderHistoryPage.value--;
    if (withClear) ordersHistoryList.clear();
    ordersHistoryList.addAll(data);
    if (withClear) isLoadingOrderHistory(false);
  }

  Future<void> getActiveOrders({
    bool withClear = false,
  }) async {
    if (withClear) isLoadingActiveOrders(true);
    final List<Dispute> data =
        await OrderRepository().getDisputes(activeOrderPage.value);
    if (data.isEmpty) activeOrderPage.value--;
    if (withClear) activeOrdersList.clear();
    activeOrdersList.addAll(data);
    if (withClear) isLoadingActiveOrders(false);
  }

  Future<void> onRefreshOrderHistory() async {
    orderHistoryPage(1);
    isLoadingOrderHistory(true);
    await getOrderHistory(withClear: true);
    isLoadingOrderHistory(false);
    orderHistoryRefreshController.refreshCompleted();
  }

  Future<void> onRefreshActiveOrder() async {
    activeOrderPage(1);
    isLoadingActiveOrders(true);
    await getActiveOrders(withClear: true);
    isLoadingActiveOrders(false);
    activeOrderRefreshController.refreshCompleted();
  }

  Future<void> onLoadingOrderHistory() async {
    orderHistoryPage.value++;
    await getOrderHistory();
    orderHistoryRefreshController.loadComplete();
  }

  Future<void> onLoadingActiveOrder() async {
    activeOrderPage.value++;
    await getActiveOrders();
    activeOrderRefreshController.loadComplete();
  }

  void gotoOrderDetails(int index, {bool isActiveOrder = false}) {
    if (isActiveOrder) {
      Get.toNamed(
        Routes.ORDER_DETAIL,
        arguments: OrderDetailViewParams(activeOrdersList[index].id!),
      );
      return;
    }
    Get.toNamed(
      Routes.ORDER_DETAIL,
      arguments: OrderDetailViewParams(ordersHistoryList[index].id!),
    );
  }
}
