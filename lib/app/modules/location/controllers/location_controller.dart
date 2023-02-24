import 'package:get/get.dart';
import 'package:map_location_picker/map_location_picker.dart';
import 'package:serveeasy_app/app/modules/location/views/location_view.dart';
import 'package:serveeasy_app/core/constants/configuration.dart';

class LocationController extends GetxController {
  RxString mapKey = RxString(Configuration().mapKey);
  Rx<Location> location =
      Rx<Location>(Location(lat: 29.121599, lng: 76.396698));
  RxBool isLoading = false.obs;
  LocationViewParams? params;

  @override
  Future<void> onInit() async {
    isLoading(true);
    params = Get.arguments;

    if (params != null) {
      location.value = Location(
        lat: params!.initialPosition.latitude,
        lng: params!.initialPosition.longitude,
      );
    }
    isLoading(false);
    super.onInit();
  }
}
