import 'package:dio/dio.dart';
import 'package:serveeasy_app/app/data/models/addresses/create_address_request.dart';
import 'package:serveeasy_app/app/data/models/addresses/update_address_request.dart';
import 'package:serveeasy_app/app/data/services/dio_service/dio_builder.dart';
import 'package:serveeasy_app/core/constants/api_constants.dart';

class UserApiService {
  Future<dynamic> getSavedAddresses() async {
    final DioBuilderResponse dioBuilderResponse =
        await DioBuilder().buildNonCachedDio(hasAuth: true);
    final Response response = await dioBuilderResponse.dio.get(
      getUserAddress,
      options: dioBuilderResponse.dioOptions,
    );
    return response;
  }

  Future<dynamic> getSingleAddress(int addressId) async {
    final DioBuilderResponse dioBuilderResponse =
        await DioBuilder().buildNonCachedDio(hasAuth: true);
    final Response response = await dioBuilderResponse.dio.get(
      "$getUserAddress/$addressId",
      options: dioBuilderResponse.dioOptions,
    );
    return response;
  }

  Future<dynamic> createNewAddress(CreateAddressRequest request) async {
    final DioBuilderResponse dioBuilderResponse =
        await DioBuilder().buildNonCachedDio(hasAuth: true);
    final Response response = await dioBuilderResponse.dio.post(
      postCreateUserAddress,
      options: dioBuilderResponse.dioOptions,
      data: request.toJson(),
    );
    return response;
  }

  Future<dynamic> updateAddress(
    UpdateAddressRequest request, {
    int? addressId,
  }) async {
    final DioBuilderResponse dioBuilderResponse =
        await DioBuilder().buildNonCachedDio(hasAuth: true);
    final Response response = await dioBuilderResponse.dio.put(
      "$postUpdateUserAddress/$addressId",
      options: dioBuilderResponse.dioOptions,
      data: request.toJson(),
    );

    return response;
  }

  Future<dynamic> verifyOtp(String otp, int addreddId) async {
    final DioBuilderResponse dioBuilderResponse =
        await DioBuilder().buildNonCachedDio(hasAuth: true);
    final Response response = await dioBuilderResponse.dio.post(
      verifyAddressApiConstant,
      options: dioBuilderResponse.dioOptions,
      data: {
        "code": otp,
        "user_address_id": addreddId,
      },
    );
    return response;
  }
}
