import 'package:get/get.dart';
import 'package:serveeasy_app/app/data/services/dio_service/api_interceptor.dart';
import 'package:serveeasy_app/app/data/services/snackbar_manager.dart';
import 'package:serveeasy_app/app/routes/app_pages.dart';

class ExceptionHandler {
  void handle(Object e) {
    if (e is UnauthorizedException) {
      SnackbarManager().showAlertSnackbar(e.toString());
      Get.offAllNamed(Routes.SIGN_IN);
      return;
    }
    if (e is BadRequestException ||
        e is InternalServerErrorException ||
        e is NoInternetConnectionException ||
        e is DeadlineExceededException) {
      SnackbarManager().showAlertSnackbar(e.toString());
    }
  }
}
