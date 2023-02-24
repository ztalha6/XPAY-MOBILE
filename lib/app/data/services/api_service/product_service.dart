import 'package:dio/dio.dart';
import 'package:serveeasy_app/app/data/models/order/cart_sumamry_request_model.dart';
import 'package:serveeasy_app/app/data/services/dio_service/dio_builder.dart';
import 'package:serveeasy_app/core/constants/api_constants.dart';

class ProductApiService {
  Future<dynamic> getProductModifiers(int productId) async {
    final DioBuilderResponse dioBuilderResponse =
        await DioBuilder().buildNonCachedDio(hasAuth: true);
    final Response response = await dioBuilderResponse.dio.get(
      "$getModifiers$productId",
      options: dioBuilderResponse.dioOptions,
    );
    return response;
  }

  Future<dynamic> getDealModifiers(int dealId) async {
    final DioBuilderResponse dioBuilderResponse =
        await DioBuilder().buildNonCachedDio(hasAuth: true);
    final Response response = await dioBuilderResponse.dio.get(
      "$getDealModifiersApiConst/$dealId",
      options: dioBuilderResponse.dioOptions,
    );
    return response;
  }

  Future<dynamic> getCartSummary(CartSummaryRequest request) async {
    final DioBuilderResponse dioBuilderResponse =
        await DioBuilder().buildNonCachedDio(hasAuth: true);
    final Response response = await dioBuilderResponse.dio.post(
      cartSummary,
      options: dioBuilderResponse.dioOptions,
      data: request.toJson(),
    );
    return response;
  }

  Future<dynamic> searchProduct({
    required int page,
    required int customMenuId,
    required String text,
  }) async {
    final DioBuilderResponse dioBuilderResponse =
        await DioBuilder().buildNonCachedDio(hasAuth: true);
    final Response response = await dioBuilderResponse.dio.get(
      "$searchProductApiConstant&page=$page&custom_menu_id=$customMenuId&product_name=$text",
      options: dioBuilderResponse.dioOptions,
    );
    return response;
  }
}
