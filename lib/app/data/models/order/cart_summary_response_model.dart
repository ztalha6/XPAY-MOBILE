import 'package:serveeasy_app/app/data/models/base_response_model.dart';
import 'package:serveeasy_app/app/data/models/menu/menu_data_response_model.dart';

class CartSummaryResponse extends BaseApiResponse {
  Data? data;

  CartSummaryResponse({this.data});

  CartSummaryResponse.fromJson(Map<String, dynamic> json) {
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
  int? orderType;
  int? paymentType;
  List<ResponseCartItems>? cartItems;
  List<ResponseDealsItems>? deals;
  int? establishmentId;
  num? grossTotal;
  num? netTotal;
  num? totalDiscount;
  int? discountType;
  num? serviceCharges;
  num? tax;

  Data({
    this.orderType,
    this.paymentType,
    this.cartItems,
    this.establishmentId,
    this.grossTotal,
    this.netTotal,
    this.totalDiscount,
    this.discountType,
    this.deals,
    this.serviceCharges,
    this.tax,
  });

  Summary get getSummary => Summary(
        grossAmount: grossTotal,
        discount: totalDiscount,
        discountType: discountType.toString(),
        serviceCharges: serviceCharges,
        netAmount: netTotal,
      );

  Data.fromJson(Map<String, dynamic> json) {
    orderType = json['order_type'];
    paymentType = json['payment_type'];
    tax = json['tax'];
    if (json['deals'] != null) {
      deals = <ResponseDealsItems>[];
      json['deals'].forEach((v) {
        deals!.add(ResponseDealsItems.fromJson(v));
      });
    }
    if (json['cart_items'] != null) {
      cartItems = <ResponseCartItems>[];
      json['cart_items'].forEach((v) {
        cartItems!.add(ResponseCartItems.fromJson(v));
      });
    }
    establishmentId = json['establishment_id'];
    grossTotal = json['gross_total'];
    netTotal = json['net_total'];
    totalDiscount = json['total_discount'];
    discountType = json['discount_type'];
    serviceCharges = json['service_charges'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_type'] = orderType;
    data['payment_type'] = paymentType;
    if (deals != null) {
      data['deals'] = deals!.map((v) => v.toJson()).toList();
    }
    if (cartItems != null) {
      data['cart_items'] = cartItems!.map((v) => v.toJson()).toList();
    }
    data['establishment_id'] = establishmentId;
    data['gross_total'] = grossTotal;
    data['net_total'] = netTotal;
    data['tax'] = tax;
    data['total_discount'] = totalDiscount;
    data['discount_type'] = discountType;
    data['service_charges'] = serviceCharges;
    return data;
  }
}

class ResponseCartItems {
  int? id;
  int? productId;
  int? qty;
  String? instruction;
  List<ResponseCartItemModifiers>? modifiers;
  num? payablePrice;
  num? discount;
  Product? product;

  ResponseCartItems({
    this.id,
    this.productId,
    this.qty,
    this.instruction,
    this.modifiers,
    this.payablePrice,
    this.discount,
    this.product,
  });

  ResponseCartItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    qty = json['qty'];
    instruction = json['instruction'];
    if (json['modifiers'] != null) {
      modifiers = <ResponseCartItemModifiers>[];
      json['modifiers'].forEach((v) {
        modifiers!.add(ResponseCartItemModifiers.fromJson(v));
      });
    }
    payablePrice = json['payable_price'];
    discount = json['discount'];
    product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product_id'] = productId;
    data['qty'] = qty;
    data['instruction'] = instruction;
    if (modifiers != null) {
      data['modifiers'] = modifiers!.map((v) => v.toJson()).toList();
    }
    data['payable_price'] = payablePrice;
    data['discount'] = discount;
    if (product != null) {
      data['product'] = product!.toJson();
    }
    return data;
  }
}

class ResponseCartItemModifiers {
  int? modifierId;
  int? qty;
  int? payablePrice;
  Modifier? modifier;

  ResponseCartItemModifiers({
    this.modifierId,
    this.qty,
    this.payablePrice,
    this.modifier,
  });

