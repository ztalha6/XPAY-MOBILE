import 'dart:io';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:serveeasy_app/app/data/models/base_repository_model.dart';
import 'package:serveeasy_app/app/data/models/base_response_model.dart';
import 'package:serveeasy_app/app/data/models/resend_otp/resend_otp_request_model.dart';
import 'package:serveeasy_app/app/data/models/reset_password/reset_pass_request_model.dart';
import 'package:serveeasy_app/app/data/models/sign_in/sign_in_request_model.dart';
import 'package:serveeasy_app/app/data/models/sign_up/sign_in_request_model.dart';
import 'package:serveeasy_app/app/data/models/sign_up/sign_up_response_model.dart';
import 'package:serveeasy_app/app/data/models/user_model.dart';
import 'package:serveeasy_app/app/data/models/verify_otp/verify_otp_request_model.dart';
import 'package:serveeasy_app/app/data/models/verify_otp/verify_otp_response_model.dart';
import 'package:serveeasy_app/app/data/services/api_service/auth_service.dart';
import 'package:serveeasy_app/app/data/services/exception_handler.dart';
import 'package:serveeasy_app/app/data/services/notification_service.dart';
import 'package:serveeasy_app/app/data/services/snackbar_manager.dart';
import 'package:serveeasy_app/app/data/services/token_manager.dart';
import 'package:serveeasy_app/app/data/services/user_manager.dart';

