class User {
  int? id;
  String? email;
  String? fullName;
  int? isVerified;
  String? phone;
  String? image;
  int? isCompleted;
  int? isSocialLogin;
  int? isApproved;
  int? createdById;
  int? updatedById;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  int? pushNotification;
  UserBusinessDetail? userBusinessDetail;
  List<Roles>? roles;
  String? createdAgo;
  Meta? meta;

  bool get verified => isVerified == 1;

  User(
      {this.id,
      this.email,
      this.fullName,
      this.isVerified,
      this.phone,
      this.image,
      this.isCompleted,
      this.isSocialLogin,
      this.isApproved,
      this.createdById,
      this.updatedById,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.pushNotification,
      this.userBusinessDetail,
      this.roles,
      this.createdAgo,
      this.meta});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    fullName = json['full_name'];
    isVerified = json['is_verified'];
    phone = json['phone'];
    image = json['image'];
    isCompleted = json['is_completed'];
    isSocialLogin = json['is_social_login'];
    isApproved = json['is_approved'];
    createdById = json['created_by_id'];
    updatedById = json['updated_by_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    pushNotification = json['push_notification'];
    userBusinessDetail = json['userBusinessDetail'] != null
        ? new UserBusinessDetail.fromJson(json['userBusinessDetail'])
        : null;
    if (json['roles'] != null) {
      roles = <Roles>[];
      json['roles'].forEach((v) {
        roles!.add(new Roles.fromJson(v));
      });
    }
    createdAgo = json['created_ago'];
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['full_name'] = this.fullName;
    data['is_verified'] = this.isVerified;
    data['phone'] = this.phone;
    data['image'] = this.image;
    data['is_completed'] = this.isCompleted;
    data['is_social_login'] = this.isSocialLogin;
    data['is_approved'] = this.isApproved;
    data['created_by_id'] = this.createdById;
    data['updated_by_id'] = this.updatedById;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['push_notification'] = this.pushNotification;
    if (this.userBusinessDetail != null) {
      data['userBusinessDetail'] = this.userBusinessDetail!.toJson();
    }
    if (this.roles != null) {
      data['roles'] = this.roles!.map((v) => v.toJson()).toList();
    }
    data['created_ago'] = this.createdAgo;
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    return data;
  }
}

class UserBusinessDetail {
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

  UserBusinessDetail(
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

  UserBusinessDetail.fromJson(Map<String, dynamic> json) {
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

class Roles {
  int? id;
  String? name;
  String? displayName;
  String? description;
  int? createdById;
  int? updatedById;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  List<String>? permissions;
  String? createdAgo;

  Roles(
      {this.id,
      this.name,
      this.displayName,
      this.description,
      this.createdById,
      this.updatedById,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.permissions,
      this.createdAgo});

  Roles.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    displayName = json['display_name'];
    description = json['description'];
    createdById = json['created_by_id'];
    updatedById = json['updated_by_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    permissions = json['permissions'].cast<String>();
    createdAgo = json['created_ago'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['display_name'] = this.displayName;
    data['description'] = this.description;
    data['created_by_id'] = this.createdById;
    data['updated_by_id'] = this.updatedById;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['permissions'] = this.permissions;
    data['created_ago'] = this.createdAgo;
    return data;
  }
}

class Meta {
  Null? username;
  String? verificationCode;
  Null? pin;
  Null? socialPlatform;
  Null? clientId;
  Null? token;
  Null? lastLoginAt;

  Meta(
      {this.username,
      this.verificationCode,
      this.pin,
      this.socialPlatform,
      this.clientId,
      this.token,
      this.lastLoginAt});

  Meta.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    verificationCode = json['verification_code'];
    pin = json['pin'];
    socialPlatform = json['social_platform'];
    clientId = json['client_id'];
    token = json['token'];
    lastLoginAt = json['last_login_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['verification_code'] = this.verificationCode;
    data['pin'] = this.pin;
    data['social_platform'] = this.socialPlatform;
    data['client_id'] = this.clientId;
    data['token'] = this.token;
    data['last_login_at'] = this.lastLoginAt;
    return data;
  }
}
