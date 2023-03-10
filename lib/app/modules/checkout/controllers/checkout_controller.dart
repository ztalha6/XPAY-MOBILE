import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payment_card_validation/payment_card.dart';
import 'package:serveeasy_app/app/data/enum/payment_types.dart';
import 'package:serveeasy_app/app/data/models/addresses/all_addresses_response_model.dart';
import 'package:serveeasy_app/app/data/models/base_repository_model.dart';
import 'package:serveeasy_app/app/data/models/order/cart_sumamry_request_model.dart';
import 'package:serveeasy_app/app/data/models/order/cart_summary_response_model.dart';
import 'package:serveeasy_app/app/data/repositories/order_repository.dart';
import 'package:serveeasy_app/app/data/repositories/product_repository.dart';
import 'package:serveeasy_app/app/data/services/user_manager.dart';
import 'package:serveeasy_app/app/routes/app_pages.dart';
import 'package:serveeasy_app/core/constants/configuration.dart';

class CheckoutController extends GetxController {
  Configuration configs = Configuration();
  TextEditingController customTipController = TextEditingController();
  RxBool isLoading = false.obs;
  RxBool isPlacingOrder = false.obs;
  RxBool isSyncing = false.obs;
  RxBool isUpadtingAddress = false.obs;
  RxList<int> tips = RxList<int>([0, 20, 18, 15, 10]);
  RxInt selectedTip = RxInt(0);
  Rxn<Address> addressDetails = Rxn<Address>();
  RxList<CartItem> cartItems = RxList<CartItem>([]);
  RxList<Deal> dealItems = RxList<Deal>([]);
  Rx<Summary> summary = Rx<Summary>(Summary.fresh());
  RxList<PaymentType> payTypeList =
      RxList<PaymentType>(PaymentType.paymentTypeList);
  RxInt selectedPayMethod = RxInt(0);
  RxString promoCode = ''.obs;

  Rx<PaymentCard> paymentCard = Rx<PaymentCard>(PaymentCard(number: ""));

  final count = 0.obs;
  @override
  Future<void> onInit() async {
    // addressDetails.value = await UserManager().getSavedAddress();
    cartItems.value = await UserManager().getUserCart();
    dealItems.value = await UserManager().getUserDeals();
    summary.value = await UserManager().getUserCartSummary();
    await cartSummary();
    super.onInit();
  }

  Future<void> cartSummary({bool service = true}) async {
    // isSyncing.value = true;
    // final RepositoryResponse<List<dynamic>> response =
    //     await ProductRepository().getCartSummary(
    //   cartItems,
    //   dealItems,
    //   payTypeList[selectedPayMethod.value],
    // );
    // if (response.isSuccess) {
    //   cartItems.value = response.data![0];
    //   dealItems.value = response.data![1];
    //   summary.value = response.data![2];
    // }
    // isSyncing.value = false;
  }

  Future<void> updateAddress() async {
    // final dynamic addressSet = await Get.toNamed(
    //   Routes.ADDRESS_LIST,
    //   arguments: AddressListViewParams(fromCheckoutView: true),
    // );
    // if ((addressSet != null) && addressSet) {
    //   // addressDetails.value = await UserManager().getSavedAddress();
    // }
  }

  Future<void> createOrder() async {
    // isPlacingOrder(true);
    // if (await OrderRepository().createOrder(
    //   cartList: cartItems,
    //   dealList: dealItems,
    //   paymentType: payTypeList[selectedPayMethod.value],
    //   amountReceived: summary.value.netAmount!.toString(),
    // )) {
    //   Get.offAllNamed(Routes.DRAWER);
    //   Get.toNamed(Routes.ORDER_SUCCESS);
    // }
    // isPlacingOrder(false);
  }

  void onTipChange(int index) {
    if (index == selectedTip.value) return;
    selectedTip(index);
    summary.value.tip = 0.0;
    if (index == -2) {
      if (customTipController.text.isEmpty) {
        summary.value.tip = 0.0;
        summary.value.netAmount = summary.value.tip! + summary.value.netAmount!;
        summary.refresh();
        return;
      }
      summary.value.tip = (summary.value.netAmount)! *
          (double.parse(customTipController.text) / 100);
      summary.value.netAmount = summary.value.tip! + summary.value.netAmount!;
      summary.refresh();
      return;
    }
    summary.value.tip = (summary.value.netAmount)! * (tips[index] / 100);
    summary.value.netAmount = summary.value.tip! + summary.value.netAmount!;
    summary.refresh();
  }

  Future<void> applyPromoCode() async {
    final String code = await Get.toNamed(Routes.PROMO);
    if (code.isNotEmpty) {
      promoCode(code);
      await cartSummary();
    }
  }

  Future<void> removePromoCode() async {
    promoCode("");
    await cartSummary();
  }

  void removeCard() {
    paymentCard(PaymentCard(number: ""));
    selectedPayMethod(0);
  }
}
