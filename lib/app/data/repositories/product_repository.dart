import 'package:serveeasy_app/app/data/enum/payment_types.dart';
import 'package:serveeasy_app/app/data/models/base_repository_model.dart';
import 'package:serveeasy_app/app/data/models/base_response_model.dart';
import 'package:serveeasy_app/app/data/models/menu/menu_data_response_model.dart';
import 'package:serveeasy_app/app/data/models/modifiers/deal_modiifer_response.dart';
// import 'package:serveeasy_app/app/data/models/modifiers/deal_modiifer_response.dart';
import 'package:serveeasy_app/app/data/models/modifiers/modifiers_response_model.dart';
import 'package:serveeasy_app/app/data/models/order/cart_sumamry_request_model.dart';
import 'package:serveeasy_app/app/data/models/order/cart_summary_response_model.dart';
import 'package:serveeasy_app/app/data/models/search/search_product_response_model.dart';
import 'package:serveeasy_app/app/data/models/user_model.dart';
import 'package:serveeasy_app/app/data/repositories/menu_repositoy.dart';
import 'package:serveeasy_app/app/data/services/api_service/product_service.dart';
import 'package:serveeasy_app/app/data/services/exception_handler.dart';
import 'package:serveeasy_app/app/data/services/snackbar_manager.dart';
import 'package:serveeasy_app/app/data/services/user_manager.dart';

class ProductRepository {
  Future<List<ModifierType>> getProductModifiers(int productId) async {
    try {
      final ResponseModel<ModifiersResponse> responseModel =
          await ResponseModel.fromApiResponse<ModifiersResponse>(
        () async => await ProductApiService().getProductModifiers(productId),
        (body) => ModifiersResponse.fromJson(body),
      );
      if (responseModel.status == ResponseStatus.success) {
        return responseModel.response!.modifierType!;
      } else if (responseModel.status == ResponseStatus.responseError ||
          responseModel.status == ResponseStatus.nullResponse) {
        SnackbarManager().showAlertSnackbar(responseModel.error!);
      }
    } on Exception catch (e) {
      ExceptionHandler().handle(e);
    }
    return [];
  }

  Future<List<DealComboItems>> getDealModifiers(int dealId) async {
    try {
      final ResponseModel<DealModifierResponse> responseModel =
          await ResponseModel.fromApiResponse<DealModifierResponse>(
        () async => await ProductApiService().getDealModifiers(dealId),
        (body) => DealModifierResponse.fromJson(body),
      );
      if (responseModel.status == ResponseStatus.success) {
        return responseModel.response!.data!.dealComboItems!;
      } else if (responseModel.status == ResponseStatus.responseError ||
          responseModel.status == ResponseStatus.nullResponse) {
        SnackbarManager().showAlertSnackbar(responseModel.error!);
        return [];
      }
    } on Exception catch (e) {
      ExceptionHandler().handle(e);
    }
    return [];
  }

  Future<List<Product>> searchProducts(
    int page, {
    String productName = "",
  }) async {
    try {
      final ResponseModel<SearchProductResponse> responseModel =
          await ResponseModel.fromApiResponse<SearchProductResponse>(
        () async => await ProductApiService().searchProduct(
          page: page,
          customMenuId: MenuRepository.currentCustomMenuId,
          text: productName,
        ),
        (body) => SearchProductResponse.fromJson(body),
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

  Future<RepositoryResponse<List>> getCartSummary(
    List<CartItem> cartList,
    List<Deal> dealList,
    PaymentType paymentType,
  ) async {
    try {
      final User? user = await UserManager().getUser();
      final ResponseModel<CartSummaryResponse> responseModel =
          await ResponseModel.fromApiResponse<CartSummaryResponse>(
        () async => await ProductApiService().getCartSummary(
          CartSummaryRequest(
            paymentType: paymentType.value,
            orderType: 40,
            cartItems: cartList,
            establishmentId: user!.establishmentId,
            deals: dealList,
          ),
        ),
        (body) => CartSummaryResponse.fromJson(body),
      );
      if (responseModel.status == ResponseStatus.success) {
        final List<ResponseCartItems> cartItems =
            responseModel.response!.data!.cartItems!;
        final List<ResponseDealsItems> deals =
            responseModel.response!.data!.deals!;
        await UserManager().update(
          cartId: cartItems.isNotEmpty ? cartItems.first.id : null,
          dealId: deals.isNotEmpty ? deals.first.dealId : null,
        );
        return RepositoryResponse(
          isSuccess: true,
          data: [
            CartItem.fromResponseCart(responseModel.response!.data!.cartItems!),
            Deal.fromResponseCart(deals),
            responseModel.response!.data!.getSummary,
          ],
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
}
