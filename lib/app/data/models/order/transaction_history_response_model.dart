import 'package:serveeasy_app/app/data/models/base_response_model.dart';

class TransactionHistoryResponse extends BaseApiResponse {
  Data? data;

  TransactionHistoryResponse({this.data});

  TransactionHistoryResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  Meta? meta;
  List<Transaction>? data;

  Data({this.meta, this.data});

  Data.fromJson(Map<String, dynamic> json) {
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    if (json['data'] != null) {
      data = <Transaction>[];
      json['data'].forEach((v) {
        data!.add(new Transaction.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
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
  Null? nextPageUrl;
  Null? previousPageUrl;

  Meta(
      {this.total,
      this.perPage,
      this.currentPage,
      this.lastPage,
      this.firstPage,
      this.firstPageUrl,
      this.lastPageUrl,
      this.nextPageUrl,
      this.previousPageUrl});

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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['per_page'] = this.perPage;
    data['current_page'] = this.currentPage;
    data['last_page'] = this.lastPage;
    data['first_page'] = this.firstPage;
    data['first_page_url'] = this.firstPageUrl;
    data['last_page_url'] = this.lastPageUrl;
    data['next_page_url'] = this.nextPageUrl;
    data['previous_page_url'] = this.previousPageUrl;
    return data;
  }
}

class Transaction {
  int? id;
  String? paymentIntentId;
  String? paymentMethodId;
  int? amount;
  String? status;
  int? vendorId;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  int? guestUserId;
  List<PaymentOrderItems>? paymentOrderItems;
  GuestUser? guestUser;
  VendorBusinessDetail? vendorBusinessDetail;
  String? createdAgo;

  Transaction(
      {this.id,
      this.paymentIntentId,
      this.paymentMethodId,
      this.amount,
      this.status,
      this.vendorId,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.guestUserId,
      this.paymentOrderItems,
      this.guestUser,
      this.vendorBusinessDetail,
      this.createdAgo});

  Transaction.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    paymentIntentId = json['payment_intent_id'];
    paymentMethodId = json['payment_method_id'];
    amount = json['amount'];
    status = json['status'];
    vendorId = json['vendor_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    guestUserId = json['guest_user_id'];
    if (json['payment_order_items'] != null) {
      paymentOrderItems = <PaymentOrderItems>[];
      json['payment_order_items'].forEach((v) {
        paymentOrderItems!.add(new PaymentOrderItems.fromJson(v));
      });
    }
    guestUser = json['guest_user'] != null
        ? new GuestUser.fromJson(json['guest_user'])
        : null;
    vendorBusinessDetail = json['vendor_business_detail'] != null
        ? new VendorBusinessDetail.fromJson(json['vendor_business_detail'])
        : null;
    createdAgo = json['created_ago'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['payment_intent_id'] = this.paymentIntentId;
    data['payment_method_id'] = this.paymentMethodId;
    data['amount'] = this.amount;
    data['status'] = this.status;
    data['vendor_id'] = this.vendorId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['guest_user_id'] = this.guestUserId;
    if (this.paymentOrderItems != null) {
      data['payment_order_items'] =
          this.paymentOrderItems!.map((v) => v.toJson()).toList();
    }
    if (this.guestUser != null) {
      data['guest_user'] = this.guestUser!.toJson();
    }
    if (this.vendorBusinessDetail != null) {
      data['vendor_business_detail'] = this.vendorBusinessDetail!.toJson();
    }
    data['created_ago'] = this.createdAgo;
    return data;
  }
}

class PaymentOrderItems {
  int? id;
  String? name;
  int? price;
  String? extra;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  int? qty;
  int? paymentId;
  String? createdAgo;

  PaymentOrderItems(
      {this.id,
      this.name,
      this.price,
      this.extra,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.qty,
      this.paymentId,
      this.createdAgo});

  PaymentOrderItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    extra = json['extra'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    qty = json['qty'];
    paymentId = json['payment_id'];
    createdAgo = json['created_ago'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['extra'] = this.extra;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['qty'] = this.qty;
    data['payment_id'] = this.paymentId;
    data['created_ago'] = this.createdAgo;
    return data;
  }
}

class GuestUser {
  int? id;
  String? verificationCode;
  String? phone;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? createdAgo;

  GuestUser(
      {this.id,
      this.verificationCode,
      this.phone,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.createdAgo});

  GuestUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    verificationCode = json['verification_code'];
    phone = json['phone'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    createdAgo = json['created_ago'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['verification_code'] = this.verificationCode;
    data['phone'] = this.phone;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['created_ago'] = this.createdAgo;
    return data;
  }
}

class VendorBusinessDetail {
  int? id;
  String? businessName;
  String? businessAddress;
  String? bankAccountNumber;
  String? bankRoutingNumber;
  String? taxIdNumber;
  String? apiKey;
  int? userId;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? websiteUrl;
  String? createdAgo;

  VendorBusinessDetail(
      {this.id,
      this.businessName,
      this.businessAddress,
      this.bankAccountNumber,
      this.bankRoutingNumber,
      this.taxIdNumber,
      this.apiKey,
      this.userId,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.websiteUrl,
      this.createdAgo});

  VendorBusinessDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    businessName = json['business_name'];
    businessAddress = json['business_address'];
    bankAccountNumber = json['bank_account_number'];
    bankRoutingNumber = json['bank_routing_number'];
    taxIdNumber = json['tax_id_number'];
    apiKey = json['api_key'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    websiteUrl = json['website_url'];
    createdAgo = json['created_ago'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['business_name'] = this.businessName;
    data['business_address'] = this.businessAddress;
    data['bank_account_number'] = this.bankAccountNumber;
    data['bank_routing_number'] = this.bankRoutingNumber;
    data['tax_id_number'] = this.taxIdNumber;
    data['api_key'] = this.apiKey;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['website_url'] = this.websiteUrl;
    data['created_ago'] = this.createdAgo;
    return data;
  }
}
