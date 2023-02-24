import 'package:get/get.dart';
import 'package:serveeasy_app/app/data/enum/order_types.dart';
import 'package:serveeasy_app/app/data/services/user_manager.dart';
import 'package:serveeasy_app/app/routes/app_pages.dart';
import 'package:serveeasy_app/core/constants/configuration.dart';

class HomeController extends GetxController {
  Configuration configs = Configuration();
  RxList<OrderType> orderTypes = RxList<OrderType>(OrderType.orderTypes);

  Future<void> gotoLocation(int index) async {
    await UserManager().update(orderType: orderTypes[index].value);
    Get.toNamed(Routes.BRANCH_LIST);
  }
}
