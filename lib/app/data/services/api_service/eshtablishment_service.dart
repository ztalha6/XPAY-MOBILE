import 'package:dio/dio.dart';
import 'package:serveeasy_app/app/data/models/branches/branches_request_model.dart';
import 'package:serveeasy_app/app/data/services/dio_service/dio_builder.dart';
import 'package:serveeasy_app/core/constants/api_constants.dart';

class EshtablishmentApiService {
  Future<dynamic> getBranchesByLocation(BranchListRequest requestModel) async {
    final DioBuilderResponse dioBuilderResponse =
        await DioBuilder().buildNonCachedDio(hasAuth: true);
    final Response response = await dioBuilderResponse.dio.get(
      "$getEshtablishmentApiConstant?page=${requestModel.page}&per-page=10&latitude=${requestModel.latitude}&longitude=${requestModel.longitude}&pagination=false&online_order_type=${requestModel.onlineOrderType}",
      options: dioBuilderResponse.dioOptions,
    );
    return response;
  }

  Future<dynamic> updateUserEshtablishment(int eshtablishmentId) async {
    final DioBuilderResponse dioBuilderResponse =
        await DioBuilder().buildNonCachedDio(hasAuth: true);
    final Response response = await dioBuilderResponse.dio.post(
      updateUserEshtablishent,
      options: dioBuilderResponse.dioOptions,
      data: {"establishment_id": eshtablishmentId},
    );
    return response;
  }
}
