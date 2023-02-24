import 'package:get/get.dart';
import 'package:serveeasy_app/app/data/services/user_manager.dart';
import 'package:serveeasy_app/app/modules/order/order_detail/views/order_detail_view.dart';
import 'package:serveeasy_app/app/routes/app_pages.dart';

class OrderSuccessController extends GetxController {
  RxInt lastOrderId = 0.obs;
  @override
  Future<void> onInit() async {
    lastOrderId.value = (await UserManager().getUser())!.lastOrderId!;
    super.onInit();
  }

  void trackOrder() {
    Get.offAndToNamed(
      Routes.ORDER_DETAIL,
      arguments: OrderDetailViewParams(lastOrderId.value),
    );
  }
}
