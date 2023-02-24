import 'package:get/get.dart';

import '../controllers/branch_list_controller.dart';

class BranchListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BranchListController>(
      () => BranchListController(),
    );
  }
}
