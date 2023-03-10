import 'package:serveeasy_app/app/data/models/base_response_model.dart';

class DisputeDetailResponse extends BaseApiResponse {
  List<Dispute>? data;

  DisputeDetailResponse({this.data});

  DisputeDetailResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Dispute>[];
      json['data'].forEach((v) {
        data!.add(new Dispute.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Dispute {
  int? id;
  String? comments;
  int? disputeStatus;
  int? paymentId;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  List<DisputeMedia>? disputeMedia;
  Payment? payment;
  String? createdAgo;
  String? disputeStatusText;

  Dispute(
      {this.id,
      this.comments,
      this.disputeStatus,
      this.paymentId,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.disputeMedia,
      this.payment,
      this.createdAgo,
      this.disputeStatusText});

  Dispute.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    comments = json['comments'];
    disputeStatus = json['dispute_status'];
    paymentId = json['payment_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    if (json['dispute_media'] != null) {
      disputeMedia = <DisputeMedia>[];
      json['dispute_media'].forEach((v) {
        disputeMedia!.add(new DisputeMedia.fromJson(v));
      });
    }
    payment =
        json['payment'] != null ? new Payment.fromJson(json['payment']) : null;
    createdAgo = json['created_ago'];
    disputeStatusText = json['dispute_status_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['comments'] = this.comments;
    data['dispute_status'] = this.disputeStatus;
    data['payment_id'] = this.paymentId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    if (this.disputeMedia != null) {
      data['dispute_media'] =
          this.disputeMedia!.map((v) => v.toJson()).toList();
    }
    if (this.payment != null) {
      data['payment'] = this.payment!.toJson();
    }
    data['created_ago'] = this.createdAgo;
    data['dispute_status_text'] = this.disputeStatusText;
    return data;
  }
}

class DisputeMedia {
  int? id;
  String? path;
  int? instanceType;
  int? instanceId;
  String? mimeType;
  String? thumbnail;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? duration;
  String? createdAgo;
  String? mediaUrl;
  String? thumbnailUrl;

  DisputeMedia(
      {this.id,
      this.path,
      this.instanceType,
      this.instanceId,
      this.mimeType,
      this.thumbnail,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.duration,
      this.createdAgo,
      this.mediaUrl,
      this.thumbnailUrl});

  DisputeMedia.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    path = json['path'];
    instanceType = json['instance_type'];
    instanceId = json['instance_id'];
    mimeType = json['mime_type'];
    thumbnail = json['thumbnail'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    duration = json['duration'];
    createdAgo = json['created_ago'];
    mediaUrl = json['mediaUrl'];
    thumbnailUrl = json['thumbnailUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['path'] = this.path;
    data['instance_type'] = this.instanceType;
    data['instance_id'] = this.instanceId;
    data['mime_type'] = this.mimeType;
    data['thumbnail'] = this.thumbnail;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['duration'] = this.duration;
    data['created_ago'] = this.createdAgo;
    data['mediaUrl'] = this.mediaUrl;
    data['thumbnailUrl'] = this.thumbnailUrl;
    return data;
  }
}

class Payment {
  int? id;
  String? paymentIntentId;
  String? paymentMethodId;
  int? amount;
  String? status;
  int? vendorId;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;
  int? guestUserId;
  VendorBusinessDetail? vendorBusinessDetail;
  GuestUser? guestUser;
  String? createdAgo;

  Payment(
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
      this.vendorBusinessDetail,
      this.guestUser,
      this.createdAgo});

  Payment.fromJson(Map<String, dynamic> json) {
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
    vendorBusinessDetail = json['vendor_business_detail'] != null
        ? new VendorBusinessDetail.fromJson(json['vendor_business_detail'])
        : null;
    guestUser = json['guest_user'] != null
        ? new GuestUser.fromJson(json['guest_user'])
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
    if (this.vendorBusinessDetail != null) {
      data['vendor_business_detail'] = this.vendorBusinessDetail!.toJson();
    }
    if (this.guestUser != null) {
      data['guest_user'] = this.guestUser!.toJson();
    }
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
