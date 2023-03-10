import 'package:dio/dio.dart';
import 'package:payment_card_validation/payment_card.dart';
import 'package:serveeasy_app/app/data/enum/order_types.dart';
import 'package:serveeasy_app/app/data/enum/payment_types.dart';
import 'package:serveeasy_app/app/data/models/base_response_model.dart';
import 'package:serveeasy_app/app/data/models/order/cart_sumamry_request_model.dart';
import 'package:serveeasy_app/app/data/models/order/create_order_request_model.dart';
import 'package:serveeasy_app/app/data/models/order/create_order_response_model.dart';
import 'package:serveeasy_app/app/data/models/order/dispute_list_response_model.dart';
import 'package:serveeasy_app/app/data/models/order/order_history_response_model.dart';
import 'package:serveeasy_app/app/data/models/order/ordet_deatils_response_model.dart';
import 'package:serveeasy_app/app/data/models/order/transaction_history_response_model.dart';
import 'package:serveeasy_app/app/data/models/payment/get_card_token_response.dart';
import 'package:serveeasy_app/app/data/models/user_model.dart';
import 'package:serveeasy_app/app/data/services/api_service/order_service.dart';
import 'package:serveeasy_app/app/data/services/exception_handler.dart';
import 'package:serveeasy_app/app/data/services/snackbar_manager.dart';
import 'package:serveeasy_app/app/data/services/user_manager.dart';

class OrderRepository {
  // Future<bool> createOrder({
  //   List<CartItem> cartList = const [],
  //   List<Deal> dealList = const [],
  //   PaymentType? paymentType,
  //   required String amountReceived,
  // }) async {
  //   try {
  //     final User? user = await UserManager().getUser();
  //     final ResponseModel<CreateOrderResponse> responseModel =
  //         await ResponseModel.fromApiResponse<CreateOrderResponse>(
  //       () async => await OrderApiService().createOrder(
  //         CreateOrderRequest(
  //           type: 40,
  //           status: 10,
  //           platform: 'pos',
  //           establishmentId: user!.establishmentId,
  //           paymentType: paymentType?.value,
  //           paymentStatus: 10,
  //           orderItems: cartList,
  //           userAddressId: user.addressDetail!.id,
  //           deals: dealList,
  //           paymentSources:
  //               paymentType != null && paymentType == PaymentType.card
  //                   ? [
  //                       PaymentSources(
  //                         sourceType: paymentType.value,
  //                         cardStripeToken: user.cardToken,
  //                         amountReceived: double.parse(
  //                           (double.parse(
  //                             amountReceived.isEmpty ? '0' : amountReceived,
  //                           )).toStringAsFixed(2),
  //                         ),
  //                         amountReturned: 0.0,
  //                       ),
  //                     ]
  //                   : null,
  //         ),
  //       ),
  //       (body) => CreateOrderResponse.fromJson(body),
  //     );
  //     if (responseModel.status == ResponseStatus.success) {
  //       await UserManager().clearLocalCart();
  //       await UserManager()
  //           .update(lastOrderId: responseModel.response!.data!.id);
  //       return true;
  //     } else if (responseModel.status == ResponseStatus.responseError ||
  //         responseModel.status == ResponseStatus.nullResponse) {
  //       SnackbarManager().showAlertSnackbar(responseModel.error!);
  //     }
  //   } on Exception catch (e) {
  //     ExceptionHandler().handle(e);
  //   }
  //   return false;
  // }

  Future<List<Transaction>> getOrderHistory(
    int page, {
    String? customerName = "",
  }) async {
    try {
      final ResponseModel<TransactionHistoryResponse> responseModel =
          await ResponseModel.fromApiResponse<TransactionHistoryResponse>(
        () async => await OrderApiService()
            .getOrderHistory(OrderType.online.value, customerName ?? "", page),
        (body) => TransactionHistoryResponse.fromJson(body),
      );
      if (responseModel.status == ResponseStatus.success) {
        return responseModel.response!.data!.data!;
      } else if (responseModel.status == ResponseStatus.responseError ||
          responseModel.status == ResponseStatus.nullResponse) {
        SnackbarManager().showAlertSnackbar(responseModel.error!);
      }
    } on Exception catch (e) {
      ExceptionHandler().handle(e);
    }
    return [];
  }

  Future<List<OrderData>> getActiveOrders(
    int page, {
    String? customerName = "",
  }) async {
    try {
      final ResponseModel<OrderHistoryResponse> responseModel =
          await ResponseModel.fromApiResponse<OrderHistoryResponse>(
        () async => await OrderApiService()
            .getActiveOrders(OrderType.online.value, page),
        (body) => OrderHistoryResponse.fromJson(body),
      );
      if (responseModel.status == ResponseStatus.success) {
        return responseModel.response!.data!.data!;
      } else if (responseModel.status == ResponseStatus.responseError ||
          responseModel.status == ResponseStatus.nullResponse) {
        SnackbarManager().showAlertSnackbar(responseModel.error!);
      }
    } on Exception catch (e) {
      ExceptionHandler().handle(e);
    }
    return [];
  }

  Future<List<Dispute>> getDisputes(
    int page, {
    String? customerName = "",
  }) async {
    try {
      final ResponseModel<DisputeDetailResponse> responseModel =
          await ResponseModel.fromApiResponse<DisputeDetailResponse>(
        () async => await OrderApiService().getDisputes(),
        (body) => DisputeDetailResponse.fromJson(body),
      );
      if (responseModel.status == ResponseStatus.success) {
        return responseModel.response!.data!;
      } else if (responseModel.status == ResponseStatus.responseError ||
          responseModel.status == ResponseStatus.nullResponse) {
        SnackbarManager().showAlertSnackbar(responseModel.error!);
      }
    } on Exception catch (e) {
      ExceptionHandler().handle(e);
    }
    return [];
  }

  Future<Transaction?> getOrderDetail(int orderId) async {
    try {
      final ResponseModel<TransactionDetailResponse> responseModel =
          await ResponseModel.fromApiResponse<TransactionDetailResponse>(
        () async => await OrderApiService().getOrderDetail(orderId),
        (body) => TransactionDetailResponse.fromJson(body),
      );
      if (responseModel.status == ResponseStatus.success) {
        return responseModel.response!.orderDetail!;
      } else if (responseModel.status == ResponseStatus.responseError ||
          responseModel.status == ResponseStatus.nullResponse) {
        SnackbarManager().showAlertSnackbar(responseModel.error!);
      }
    } on Exception catch (e) {
      ExceptionHandler().handle(e);
    }
    return null;
  }

  // Future<bool> getCardToken(PaymentCard card) async {
  //   try {
  //     final Response responseData = await OrderApiService().getCardToken(card);
  //     final GetCardTokenResponse response =
  //         GetCardTokenResponse.fromJson(responseData.data);
  //     if (response.id != null) {
  //       await UserManager().update(cardToken: response.id);
  //       return true;
  //     } else {
  //       SnackbarManager().showAlertSnackbar("Something went wrong!");
  //     }
  //   } on Exception catch (e) {
  //     ExceptionHandler().handle(e);
  //   }
  //   return false;
  // }
}
