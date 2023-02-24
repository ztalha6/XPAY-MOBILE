import 'package:get/get.dart';
import 'package:serveeasy_app/core/constants/configuration.dart';

class SettingsController extends GetxController {
  Configuration configuration = Configuration();
  RxInt selectedLang = RxInt(0);
  RxBool isLoading = false.obs;

  void setLang(int i) {
    selectedLang(i);
  }
}
