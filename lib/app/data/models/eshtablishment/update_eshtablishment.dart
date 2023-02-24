import 'package:serveeasy_app/app/data/models/base_response_model.dart';

class UpdateUserEshtablishmentResponse extends BaseApiResponse {
  Data? data;

  UpdateUserEshtablishmentResponse({this.data});

  UpdateUserEshtablishmentResponse.fromJson(Map<String, dynamic> json) {
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
  String? email;
  int? pin;
  String? fullName;
  int? establishmentId;
  int? isVerified;
  String? phone;
  String? image;
  String? address;
  int? isCompleted;
  int? isSocialLogin;
  int? isApproved;
  int? createdById;
  int? updatedById;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  int? pushNotification;
  int? isGuest;
  String? createdAgo;

  Data({
    this.id,
    this.email,
    this.pin,
    this.fullName,
    this.establishmentId,
    this.isVerified,
    this.phone,
    this.image,
    this.address,
    this.isCompleted,
    this.isSocialLogin,
    this.isApproved,
    this.createdById,
    this.updatedById,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.pushNotification,
    this.isGuest,
    this.createdAgo,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    pin = json['pin'];
    fullName = json['full_name'];
    establishmentId = json['establishment_id'];
    isVerified = json['is_verified'];
    phone = json['phone'];
    image = json['image'];
    address = json['address'];
    isCompleted = json['is_completed'];
    isSocialLogin = json['is_social_login'];
    isApproved = json['is_approved'];
    createdById = json['created_by_id'];
    updatedById = json['updated_by_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    pushNotification = json['push_notification'];
    isGuest = json['is_guest'];
    createdAgo = json['created_ago'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['pin'] = pin;
    data['full_name'] = fullName;
    data['establishment_id'] = establishmentId;
    data['is_verified'] = isVerified;
    data['phone'] = phone;
    data['image'] = image;
    data['address'] = address;
    data['is_completed'] = isCompleted;
    data['is_social_login'] = isSocialLogin;
    data['is_approved'] = isApproved;
    data['created_by_id'] = createdById;
    data['updated_by_id'] = updatedById;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['push_notification'] = pushNotification;
    data['is_guest'] = isGuest;
    data['created_ago'] = createdAgo;
    return data;
  }
}
