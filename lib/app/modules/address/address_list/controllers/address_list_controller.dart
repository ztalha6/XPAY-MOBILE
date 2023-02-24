import 'package:get/get.dart';
import 'package:serveeasy_app/app/data/models/addresses/all_addresses_response_model.dart';
import 'package:serveeasy_app/app/data/repositories/user_repository.dart';
import 'package:serveeasy_app/app/data/services/user_manager.dart';
import 'package:serveeasy_app/app/modules/address/address_detail/views/address_detail_view.dart';
import 'package:serveeasy_app/app/modules/address/address_list/views/address_list_view.dart';
import 'package:serveeasy_app/app/routes/app_pages.dart';
import 'package:serveeasy_app/core/constants/configuration.dart';

class AddressListController extends GetxController {
  Configuration configuration = Configuration();
  RxList<Address> addresses = RxList<Address>([]);
  RxBool isLoading = false.obs;
  RxBool isSettingLocation = false.obs;
  RxInt selectedAddress = RxInt(-1);

  @override
  Future<void> onInit() async {
    isLoading(true);
    addresses.value = await UserRepository().getUserAddresses();
    isLoading(false);
    if (addresses.isEmpty) {
      Get.offAndToNamed(
        Routes.ADDRESS_DETAIL,
        arguments: AddressDetailViewParams(fromCartView: true),
      );
      return;
    }
    selectedAddress.value = await UserManager().getSavedAddressId();
    super.onInit();
  }

  Future<void> setAddress(int? value, int index) async {
    selectedAddress.value = value!;
    await UserManager().update(addressDetail: addresses[index]);
    final AddressListViewParams params =
        Get.arguments ?? AddressListViewParams(fromCheckoutView: false);

    if (params.fromCheckoutView || params.fromHomeView) {
      Get.back(result: true);
      return;
    }
    Get.offAndToNamed(Routes.CHECKOUT);
  }

  Future<void> setCurrentLocationAsAddress() async {
    isSettingLocation(true);
    await UserRepository().setCurrentLocationAsAddress();
    Get.back(result: true);
    isSettingLocation(false);
  }

  void gotoCreateAddressView() {
    Get.offAndToNamed(Routes.ADDRESS_DETAIL);
  }

  Future<void> editAddress(int index) async {
    final dynamic res = await Get.toNamed(
      Routes.ADDRESS_DETAIL,
      arguments: AddressDetailViewParams(
        isEditMode: true,
        addressId: addresses[index].id,
      ),
    );
    if (res != null && res) {
      Get.back(result: true);
    }
  }
}
