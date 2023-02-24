import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:map_location_picker/map_location_picker.dart';
import 'package:serveeasy_app/app/data/services/location_service.dart';
import 'package:serveeasy_app/app/routes/app_pages.dart';
import 'package:serveeasy_app/core/constants/configuration.dart';

class AskLocationController extends GetxController with WidgetsBindingObserver {
  Configuration configuration = Configuration();
  RxBool isLoading = false.obs;
  RxBool hasDevicePermission = true.obs;

  @override
  Future<void> onInit() async {
    WidgetsBinding.instance.addObserver(this);
    hasDevicePermission(
      !await LocationService().hasLocationPermissionDeniedForever(),
    );
    super.onInit();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        hasDevicePermission(
          !await LocationService().hasLocationPermissionDeniedForever(),
        );
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        break;
    }
  }

  Future<void> onDeviceLocationTap() async {
    final GeocodingResult? cordinates =
        await LocationService().getGeocodingFromCurrentLocation();
    if (cordinates == null) return;
    Get.back(result: cordinates);
  }

  Future<void> onManualLocationTap() async {
    final dynamic res = await Get.toNamed(Routes.LOCATION);
    if (res != null) Get.back(result: res);
  }
}
