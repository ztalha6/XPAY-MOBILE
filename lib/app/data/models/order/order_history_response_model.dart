import 'package:serveeasy_app/app/data/models/base_response_model.dart';
import 'package:serveeasy_app/app/data/models/order/create_order_response_model.dart';
import 'package:serveeasy_app/app/data/models/user_model.dart';

class OrderHistoryResponse extends BaseApiResponse {
  Data? data;

  OrderHistoryResponse({this.data});

  OrderHistoryResponse.fromJson(Map<String, dynamic> json) {
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
  Meta? meta;
  List<OrderData>? data;

  Data({this.meta, this.data});

  Data.fromJson(Map<String, dynamic> json) {
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    if (json['data'] != null) {
      data = <OrderData>[];
      json['data'].forEach((v) {
        data!.add(OrderData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Meta {
  int? total;
  int? perPage;
  int? currentPage;
  int? lastPage;
  int? firstPage;
  String? firstPageUrl;
  String? lastPageUrl;
  String? nextPageUrl;
  String? previousPageUrl;

  Meta({
    this.total,
    this.perPage,
    this.currentPage,
    this.lastPage,
    this.firstPage,
    this.firstPageUrl,
    this.lastPageUrl,
    this.nextPageUrl,
    this.previousPageUrl,
  });

  Meta.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    perPage = json['per_page'];
    currentPage = json['current_page'];
    lastPage = json['last_page'];
    firstPage = json['first_page'];
    firstPageUrl = json['first_page_url'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    previousPageUrl = json['previous_page_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    data['per_page'] = perPage;
    data['current_page'] = currentPage;
    data['last_page'] = lastPage;
    data['first_page'] = firstPage;
    data['first_page_url'] = firstPageUrl;
    data['last_page_url'] = lastPageUrl;
    data['next_page_url'] = nextPageUrl;
    data['previous_page_url'] = previousPageUrl;
    return data;
  }
}

class OrderData {
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
  Eshtablishment? establishment;
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
  int? paymentType;
  num? netAmount;
  OrderTaker? orderTaker;
  DeliveryCustomer? deliveryCustomer;
  MobileCustomer? mobileCustomer;
  UserAddress? userAddress;
  List<Transactions>? transactions;
  List<OrderItems>? orderItems;
  String? createdAgo;
  String? statusText;
  String? paymentStatusText;
  String? typeText;
  num? tax;

  OrderData({
    this.id,
    this.userId,
    this.tableId,
    this.employeeId,
    this.establishmentId,
    this.establishment,
    this.userAddressId,
    this.type,
    this.deliveryCustomerId,
    this.riderId,
    this.status,
    this.paymentStatus,
    this.tax,
    this.grossAmount,
    this.totalDiscount,
    this.paymentType,
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
    this.mobileCustomer,
    this.transactions,
    this.userAddress,
    this.orderItems,
    this.createdAgo,
    this.statusText,
    this.paymentStatusText,
    this.typeText,
  });

  String get getItemsString {
    if (orderItems == null || orderItems!.isEmpty) {
      return "";
    }
    final modifierBuffer = StringBuffer();
    for (final element in orderItems!) {
      modifierBuffer.write("+${element.product!.name!} ");
    }
    return modifierBuffer.toString();
  }

  OrderData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    tableId = json['table_id'];
    employeeId = json['employee_id'];
    establishmentId = json['establishment_id'];
    userAddressId = json['user_address_id'];
    type = json['type'];
    deliveryCustomerId = json['delivery_customer_id'];
    riderId = json['rider_id'];
    tax = json['tax'];
    status = json['status'];
    paymentStatus = json['payment_status'];
    grossAmount = json['gross_amount'];
    totalDiscount = json['total_discount'];
    tip = json['tip'];
    paymentType = json['payment_type'];
    serviceCharges = json['service_charges'];
    totalGuests = json['total_guests'];
    discountType = json['discount_type'];
    promoCode = json['promo_code'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    platform = json['platform'];
    cartId = json['cart_id'];
    establishment = json['establishment'] == null
        ? null
        : Eshtablishment.fromJson(json['establishment']);
    userAddress = json['user_address'] != null
        ? UserAddress.fromJson(json['user_address'])
        : null;
    netAmount = json['net_amount'] ?? 0.0;
    orderTaker = json['order_taker'] != null
        ? OrderTaker.fromJson(json['order_taker'])
        : null;
    deliveryCustomer = json['delivery_customer'] != null
        ? DeliveryCustomer.fromJson(json['delivery_customer'])
        : null;
    mobileCustomer = json['mobile_customer'] != null
        ? MobileCustomer.fromJson(json['mobile_customer'])
        : null;
    if (json['transactions'] != null) {
      transactions = <Transactions>[];
      json['transactions'].forEach((v) {
        transactions!.add(Transactions.fromJson(v));
      });
    }
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
    data['tax'] = tax;
    data['establishment_id'] = establishmentId;
    data['user_address_id'] = userAddressId;
    data['type'] = type;
    data['delivery_customer_id'] = deliveryCustomerId;
    data['rider_id'] = riderId;
    data['status'] = status;
    data['establishment'] = establishment;
    data['payment_status'] = paymentStatus;
    data['gross_amount'] = grossAmount;
    data['payment_type'] = paymentType;
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
    if (deliveryCustomer != null) {
      data['delivery_customer'] = deliveryCustomer!.toJson();
    }
    if (mobileCustomer != null) {
      data['mobile_customer'] = mobileCustomer!.toJson();
    }
    if (transactions != null) {
      data['transactions'] = transactions!.map((v) => v.toJson()).toList();
    }
    if (orderItems != null) {
      data['order_items'] = orderItems!.map((v) => v.toJson()).toList();
    }
    if (userAddress != null) {
      data['user_address'] = userAddress!.toJson();
    }
    data['created_ago'] = createdAgo;
    data['status_text'] = statusText;
    data['payment_status_text'] = paymentStatusText;
    data['type_text'] = typeText;
    return data;
  }
}

class UserAddress {
  int? id;
  String? name;
  String? address;
  String? city;
  String? state;
  String? landmark;
  String? phone;
  String? alternatePhone;
  int? addressType;
  int? userId;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  int? zipCode;
  int? isVerified;
  String? verificationCode;
  int? establishmentId;
  String? createdAgo;

  UserAddress({
    this.id,
    this.name,
    this.address,
    this.city,
    this.state,
    this.landmark,
    this.phone,
    this.alternatePhone,
    this.addressType,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.zipCode,
    this.isVerified,
    this.verificationCode,
    this.establishmentId,
    this.createdAgo,
  });

  UserAddress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    landmark = json['landmark'];
    phone = json['phone'];
    alternatePhone = json['alternate_phone'] ?? "-";
    addressType = json['address_type'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    zipCode = json['zip_code'];
    isVerified = json['is_verified'];
    verificationCode = json['verification_code'];
    establishmentId = json['establishment_id'];
    createdAgo = json['created_ago'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['address'] = address;
    data['city'] = city;
    data['state'] = state;
    data['landmark'] = landmark;
    data['phone'] = phone;
    data['alternate_phone'] = alternatePhone;
    data['address_type'] = addressType;
    data['user_id'] = userId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['zip_code'] = zipCode;
    data['is_verified'] = isVerified;
    data['verification_code'] = verificationCode;
    data['establishment_id'] = establishmentId;
    data['created_ago'] = createdAgo;
    return data;
  }
}

class MobileCustomer {
  String? fullName;
  int? id;

  MobileCustomer({this.fullName, this.id});

  MobileCustomer.fromJson(Map<String, dynamic> json) {
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

class DeliveryCustomer {
  int? id;
  String? name;
  String? mobileNumber;
  String? address;
  String? landmark;
  String? alternatePhone;
  int? addressType;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? createdAgo;

  DeliveryCustomer({
    this.id,
    this.name,
    this.mobileNumber,
    this.address,
    this.landmark,
    this.alternatePhone,
    this.addressType,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.createdAgo,
  });

  DeliveryCustomer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobileNumber = json['mobile_number'];
    address = json['address'];
    landmark = json['landmark'];
    alternatePhone = json['alternate_phone'];
    addressType = json['address_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    createdAgo = json['created_ago'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['mobile_number'] = mobileNumber;
    data['address'] = address;
    data['landmark'] = landmark;
    data['alternate_phone'] = alternatePhone;
    data['address_type'] = addressType;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['created_ago'] = createdAgo;
    return data;
  }
}

class Transactions {
  int? id;
  int? refId;
  int? establishmentId;
  int? refType;
  num? amountReceived;
  num? amountReturned;
  int? sourceType;
  int? createdById;
  String? updatedById;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  GatewayTransaction? gatewayTransaction;
  String? createdAgo;
  String? refTypeText;
  String? sourceTypeText;
  num? netAmountReceived;

  Transactions({
    this.id,
    this.refId,
    this.establishmentId,
    this.refType,
    this.amountReceived,
    this.amountReturned,
    this.sourceType,
    this.createdById,
    this.updatedById,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.gatewayTransaction,
    this.createdAgo,
    this.refTypeText,
    this.sourceTypeText,
    this.netAmountReceived,
  });

  // String get sourceTypeString => PaymentType.getNameFromValue(sourceType!);

  Transactions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    refId = json['ref_id'];
    establishmentId = json['establishment_id'];
    refType = json['ref_type'];
    amountReceived = json['amount_received'];
    amountReturned = json['amount_returned'];
    sourceType = json['source_type'];
    createdById = json['created_by_id'];
    updatedById = json['updated_by_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    gatewayTransaction = json['gateway_transaction'] != null
        ? GatewayTransaction.fromJson(json['gateway_transaction'])
        : null;
    createdAgo = json['created_ago'];
    refTypeText = json['ref_type_text'];
    sourceTypeText = json['source_type_text'];
    netAmountReceived = json['net_amount_received'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['ref_id'] = refId;
    data['establishment_id'] = establishmentId;
    data['ref_type'] = refType;
    data['amount_received'] = amountReceived;
    data['amount_returned'] = amountReturned;
    data['source_type'] = sourceType;
    data['created_by_id'] = createdById;
    data['updated_by_id'] = updatedById;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['gateway_transaction'] = gatewayTransaction!.toJson();
    data['created_ago'] = createdAgo;
    data['ref_type_text'] = refTypeText;
    data['source_type_text'] = sourceTypeText;
    data['net_amount_received'] = netAmountReceived;
    return data;
  }
}

class GatewayTransaction {
  int? id;
  int? transactionId;
  String? gatewayTransactionId;
  String? paymentMethodId;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? createdAgo;

  GatewayTransaction({
    this.id,
    this.transactionId,
    this.gatewayTransactionId,
    this.paymentMethodId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.createdAgo,
  });

  GatewayTransaction.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    transactionId = json['transaction_id'];
    gatewayTransactionId = json['gateway_transaction_id'];
    paymentMethodId = json['payment_method_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    createdAgo = json['created_ago'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['transaction_id'] = transactionId;
    data['gateway_transaction_id'] = gatewayTransactionId;
    data['payment_method_id'] = paymentMethodId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['created_ago'] = createdAgo;
    return data;
  }
}
