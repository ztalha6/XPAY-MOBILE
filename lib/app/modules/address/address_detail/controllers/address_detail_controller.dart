import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:map_location_picker/map_location_picker.dart';
import 'package:serveeasy_app/app/data/enum/address_type.dart';
import 'package:serveeasy_app/app/data/models/addresses/all_addresses_response_model.dart';
import 'package:serveeasy_app/app/data/models/base_repository_model.dart';
import 'package:serveeasy_app/app/data/models/user_model.dart';
import 'package:serveeasy_app/app/data/repositories/user_repository.dart';
import 'package:serveeasy_app/app/data/services/location_service.dart';
import 'package:serveeasy_app/app/data/services/user_manager.dart';
import 'package:serveeasy_app/app/modules/address/address_detail/views/address_detail_view.dart';
import 'package:serveeasy_app/app/modules/address/verify_address/views/verify_address_view.dart';
import 'package:serveeasy_app/app/modules/location/views/location_view.dart';
import 'package:serveeasy_app/app/routes/app_pages.dart';
import 'package:serveeasy_app/core/constants/configuration.dart';

class AddressDetailController extends GetxController {
  final UserRepository userRepository = UserRepository();
  final UserManager userManager = UserManager();

  TextEditingController streetController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController instructionsController = TextEditingController();
  RxnString addressErrorText = RxnString();
  RxnString streetErrorText = RxnString();
  RxnString nameErrorText = RxnString();
  RxnString phoneErrorText = RxnString();

  RxInt currentAddressStep = 0.obs;

  Configuration config = Configuration();
  Completer<GoogleMapController> controller = Completer();

  RxBool isLoading = false.obs;
  RxBool isLoadingLocation = false.obs;
  RxList<AddressType> addresses = RxList<AddressType>(AddressType.addresses);
  RxInt selectedAddress = 0.obs;
  Rxn<GeocodingResult> locationDetails = Rxn<GeocodingResult>();
  AddressDetailViewParams? params;
  Address? address;
  int newAddresId = -1;

  @override
  Future<void> onInit() async {
    params = Get.arguments ?? AddressDetailViewParams();
    setData();
    super.onInit();
  }

  Future<void> setData() async {
    User? user = await userManager.getUser();
    nameController.text = user!.fullName!;
    phoneController.text = user.phone!;
    if (!params!.isEditMode) {
      setLocation();
      return;
    }
    await setAddressFromAPI();
    currentAddressStep(1);
  }

  Future<void> setAddressFromAPI() async {
    isLoadingLocation(true);
    address = await userRepository.getSingleUserAddress(params!.addressId!);
    if (address != null) {
      addressController.text = address!.address!;
      streetController.text = address!.landmark!;
      selectedAddress(
        addresses.firstWhere((ad) => ad.value == address!.addressType!).index,
      );
      locationDetails.value =
          userRepository.getLocationFromAddressModel(address!);
    }
    isLoadingLocation(false);
  }

  Future<void> setLocation() async {
    isLoadingLocation(true);
    locationDetails(
      await LocationService().getGeocodingFromCurrentLocation() ??
          await getAddressFromLocalDB(),
    );
    addressController.text = locationDetails.value!.formattedAddress!;
    isLoadingLocation(false);
  }

  Future<GeocodingResult?> getAddressFromLocalDB() async {
    final RepositoryResponse<Address> savedAddress =
        await UserManager().hasAnySavedAddress();
    if (savedAddress.isSuccess) {
      return GeocodingResult(
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
    return null;
  }

  void changeAddressType(int index) {
    selectedAddress(index);
  }

  Future<void> saveChanges() async {
    final bool valid = validateFields();
    if (!valid) return;

    isLoading(true);
    if (!await UserRepository().updateUserAddress(
      address: addressController.text,
      addressType: addresses[selectedAddress.value],
      landmark: streetController.text,
      location: locationDetails.value!.geometry.location,
      addressId: params!.isEditMode ? address!.id! : newAddresId,
    )) {
      isLoading(false);
      return;
    }

    if (params!.isEditMode) {
      Get.back(result: true);
      return;
    }

    if (params!.fromCartView) {
      Get.offAndToNamed(Routes.CHECKOUT);
      return;
    }

    Get.back();
    isLoading(false);
  }

  Future<void> getLocationFromMap() async {
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
        addressController.text = locationDetails.value!.formattedAddress!;
        await moveCamera();
      }
    });
  }

  Future<void> moveCamera() async {
    final GoogleMapController mapcontroller = await controller.future;
    mapcontroller.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(
            locationDetails.value!.geometry.location.lat,
            locationDetails.value!.geometry.location.lng,
          ),
          zoom: 15,
        ),
      ),
    );
  }

  bool validateFields() {
    addressErrorText.value = null;
    streetErrorText.value = null;
    if (addressController.text.isEmpty) {
      addressErrorText.value = "Field cannot be empty";
    }
    if (streetController.text.isEmpty) {
      streetErrorText.value = "Field cannot be empty";
    }
    return addressController.text.isNotEmpty &&
        streetController.text.isNotEmpty;
  }

  Future<void> onNextTap() async {
    final RepositoryResponse<Address?> res =
        await UserRepository().createUserAddress(
      name: nameController.text,
      phone: phoneController.text,
    );
    if (!res.isSuccess) return;
    if (res.data!.isAddressVerified) {
      currentAddressStep(1);
      newAddresId = res.data!.id!;
      return;
    }
    newAddresId = res.data!.id!;

    final dynamic addressVarified = await Get.toNamed(
      Routes.VERIFY_ADDRESS,
      arguments: VerifyAddressViewParams(
        forAddressVerification: true,
        newAddressId: newAddresId,
      ),
    );

    if (addressVarified != null && addressVarified) {
      currentAddressStep(1);
    }
  }
}
