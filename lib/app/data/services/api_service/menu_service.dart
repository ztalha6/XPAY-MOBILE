import 'package:dio/dio.dart';
import 'package:serveeasy_app/app/data/services/dio_service/dio_builder.dart';
import 'package:serveeasy_app/core/constants/api_constants.dart';

class MenuApiService {
  Future<dynamic> getMainTabbar(int establishmentId, int orderType) async {
    final DioBuilderResponse dioBuilderResponse =
        await DioBuilder().buildNonCachedDio(hasAuth: true);
    final Response response = await dioBuilderResponse.dio.get(
      // "$mainMenuTabs?establishment_id=$establishmentId&order_type=$orderType",
      "$mainMenuTabs?establishment_id=$establishmentId",
      options: dioBuilderResponse.dioOptions,
    );
    return response;
  }

  Future<dynamic> getMenuData(int ordertype, int establishmentId) async {
    final DioBuilderResponse dioBuilderResponse =
        await DioBuilder().buildNonCachedDio(hasAuth: true);
    final Response response = await dioBuilderResponse.dio.get(
      "$menuData?order_type=$ordertype&menu=true&establishment_id=$establishmentId",
      options: dioBuilderResponse.dioOptions,
    );
    return response;
  }
}
