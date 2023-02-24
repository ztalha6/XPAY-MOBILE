import 'package:get/get.dart';

import '../controllers/ask_location_controller.dart';

class AskLocationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AskLocationController>(
      () => AskLocationController(),
    );
  }
}
