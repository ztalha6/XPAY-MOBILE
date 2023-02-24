import 'package:serveeasy_app/app/data/models/base_response_model.dart';
import 'package:serveeasy_app/app/data/models/branches/branches_request_model.dart';
import 'package:serveeasy_app/app/data/models/branches/branches_response.dart';
import 'package:serveeasy_app/app/data/models/eshtablishment/update_eshtablishment.dart';
import 'package:serveeasy_app/app/data/services/api_service/eshtablishment_service.dart';
import 'package:serveeasy_app/app/data/services/exception_handler.dart';
import 'package:serveeasy_app/app/data/services/snackbar_manager.dart';
import 'package:serveeasy_app/app/data/services/user_manager.dart';

class EshtablishmentRepository {
  Future<List<Branch>> getBranches(
    int page,
    double lat,
    double lng,
    int orderType,
  ) async {
    try {
      final ResponseModel<BranchListResponse> responseModel =
          await ResponseModel.fromApiResponse<BranchListResponse>(
        () async => await EshtablishmentApiService().getBranchesByLocation(
          BranchListRequest(
            page: page,
            latitude: lat,
            longitude: lng,
            onlineOrderType: orderType,
          ),
        ),
        (body) => BranchListResponse.fromJson(body),
      );
      if (responseModel.status == ResponseStatus.success) {
        return responseModel.response!.branches!;
      } else if (responseModel.status == ResponseStatus.responseError ||
          responseModel.status == ResponseStatus.nullResponse) {
        SnackbarManager().showAlertSnackbar(responseModel.error!);
      }
    } on Exception catch (e) {
      ExceptionHandler().handle(e);
    }
    return [];
  }

  Future<bool> updateEshtablishent(int eshblishmentId) async {
    try {
      final ResponseModel<UpdateUserEshtablishmentResponse> responseModel =
          await ResponseModel.fromApiResponse<UpdateUserEshtablishmentResponse>(
        () async => await EshtablishmentApiService()
            .updateUserEshtablishment(eshblishmentId),
        (body) => UpdateUserEshtablishmentResponse.fromJson(body),
      );
      if (responseModel.status == ResponseStatus.success) {
        await UserManager().update(
          eshtablishmentId: responseModel.response!.data!.establishmentId,
        );
        return true;
      } else if (responseModel.status == ResponseStatus.responseError ||
          responseModel.status == ResponseStatus.nullResponse) {
        SnackbarManager().showAlertSnackbar(responseModel.error!);
      }
    } on Exception catch (e) {
      ExceptionHandler().handle(e);
    }
    return false;
  }
}
