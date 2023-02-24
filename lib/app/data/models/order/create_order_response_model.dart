import 'package:serveeasy_app/app/data/models/base_response_model.dart';
import 'package:serveeasy_app/app/data/models/menu/menu_data_response_model.dart';
import 'package:serveeasy_app/app/data/models/order/cart_summary_response_model.dart';
import 'package:serveeasy_app/app/data/models/order/order_history_response_model.dart';

class CreateOrderResponse extends BaseApiResponse {
  Data? data;

  CreateOrderResponse({this.data});

  CreateOrderResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  int? userId;
  int? tableId;
  int? employeeId;
  int? establishmentId;
  int? userAddressId;
  int? type;
  int? deliveryCustomerId;
  int? riderId;
  int? status;
  int? paymentStatus;
  num? grossAmount;
  num? totalDiscount;
  num? tip;
  num? serviceCharges;
  int? totalGuests;
  int? discountType;
  String? promoCode;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? platform;
  int? cartId;
  num? netAmount;
  OrderTaker? orderTaker;
  String? deliveryCustomer;
  List<Transactions>? transactions;
  MobileCustomer? mobileCustomer;
  List<OrderItems>? orderItems;
  List<DealCombos>? dealCombos;
  String? createdAgo;
  String? statusText;
  String? paymentStatusText;
  String? typeText;

