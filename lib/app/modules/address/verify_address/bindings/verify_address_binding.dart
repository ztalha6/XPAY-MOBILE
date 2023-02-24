import 'package:get/get.dart';

import '../controllers/verify_address_controller.dart';

class VerifyAddressBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VerifyAddressController>(
      () => VerifyAddressController(),
    );
  }
}