class AuthRepository {
  Future<bool> signUp(
    String fullName,
    String phone,
    String email,
    String password,
  ) async {
    try {
      final ResponseModel<AccessResponse> responseModel =
          await ResponseModel.fromApiResponse<AccessResponse>(
        () async => await AuthService().signUpUser(
          SignUpRequest(
            fullName: fullName,
            phone: phone,
            email: email,
            password: password,
            passwordConfirmation: password,
            deviceToken: FCMNotificationService.fcmDeviceToken,
            deviceType: 'mobile',
            platform: Platform.isIOS ? "ios" : 'android',
          ),
        ),
        (body) => AccessResponse.fromJson(body),
      );
      if (responseModel.status == ResponseStatus.success) {
        await TokenManager()
            .setToken(responseModel.response!.data!.accessToken!.token!);
        await UserManager().saveUser(responseModel.response!.data!.user!);
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

  // Future<bool> changePassword(String oldPassword, String password) async {
  //   try {
  //     int? userId = (await UserManager().getUser())!.id!;
  //     ResponseModel<ChangePasswordResponse> responseModel =
  //         await ResponseModel.fromApiResponse<ChangePasswordResponse>(
  //       () async => await AuthService().changePassword(
  //         ChangePasswordRequest(
  //           id: userId,
  //           oldpassword: oldPassword,
  //           password: password,
  //         ),
  //       ),
  //       (body) => ChangePasswordResponse.fromJson(body),
  //     );
  //     if (responseModel.status == ResponseStatus.SUCCESS) {
  //       return true;
  //     } else if (responseModel.status == ResponseStatus.RESPONSE_ERROR ||
  //         responseModel.status == ResponseStatus.NULL_RESPONSE) {
  //       SnackbarManager().showAlertSnackbar(responseModel.error!);
  //     }
  //   } on Exception catch (e) {
  //     ExceptionHandler().handle(e);
  //   }
  //   return false;
  // }

  Future<RepositoryResponse<User>> signIn(String email, String password) async {
    try {
      final ResponseModel<AccessResponse> responseModel =
          await ResponseModel.fromApiResponse<AccessResponse>(
        () async => await AuthService().signInUser(
          AccessRequest(
            email: email,
            password: password,
            deviceToken: FCMNotificationService.fcmDeviceToken,
            deviceType: 'mobile',
            platform: Platform.isIOS ? "ios" : 'android',
          ),
        ),
        (body) => AccessResponse.fromJson(body),
      );
      if (responseModel.status == ResponseStatus.success) {
        await TokenManager()
            .setToken(responseModel.response!.data!.accessToken!.token!);
        await UserManager().saveUser(responseModel.response!.data!.user!);
        return RepositoryResponse(
          isSuccess: true,
          data: responseModel.response!.data!.user,
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

  Future<RepositoryResponse<User>> guestSignIn() async {
    try {
      final ResponseModel<AccessResponse> responseModel =
          await ResponseModel.fromApiResponse<AccessResponse>(
        () async => await AuthService().guestSignIn(),
        (body) => AccessResponse.fromJson(body),
      );
      if (responseModel.status == ResponseStatus.success) {
        await TokenManager()
            .setToken(responseModel.response!.data!.accessToken!.token!);
        await UserManager().saveUser(responseModel.response!.data!.user!);
        return RepositoryResponse(
          isSuccess: true,
          data: responseModel.response!.data!.user,
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

  Future<bool> googleSignIn(
    GoogleSignInAccount creds,
    String accessToken,
  ) async {
    try {
      final ResponseModel<AccessResponse> responseModel =
          await ResponseModel.fromApiResponse<AccessResponse>(
        () async => await AuthService().signInUser(
          AccessRequest(
            email: creds.email,
            username: creds.displayName,
            fullName: creds.displayName,
            socialPlatform: "google",
            clientId: creds.id,
            token: accessToken,
            deviceToken: FCMNotificationService.fcmDeviceToken,
            deviceType: 'mobile',
            platform: Platform.isIOS ? "ios" : 'android',
          ),
          isSocial: true,
        ),
        (body) => AccessResponse.fromJson(body),
      );
      if (responseModel.status == ResponseStatus.success) {
        await TokenManager()
            .setToken(responseModel.response!.data!.accessToken!.token!);
        await UserManager().saveUser(responseModel.response!.data!.user!);
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

  Future<bool> verifyOtp(String otp) async {
    try {
      final userEmail = (await UserManager().getUser())!.email;
      final ResponseModel<OtpRespponse> responseModel =
          await ResponseModel.fromApiResponse<OtpRespponse>(
        () async => await AuthService().verifyOtp(
          OtpRequest(otpCode: otp, email: userEmail),
        ),
        (body) => OtpRespponse.fromJson(body),
      );
      if (responseModel.status == ResponseStatus.success) {
        await UserManager().saveUser(responseModel.response!.data!.user!);
        return responseModel.response!.status!;
      } else if (responseModel.status == ResponseStatus.responseError ||
          responseModel.status == ResponseStatus.nullResponse) {
        SnackbarManager().showAlertSnackbar(responseModel.error!);
      }
    } on Exception catch (e) {
      ExceptionHandler().handle(e);
    }
    return false;
  }

  Future<bool> sendOtp(String email) async {
    try {
      final ResponseModel<BaseApiResponse> responseModel =
          await ResponseModel.fromApiResponse<BaseApiResponse>(
        () async => await AuthService().sendOtp(
          ResendOtpRequest(email: email),
        ),
        (body) => BaseApiResponse.fromJson(body),
      );
      if (responseModel.status == ResponseStatus.success) {
        return responseModel.response!.status!;
      } else if (responseModel.status == ResponseStatus.responseError ||
          responseModel.status == ResponseStatus.nullResponse) {
        SnackbarManager().showAlertSnackbar(responseModel.error!);
      }
    } on Exception catch (e) {
      ExceptionHandler().handle(e);
    }
    return false;
  }

  Future<bool> resetPassword(
    String password,
    String confirmPassword,
    String otp,
  ) async {
    try {
      final User? user = await UserManager().getUser();
      final ResponseModel<BaseApiResponse> responseModel =
          await ResponseModel.fromApiResponse<BaseApiResponse>(
        () async => await AuthService().resetPassword(
          ResetPasswordRequest(
            passwordConfirmation: confirmPassword,
            password: password,
            email: user!.email,
            otpCode: int.parse(otp),
          ),
        ),
        (body) => BaseApiResponse.fromJson(body),
      );
      if (responseModel.status == ResponseStatus.success) {
        return responseModel.response!.status!;
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