  Data({
    this.id,
    this.userId,
    this.tableId,
    this.employeeId,
    this.establishmentId,
    this.userAddressId,
    this.type,
    this.deliveryCustomerId,
    this.riderId,
    this.status,
    this.paymentStatus,
    this.dealCombos,
    this.grossAmount,
    this.totalDiscount,
    this.tip,
    this.serviceCharges,
    this.totalGuests,
    this.discountType,
    this.promoCode,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.platform,
    this.cartId,
    this.netAmount,
    this.orderTaker,
    this.deliveryCustomer,
    this.transactions,
    this.mobileCustomer,
    this.orderItems,
    this.createdAgo,
    this.statusText,
    this.paymentStatusText,
    this.typeText,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    tableId = json['table_id'];
    employeeId = json['employee_id'];
    establishmentId = json['establishment_id'];
    userAddressId = json['user_address_id'];
    type = json['type'];
    deliveryCustomerId = json['delivery_customer_id'];
    riderId = json['rider_id'];
    status = json['status'];
    paymentStatus = json['payment_status'];
    grossAmount = json['gross_amount'];
    totalDiscount = json['total_discount'];
    tip = json['tip'];
    serviceCharges = json['service_charges'];
    totalGuests = json['total_guests'];
    discountType = json['discount_type'];
    promoCode = json['promo_code'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    platform = json['platform'];
    cartId = json['cart_id'];
    netAmount = json['net_amount'];
    orderTaker = json['order_taker'] != null
        ? OrderTaker.fromJson(json['order_taker'])
        : null;
    // deliveryCustomer = json['delivery_customer'];
    if (json['deal_combos'] != null) {
      dealCombos = <DealCombos>[];
      json['deal_combos'].forEach((v) {
        dealCombos!.add(DealCombos.fromJson(v));
      });
    }
    if (json['transactions'] != null) {
      transactions = <Transactions>[];
      json['transactions'].forEach((v) {
        transactions!.add(Transactions.fromJson(v));
      });
    }
    mobileCustomer = json['mobile_customer'] != null
        ? MobileCustomer.fromJson(json['mobile_customer'])
        : null;
    if (json['order_items'] != null) {
      orderItems = <OrderItems>[];
      json['order_items'].forEach((v) {
        orderItems!.add(OrderItems.fromJson(v));
      });
    }
    createdAgo = json['created_ago'];
    statusText = json['status_text'];
    paymentStatusText = json['payment_status_text'];
    typeText = json['type_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['table_id'] = tableId;
    data['employee_id'] = employeeId;
    data['establishment_id'] = establishmentId;
    data['user_address_id'] = userAddressId;
    data['type'] = type;
    data['delivery_customer_id'] = deliveryCustomerId;
    data['rider_id'] = riderId;
    data['status'] = status;
    data['payment_status'] = paymentStatus;
    data['gross_amount'] = grossAmount;
    data['total_discount'] = totalDiscount;
    data['tip'] = tip;
    data['service_charges'] = serviceCharges;
    data['total_guests'] = totalGuests;
    data['discount_type'] = discountType;
    data['promo_code'] = promoCode;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['platform'] = platform;
    data['cart_id'] = cartId;
    data['net_amount'] = netAmount;
    if (orderTaker != null) {
      data['order_taker'] = orderTaker!.toJson();
    }
    if (dealCombos != null) {
      data['deal_combos'] = dealCombos!.map((v) => v.toJson()).toList();
    }
    data['delivery_customer'] = deliveryCustomer;
    if (transactions != null) {
      data['transactions'] = transactions!.map((v) => v.toJson()).toList();
    }
    if (mobileCustomer != null) {
      data['mobile_customer'] = mobileCustomer!.toJson();
    }
    if (orderItems != null) {
      data['order_items'] = orderItems!.map((v) => v.toJson()).toList();
    }
    data['created_ago'] = createdAgo;
    data['status_text'] = statusText;
    data['payment_status_text'] = paymentStatusText;
    data['type_text'] = typeText;
    return data;
  }
}

class OrderTaker {
  String? fullName;
  int? id;

  OrderTaker({this.fullName, this.id});

  OrderTaker.fromJson(Map<String, dynamic> json) {
    fullName = json['full_name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['full_name'] = fullName;
    data['id'] = id;
    return data;
  }
}

class DealCombos {
  //TODO: Deal price is missing from bacnkend
  int? id;
  int? dealComboId;
  int? orderId;
  int? purchasedQty;
  String? instructions;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  List<DealComboItems>? dealComboItems;
  String? createdAgo;
  DealCombo? dealCombo;

  DealCombos({
    this.id,
    this.dealComboId,
    this.orderId,
    this.purchasedQty,
    this.instructions,
    this.dealCombo,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.dealComboItems,
    this.createdAgo,
  });

  DealCombos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dealComboId = json['deal_combo_id'];
    orderId = json['order_id'];
    purchasedQty = json['purchased_qty'];
    dealCombo = json['deal_combo'] != null
        ? DealCombo.fromJson(json['deal_combo'])
        : null;
    instructions = json['instructions'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    if (json['deal_combo_items'] != null) {
      dealComboItems = <DealComboItems>[];
      json['deal_combo_items'].forEach((v) {
        dealComboItems!.add(DealComboItems.fromJson(v));
      });
    }
    createdAgo = json['created_ago'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['deal_combo_id'] = dealComboId;
    data['order_id'] = orderId;
    data['purchased_qty'] = purchasedQty;
    data['instructions'] = instructions;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    if (dealCombo != null) {
      data['deal_combo'] = dealCombo!.toJson();
    }
    if (dealComboItems != null) {
      data['deal_combo_items'] =
          dealComboItems!.map((v) => v.toJson()).toList();
    }
    data['created_ago'] = createdAgo;
    return data;
  }
}

class DealComboItems {
  int? id;
  int? orderDealId;
  int? productId;
  int? purchasedQty;
  int? payablePrice;
  int? unitPrice;
  int? unitDiscount;
  int? productDiscount;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  int? dealComboItemId;
  Product? product;
  String? createdAgo;

  DealComboItems({
    this.id,
    this.orderDealId,
    this.productId,
    this.purchasedQty,
    this.payablePrice,
    this.unitPrice,
    this.unitDiscount,
    this.productDiscount,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.dealComboItemId,
    this.product,
    this.createdAgo,
  });

  DealComboItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderDealId = json['order_deal_id'];
    productId = json['product_id'];
    purchasedQty = json['purchased_qty'];
    payablePrice = json['payable_price'];
    unitPrice = json['unit_price'];
    unitDiscount = json['unit_discount'];
    productDiscount = json['product_discount'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    dealComboItemId = json['deal_combo_item_id'];
    product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
    createdAgo = json['created_ago'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['order_deal_id'] = orderDealId;
    data['product_id'] = productId;
    data['purchased_qty'] = purchasedQty;
    data['payable_price'] = payablePrice;
    data['unit_price'] = unitPrice;
    data['unit_discount'] = unitDiscount;
    data['product_discount'] = productDiscount;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['deal_combo_item_id'] = dealComboItemId;
    if (product != null) {
      data['product'] = product!.toJson();
    }
    data['created_ago'] = createdAgo;
    return data;
  }
}

class OrderItems {
  int? id;
  int? productId;
  int? orderId;
  num? productDiscount;
  int? cartItemId;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  num? payablePrice;
  int? purchasedQty;
  String? instruction;
  num? unitPrice;
  num? unitDiscount;
  Product? product;
  List<OrderItemModifiers>? orderItemModifiers;
  String? createdAgo;

  OrderItems({
    this.id,
    this.productId,
    this.orderId,
    this.productDiscount,
    this.cartItemId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.payablePrice,
    this.purchasedQty,
    this.instruction,
    this.unitPrice,
    this.unitDiscount,
    this.product,
    this.orderItemModifiers,
    this.createdAgo,
  });

  OrderItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    orderId = json['order_id'];
    productDiscount = json['product_discount'];
    cartItemId = json['cart_item_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    payablePrice = json['payable_price'];
    purchasedQty = json['purchased_qty'];
    instruction = json['instruction'];
    unitPrice = json['unit_price'];
    unitDiscount = json['unit_discount'];
    product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
    if (json['orderItemModifiers'] != null) {
      orderItemModifiers = <OrderItemModifiers>[];
      json['orderItemModifiers'].forEach((v) {
        orderItemModifiers!.add(OrderItemModifiers.fromJson(v));
      });
    }
    createdAgo = json['created_ago'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product_id'] = productId;
    data['order_id'] = orderId;
    data['product_discount'] = productDiscount;
    data['cart_item_id'] = cartItemId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['payable_price'] = payablePrice;
    data['purchased_qty'] = purchasedQty;
    data['instruction'] = instruction;
    data['unit_price'] = unitPrice;
    data['unit_discount'] = unitDiscount;
    if (product != null) {
      data['product'] = product!.toJson();
    }
    if (orderItemModifiers != null) {
      data['orderItemModifiers'] =
          orderItemModifiers!.map((v) => v.toJson()).toList();
    }
    data['created_ago'] = createdAgo;
    return data;
  }
}

class OrderItemModifiers {
  int? id;
  int? orderItemId;
  int? modifierId;
  int? payablePrice;
  int? qty;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  Modifier? modifier;
  String? createdAgo;

  OrderItemModifiers({
    this.id,
    this.orderItemId,
    this.modifierId,
    this.payablePrice,
    this.qty,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.modifier,
    this.createdAgo,
  });

  OrderItemModifiers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderItemId = json['order_item_id'];
    modifierId = json['modifier_id'];
    payablePrice = json['payable_price'];
    qty = json['qty'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    modifier =
        json['modifier'] != null ? Modifier.fromJson(json['modifier']) : null;
    createdAgo = json['created_ago'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['order_item_id'] = orderItemId;
    data['modifier_id'] = modifierId;
    data['payable_price'] = payablePrice;
    data['qty'] = qty;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    if (modifier != null) {
      data['modifier'] = modifier!.toJson();
    }
    data['created_ago'] = createdAgo;
    return data;
  }
}

class Modifier {
  int? id;
  String? name;
  int? status;
  int? modifierClassId;
  int? establishmentId;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  int? price;
  int? barcode;
  int? cost;
  int? createdById;
  int? updatedById;
  String? createdAgo;
  String? statusText;

  Modifier({
    this.id,
    this.name,
    this.status,
    this.modifierClassId,
    this.establishmentId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.price,
    this.barcode,
    this.cost,
    this.createdById,
    this.updatedById,
    this.createdAgo,
    this.statusText,
  });

  Modifier.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    modifierClassId = json['modifier_class_id'];
    establishmentId = json['establishment_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    price = json['price'];
    barcode = json['barcode'];
    cost = json['cost'];
    createdById = json['created_by_id'];
    updatedById = json['updated_by_id'];
    createdAgo = json['created_ago'];
    statusText = json['status_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['status'] = status;
    data['modifier_class_id'] = modifierClassId;
    data['establishment_id'] = establishmentId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['price'] = price;
    data['barcode'] = barcode;
    data['cost'] = cost;
    data['created_by_id'] = createdById;
    data['updated_by_id'] = updatedById;
    data['created_ago'] = createdAgo;
    data['status_text'] = statusText;
    return data;
  }
}
