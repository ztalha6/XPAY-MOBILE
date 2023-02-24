import 'package:serveeasy_app/app/data/models/order/cart_sumamry_request_model.dart';

class CreateOrderRequest {
  int? establishmentId;
  int? type;
  int? status;
  String? platform;
  int? paymentStatus;
  int? userAddressId;
  int? paymentType;
  int? tableId;
  int? deliveryCustomerId;
  List<CartItem>? orderItems;
  List<Deal>? deals;
  List<PaymentSources>? paymentSources;

  CreateOrderRequest({
    this.establishmentId,
    this.type,
    this.status,
    this.platform,
    this.paymentStatus,
    this.userAddressId,
    this.paymentType,
    this.deals,
    this.orderItems,
    this.tableId,
    this.deliveryCustomerId,
    this.paymentSources,
  });

  CreateOrderRequest.fromJson(Map<String, dynamic> json) {
    establishmentId = json['establishment_id'];
    type = json['type'];
    status = json['status'];
    platform = json['platform'];
    deliveryCustomerId = json['delivery_customer_id'];
    paymentStatus = json['payment_status'];
    userAddressId = json['user_address_id'];
    tableId = json['table_id'];
    paymentType = json['payment_type'];
    if (json['order_items'] != null) {
      orderItems = <CartItem>[];
      json['order_items'].forEach((v) {
        orderItems!.add(CartItem.fromJson(v));
      });
    }
    if (json['order_deal_combos'] != null) {
      deals = <Deal>[];
      json['order_deal_combos'].forEach((v) {
        deals!.add(Deal.fromJson(v));
      });
    }
    if (json['payment_sources'] != null) {
      paymentSources = <PaymentSources>[];
      json['payment_sources'].forEach((v) {
        paymentSources!.add(PaymentSources.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['establishment_id'] = establishmentId;
    data['type'] = type;
    data['status'] = status;
    data['platform'] = platform;
    data['payment_status'] = paymentStatus;
    data['delivery_customer_id'] = deliveryCustomerId;
    data['user_address_id'] = userAddressId;
    data['payment_type'] = paymentType;
    data['table_id'] = tableId;
    if (orderItems != null) {
      data['order_items'] = orderItems!.map((v) => v.toJson()).toList();
    }
    if (deals != null) {
      data['order_deal_combos'] = deals!.map((v) => v.toJson()).toList();
    }
    if (paymentSources != null) {
      data['payment_sources'] = paymentSources!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PaymentSources {
  int? sourceType;
  num? amountReceived;
  num? amountReturned;
  String? cardStripeToken;

  PaymentSources({
    this.sourceType,
    this.amountReceived,
    this.amountReturned,
    this.cardStripeToken,
  });

  PaymentSources.fromJson(Map<String, dynamic> json) {
    sourceType = json['source_type'];
    amountReceived = json['amount_received'];
    amountReturned = json['amount_returned'];
    cardStripeToken = json['payment_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['source_type'] = sourceType;
    data['amount_received'] = amountReceived;
    data['amount_returned'] = amountReturned;
    data['payment_token'] = cardStripeToken;
    return data;
  }
}
