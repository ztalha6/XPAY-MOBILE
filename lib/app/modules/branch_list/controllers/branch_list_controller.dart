import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:map_location_picker/map_location_picker.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:serveeasy_app/app/data/enum/order_types.dart';
import 'package:serveeasy_app/app/data/models/addresses/all_addresses_response_model.dart';
import 'package:serveeasy_app/app/data/models/base_repository_model.dart';
import 'package:serveeasy_app/app/data/models/branches/branches_response.dart';
import 'package:serveeasy_app/app/data/repositories/eshtablishment_repository.dart';
import 'package:serveeasy_app/app/data/services/dialog_service.dart';
import 'package:serveeasy_app/app/data/services/location_service.dart';
import 'package:serveeasy_app/app/data/services/user_manager.dart';
import 'package:serveeasy_app/app/modules/location/views/location_view.dart';
import 'package:serveeasy_app/app/routes/app_pages.dart';
import 'package:serveeasy_app/core/constants/configuration.dart';

class BranchListController extends GetxController {
  Configuration configs = Configuration();
  final UserManager _userManager = UserManager();
  Rxn<GeocodingResult> locationDetails = Rxn<GeocodingResult>();
  RxBool isLoading = false.obs;
  RxBool isNavigating = false.obs;
  RxBool isLoadingBranches = false.obs;
  bool get noLocation => locationDetails.value == null;
  RxList<OrderType> orderTypes = RxList<OrderType>(OrderType.orderTypes);
  RxList<Branch> branches = RxList<Branch>([]);
  Rx<int> selectedOrderTypeIndex = Rx<int>(0);
  Rx<int> page = Rx<int>(1);
  RefreshController refreshController = RefreshController();

  @override
  Future<void> onInit() async {
    isLoading(true);
    await setLocation();
    await setChip();
    isLoading(false);
    await getBranches(
      lat: locationDetails.value!.geometry.location.lat,
      lng: locationDetails.value!.geometry.location.lng,
      withClear: true,
    );

    super.onInit();
  }

  Future<void> setLocation() async {
    final RepositoryResponse<Address> savedAddress =
        await _userManager.hasAnySavedAddress();
    if (!savedAddress.isSuccess) {
      if (!await LocationService().hasLocationPermission() ||
          savedAddress.data == null) {
        final dynamic cordinate = await Get.toNamed(Routes.ASK_LOCATION);
        if (cordinate == null) return;
        locationDetails(cordinate);
        await _userManager.update(
          addressDetail: Address(
            address: locationDetails.value!.formattedAddress,
            lat: locationDetails.value!.geometry.location.lat,
            lng: locationDetails.value!.geometry.location.lng,
          ),
        );
        return;
      }
    }
    locationDetails.value = GeocodingResult(
      geometry: Geometry(
        location: Location(
          lat: savedAddress.data!.lat!,
          lng: savedAddress.data!.lng!,
        ),
      ),
      placeId: "",
      formattedAddress: savedAddress.data!.address,
    );
  }

  Future<void> setChip() async {
    final OrderType selectedOrerType = OrderType.getOrderTypeFromValue(
      (await _userManager.getUser())!.orderType!,
    );
    selectedOrderTypeIndex.value = orderTypes
        .firstWhere((element) => element.value == selectedOrerType.value)
        .index;
  }

  Future<void> onRefresh() async {
    page(1);
    isLoadingBranches(true);
    await getBranches(
      lat: locationDetails.value!.geometry.location.lat,
      lng: locationDetails.value!.geometry.location.lng,
      withClear: true,
    );
    isLoadingBranches(false);
    refreshController.refreshCompleted();
  }

  Future<void> onLoading() async {
    page.value++;
    await getBranches(
      lat: locationDetails.value!.geometry.location.lat,
      lng: locationDetails.value!.geometry.location.lng,
    );
    refreshController.loadComplete();
  }

  void getLocationFromMap() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final dynamic res = await Get.toNamed(
        Routes.LOCATION,
        arguments: LocationViewParams(
          initialPosition: LatLng(
            locationDetails.value!.geometry.location.lat,
            locationDetails.value!.geometry.location.lng,
          ),
        ),
      );
      if (res != null) {
        locationDetails.value = res;
        await getBranches(
          lat: locationDetails.value!.geometry.location.lat,
          lng: locationDetails.value!.geometry.location.lng,
          withClear: true,
        );
      }
    });
  }

  Future<void> getBranches({
    required double lat,
    required double lng,
    bool withClear = false,
  }) async {
    if (withClear) isLoadingBranches(true);
    final List<Branch> data = await EshtablishmentRepository().getBranches(
      page.value,
      lat,
      lng,
      orderTypes[selectedOrderTypeIndex.value].value,
    );
    if (data.isEmpty) page.value--;
    if (withClear) branches.clear();
    branches.addAll(data);
    if (withClear) isLoadingBranches(false);
  }

  Future<void> changeOrderType(int index) async {
    selectedOrderTypeIndex(index);
    await _userManager.update(orderType: orderTypes[index].value);
    await getBranches(
      lat: locationDetails.value!.geometry.location.lat,
      lng: locationDetails.value!.geometry.location.lng,
      withClear: true,
    );
  }

  Future<void> onBranchTap(int index) async {
    isNavigating(true);
    if (await _userManager.isNotAccessingSameBranch(branches[index].id!)) {
      final bool? confirmClear = await DialogService().showConfirmationDialog(
        title: 'Warning',
        description:
            'Are you sure you want to switch branch? Your saved cart will be cleared!',
      );
      if (!confirmClear!) {
        isNavigating(false);
        return;
      }
      await _userManager.clearLocalCart();
    }
    await EshtablishmentRepository().updateEshtablishent(branches[index].id!);
    await _userManager.update(
      selectedBranchId: branches[index].id,
      branchName: branches[index].name,
      addressDetail: Address(
        address: locationDetails.value!.formattedAddress,
        lat: locationDetails.value!.geometry.location.lat,
        lng: locationDetails.value!.geometry.location.lng,
      ),
    );
    Get.offAllNamed(Routes.DRAWER);
    isNavigating(false);
  }
}
