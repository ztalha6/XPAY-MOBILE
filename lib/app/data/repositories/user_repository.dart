import 'package:map_location_picker/map_location_picker.dart';
import 'package:serveeasy_app/app/data/enum/address_type.dart';
import 'package:serveeasy_app/app/data/models/addresses/all_addresses_response_model.dart';
import 'package:serveeasy_app/app/data/models/addresses/update_address_request.dart';
import 'package:serveeasy_app/app/data/models/addresses/create_address_request.dart';
import 'package:serveeasy_app/app/data/models/addresses/get_single_address_response.dart';
import 'package:serveeasy_app/app/data/models/base_repository_model.dart';
import 'package:serveeasy_app/app/data/models/base_response_model.dart';
import 'package:serveeasy_app/app/data/models/user_model.dart';
import 'package:serveeasy_app/app/data/services/api_service/user_service.dart';
import 'package:serveeasy_app/app/data/services/exception_handler.dart';
import 'package:serveeasy_app/app/data/services/location_service.dart';
import 'package:serveeasy_app/app/data/services/snackbar_manager.dart';
import 'package:serveeasy_app/app/data/services/token_manager.dart';
import 'package:serveeasy_app/app/data/services/user_manager.dart';
import 'package:serveeasy_app/core/utils/utils.dart';

class UserRepository {
  Future<List<Address>> getUserAddresses() async {
    try {
      final ResponseModel<AllAddressesResponse> responseModel =
          await ResponseModel.fromApiResponse<AllAddressesResponse>(
        () async => await UserApiService().getSavedAddresses(),
        (body) => AllAddressesResponse.fromJson(body),
      );
      if (responseModel.status == ResponseStatus.success) {
        return responseModel.response!.data!.addresses!;
      } else if (responseModel.status == ResponseStatus.responseError ||
          responseModel.status == ResponseStatus.nullResponse) {
        SnackbarManager().showAlertSnackbar(responseModel.error!);
      }
    } on Exception catch (e) {
      ExceptionHandler().handle(e);
    }
    return [];
  }

  Future<Address?> getSingleUserAddress(int addressId) async {
    try {
      final ResponseModel<GetSingleAddressResponse> responseModel =
          await ResponseModel.fromApiResponse<GetSingleAddressResponse>(
        () async => await UserApiService().getSingleAddress(addressId),
        (body) => GetSingleAddressResponse.fromJson(body),
      );
      if (responseModel.status == ResponseStatus.success) {
        return responseModel.response!.address!;
      } else if (responseModel.status == ResponseStatus.responseError ||
          responseModel.status == ResponseStatus.nullResponse) {
        SnackbarManager().showAlertSnackbar(responseModel.error!);
      }
    } on Exception catch (e) {
      ExceptionHandler().handle(e);
    }
    return null;
  }

  Future<RepositoryResponse<Address?>> createUserAddress({
    required String name,
    required String phone,
  }) async {
    try {
      final ResponseModel<GetSingleAddressResponse> responseModel =
          await ResponseModel.fromApiResponse<GetSingleAddressResponse>(
        () async => await UserApiService()
            .createNewAddress(CreateAddressRequest(name: "name", phone: phone)),
        (body) => GetSingleAddressResponse.fromJson(body),
      );
      if (responseModel.status == ResponseStatus.success) {
        return RepositoryResponse(
          isSuccess: true,
          data: responseModel.response!.address,
        );
      } else if (responseModel.status == ResponseStatus.responseError ||
          responseModel.status == ResponseStatus.nullResponse) {
        SnackbarManager().showAlertSnackbar(responseModel.error!);
      }
    } on Exception catch (e) {
      ExceptionHandler().handle(e);
    }
    return RepositoryResponse(isSuccess: false);
  }

  Future<bool> updateUserAddress({
    required String address,
    required String landmark,
    required AddressType addressType,
    required Location location,
    required int addressId,
  }) async {
    // try {
    //   final List<String> cityState =
    //       await LocationService().getCityStatefromLocation(location: location);
    //   if (cityState.isEmpty) return false;
    //   final ResponseModel<GetSingleAddressResponse> responseModel =
    //       await ResponseModel.fromApiResponse<GetSingleAddressResponse>(
    //     () async => await UserApiService().updateAddress(
    //       UpdateAddressRequest(
    //         address: address,
    //         landmark: landmark,
    //         city: cityState[0],
    //         state: cityState[1],
    //         zipCode: 3424,
    //         addressType: addressType.value,
    //         lat: location.lat,
    //         lng: location.lng,
    //       ),
    //       addressId: addressId,
    //     ),
    //     (body) => GetSingleAddressResponse.fromJson(body),
    //   );
    //   if (responseModel.status == ResponseStatus.success) {
    //     await UserManager()
    //         .update(addressDetail: responseModel.response!.address);
    //     return true;
    //   } else if (responseModel.status == ResponseStatus.responseError ||
    //       responseModel.status == ResponseStatus.nullResponse) {
    //     SnackbarManager().showAlertSnackbar(responseModel.error!);
    //   }
    // } on Exception catch (e) {
    //   ExceptionHandler().handle(e);
    // }
    return false;
  }

  Future<bool> verifyAddressOtp(int addressId, String otp) async {
    // try {
    //   final ResponseModel<GetSingleAddressResponse> responseModel =
    //       await ResponseModel.fromApiResponse<GetSingleAddressResponse>(
    //     () async => await UserApiService().verifyOtp(otp, addressId),
    //     (body) => GetSingleAddressResponse.fromJson(body),
    //   );
    //   if (responseModel.status == ResponseStatus.success) {
    //     await UserManager()
    //         .update(addressDetail: responseModel.response!.address);
    //     return responseModel.response!.status!;
    //   } else if (responseModel.status == ResponseStatus.responseError ||
    //       responseModel.status == ResponseStatus.nullResponse) {
    //     SnackbarManager().showAlertSnackbar(responseModel.error!);
    //   }
    // } on Exception catch (e) {
    //   ExceptionHandler().handle(e);
    // }
    return false;
  }

  Future<bool> setCurrentLocationAsAddress() async {
    // final GeocodingResult? currentLocation =
    //     await LocationService().getGeocodingFromCurrentLocation();
    // if (currentLocation == null) return false;
    // await UserManager().update(
    //   addressDetail: Address(
    //     address: currentLocation.formattedAddress,
    //     lat: currentLocation.geometry.location.lat,
    //     lng: currentLocation.geometry.location.lng,
    //   ),
    // );
    return true;
  }

  GeocodingResult? getLocationFromAddressModel(Address address) {
    try {
      return GeocodingResult(
        geometry: Geometry(
          location: Location(lat: address.lat!, lng: address.lng!),
        ),
        placeId: "",
        formattedAddress: address.address,
      );
    } on Exception catch (e) {
      SnackbarManager().showAlertSnackbar(e.toString());
    }
    return null;
  }

  Future<void> logout() async {
    await TokenManager().clearToken();
  }
}
