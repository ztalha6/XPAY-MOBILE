import 'package:get/get.dart';
import 'package:serveeasy_app/app/data/enum/order_statuses.dart';
import 'package:serveeasy_app/app/data/models/order/order_history_response_model.dart';
import 'package:serveeasy_app/app/data/models/order/transaction_history_response_model.dart';
import 'package:serveeasy_app/app/data/repositories/order_repository.dart';
import 'package:serveeasy_app/app/modules/order/order_detail/views/order_detail_view.dart';
import 'package:serveeasy_app/core/constants/configuration.dart';

class OrderDetailController extends GetxController {
  Configuration configs = Configuration();
  OrderDetailViewParams? params;
  Rxn<Transaction> orderDetail = Rxn<Transaction>();
  RxBool isLoading = false.obs;

  OrderStatus get getOrderStatus => OrderStatus.getOrderStatusFromValue(10);

  @override
  Future<void> onInit() async {
    params = Get.arguments;
    await getOrderDetails();
    super.onInit();
  }

  Future<void> getOrderDetails() async {
    isLoading(true);
    orderDetail.value = await OrderRepository().getOrderDetail(params!.orderId);
    isLoading(false);
  }
}
