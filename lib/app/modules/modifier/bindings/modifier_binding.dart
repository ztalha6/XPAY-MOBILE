import 'package:get/get.dart';

import '../controllers/modifier_controller.dart';

class ModifierBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ModifierController>(
      () => ModifierController(),
    );
  }
}
