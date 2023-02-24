import 'package:get/get.dart';

import '../controllers/main_controller.dart';

class HomeSummaryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(
      () => MainController(),
    );
  }
}