  ResponseCartItemModifiers.fromJson(Map<String, dynamic> json) {
    modifierId = json['modifier_id'];
    qty = json['qty'];
    payablePrice = json['payable_price'];
    modifier =
        json['modifier'] != null ? Modifier.fromJson(json['modifier']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['modifier_id'] = modifierId;
    data['qty'] = qty;
    data['payable_price'] = payablePrice;
    if (modifier != null) {
      data['modifier'] = modifier!.toJson();
    }
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

class Summary {
  num? grossAmount;
  num? discount;
  String? discountType;
  num? serviceCharges;
  num? netAmount;
  num? tip;
  num? tax;

  Summary({
    this.grossAmount,
    this.discount = 0,
    this.discountType,
    this.serviceCharges = 0,
    this.tip = 0,
    this.tax = 0.0,
    this.netAmount,
  });

  Summary.fresh() {
    Summary(grossAmount: 0, netAmount: 0.0, tip: 0.0);
  }

  Summary.fromJson(Map<String, dynamic> json) {
    grossAmount = json['grossAmount'];
    discount = json['discount'];
    tip = json['tip'];
    tax = json['tax'];
    discountType = json['discountType'];
    serviceCharges = json['serviceCharges'];
    netAmount = json['netAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['grossAmount'] = grossAmount;
    data['tip'] = tip;
    data['tax'] = tax;
    data['discount'] = discount;
    data['discountType'] = discountType;
    data['serviceCharges'] = serviceCharges;
    data['netAmount'] = netAmount;
    return data;
  }
}

class ResponseDealsItems {
  int? id;
  int? dealId;
  int? qty;
  List<ResponseDealModifiers>? dealItems;
  int? payablePrice;
  int? discount;
  DealCombo? dealCombo;
  String? instruction;

  ResponseDealsItems({
    this.id,
    this.dealId,
    this.qty,
    this.dealItems,
    this.payablePrice,
    this.discount,
    this.dealCombo,
    this.instruction,
  });

  ResponseDealsItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dealId = json['deal_id'];
    qty = json['qty'];
    dealCombo = json['deal_combo'] != null
        ? DealCombo.fromJson(json['deal_combo'])
        : null;
    if (json['deal_items'] != null) {
      dealItems = <ResponseDealModifiers>[];
      json['deal_items'].forEach((v) {
        dealItems!.add(ResponseDealModifiers.fromJson(v));
      });
    }
    instruction = json['instruction'];
    payablePrice = json['payable_price'];
    discount = json['discount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['deal_id'] = dealId;
    data['qty'] = qty;
    if (dealItems != null) {
      data['deal_items'] = dealItems!.map((v) => v.toJson()).toList();
    }
    if (dealCombo != null) {
      data['deal_combo'] = dealCombo!.toJson();
    }
    data['payable_price'] = payablePrice;
    data['discount'] = discount;
    data['instruction'] = instruction;

    return data;
  }
}

class ResponseDealModifiers {
  int? productId;
  int? dealComboItemId;
  DealComboItem? dealComboItem;
  Product? product;

  ResponseDealModifiers({
    this.productId,
    this.dealComboItemId,
    this.dealComboItem,
    this.product,
  });

  ResponseDealModifiers.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    dealComboItemId = json['deal_combo_item_id'];
    dealComboItem = json['deal_combo_item'] != null
        ? DealComboItem.fromJson(json['deal_combo_item'])
        : null;
    product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId;
    data['deal_combo_item_id'] = dealComboItemId;
    if (dealComboItem != null) {
      data['deal_combo_item'] = dealComboItem!.toJson();
    }
    if (product != null) {
      data['product'] = product!.toJson();
    }
    return data;
  }
}

class DealCombo {
  int? id;
  int? establishmentId;
  String? name;
  int? type;
  int? status;
  int? createdById;
  int? updatedById;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? createdAgo;
  String? typeText;
  String? statusText;
  int? totalSalePrice;
  DealComboImage? dealComboImage;

  DealCombo({
    this.id,
    this.establishmentId,
    this.name,
    this.type,
    this.status,
    this.createdById,
    this.updatedById,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.createdAgo,
    this.typeText,
    this.statusText,
    this.totalSalePrice,
    this.dealComboImage,
  });

  DealCombo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    establishmentId = json['establishment_id'];
    name = json['name'];
    type = json['type'];
    status = json['status'];
    dealComboImage = json['deal_combo_image'] != null
        ? DealComboImage.fromJson(json['deal_combo_image'])
        : null;
    createdById = json['created_by_id'];
    updatedById = json['updated_by_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    createdAgo = json['created_ago'];
    typeText = json['type_text'];
    statusText = json['status_text'];
    totalSalePrice = json['total_sale_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['establishment_id'] = establishmentId;
    data['name'] = name;
    data['type'] = type;
    data['status'] = status;
    data['created_by_id'] = createdById;
    data['updated_by_id'] = updatedById;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['created_ago'] = createdAgo;
    data['type_text'] = typeText;
    data['status_text'] = statusText;
    data['total_sale_price'] = totalSalePrice;
    if (dealComboImage != null) {
      data['deal_combo_image'] = dealComboImage!.toJson();
    }
    return data;
  }
}

class DealComboItem {
  int? id;
  int? dealComboId;
  int? categoryId;
  int? quantity;
  int? salePrice;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  int? optional;
  String? createdAgo;

  DealComboItem({
    this.id,
    this.dealComboId,
    this.categoryId,
    this.quantity,
    this.salePrice,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.optional,
    this.createdAgo,
  });

  DealComboItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dealComboId = json['deal_combo_id'];
    categoryId = json['category_id'];
    quantity = json['quantity'];
    salePrice = json['sale_price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    optional = json['optional'];
    createdAgo = json['created_ago'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['deal_combo_id'] = dealComboId;
    data['category_id'] = categoryId;
    data['quantity'] = quantity;
    data['sale_price'] = salePrice;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['optional'] = optional;
    data['created_ago'] = createdAgo;
    return data;
  }
}
