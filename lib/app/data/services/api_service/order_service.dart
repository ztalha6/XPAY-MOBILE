import 'package:dio/dio.dart';
import 'package:payment_card_validation/payment_card.dart';
import 'package:serveeasy_app/app/data/models/order/create_order_request_model.dart';
import 'package:serveeasy_app/app/data/services/dio_service/dio_builder.dart';
import 'package:serveeasy_app/core/constants/api_constants.dart';

class OrderApiService {
  Future<dynamic> createOrder(CreateOrderRequest request) async {
    final DioBuilderResponse dioBuilderResponse =
        await DioBuilder().buildNonCachedDio(hasAuth: true);
    final Response response = await dioBuilderResponse.dio.post(
      createOrderApiconstant,
      options: dioBuilderResponse.dioOptions,
      data: request.toJson(),
    );
    return response;
  }

  Future<dynamic> getOrderHistory(
    int orderType,
    String customerName,
    int page,
  ) async {
    final DioBuilderResponse dioBuilderResponse =
        await DioBuilder().buildNonCachedDio(hasAuth: true);
    final Response response = await dioBuilderResponse.dio.get(
      true
          ? "$orderHistory"
          : "$orderHistory?type=$orderType&customer_name=$customerName&page=$page",
      options: dioBuilderResponse.dioOptions,
    );
    return response;
  }

  Future<dynamic> getActiveOrders(
    int orderType,
    int page,
  ) async {
    final DioBuilderResponse dioBuilderResponse =
        await DioBuilder().buildNonCachedDio(hasAuth: true);
    final Response response = await dioBuilderResponse.dio.get(
      "$orderHistory?type=$orderType&page=$page&status[]=10&status[]=50&status[]=40&status[]=30",
      options: dioBuilderResponse.dioOptions,
    );
    return response;
  }

  Future<dynamic> getOrderDetail(
    int orderId,
  ) async {
    final DioBuilderResponse dioBuilderResponse =
        await DioBuilder().buildNonCachedDio(hasAuth: true);
    final Response response = await dioBuilderResponse.dio.get(
      "$orderSingleHistory/$orderId",
      options: dioBuilderResponse.dioOptions,
    );
    return response;
  }

  Future<dynamic> getDisputes() async {
    final DioBuilderResponse dioBuilderResponse =
        await DioBuilder().buildNonCachedDio(hasAuth: true);
    final Response response = await dioBuilderResponse.dio.get(
      "$getDisputesAPI/?pagination=false&dispute_status[]=10",
      options: dioBuilderResponse.dioOptions,
    );
    return response;
  }

  Future<dynamic> getCardToken(
    PaymentCard card,
  ) async {
    final Response response = await Dio().post(
      "https://api.stripe.com/v1/tokens",
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
        headers: {
          "Authorization": "Bearer sk_test_4eC39HqLyjWDarjtT1zdp7dc",
        },
      ),
      data: {
        "card[number]": card.number,
        "card[exp_month]": card.month,
        "card[exp_year]": card.year,
        "card[cvc]": card.cvv,
      },
    );
    return response;
  }
}
