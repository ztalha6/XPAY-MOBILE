import 'package:serveeasy_app/app/data/models/addresses/all_addresses_response_model.dart';

class User {
  int? id;
  String? email;
  String? pin;
  String? fullName;
  int? establishmentId;
  int? orderType;
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
  String? cardToken;
  int? pushNotification;
  int? isGuest;
  List<dynamic>? restaurantAdminEstablishments;
  String? restaurantOfOwner;
  Eshtablishment? establishment;
  List<Roles>? roles;
  String? createdAgo;
  UserMeta? meta;
  int? selectedBranchId;
  String? branchName;
  int? cartId;
  int? dealId;
  int? lastOrderId;
  Address? addressDetail;

  User({
    this.id,
    this.cartId,
    this.lastOrderId,
    this.selectedBranchId,
    this.email,
    this.addressDetail,
    this.orderType,
    this.pin,
    this.cardToken,
    this.fullName,
    this.establishmentId,
    this.dealId,
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
    this.restaurantAdminEstablishments,
    this.restaurantOfOwner,
    this.establishment,
    this.roles,
    this.createdAgo,
    this.meta,
  });

  bool get verified => isVerified == 1;

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lastOrderId = json['lastOrderId'];
    if (json.containsKey("addressDetail")) {
      addressDetail = Address.fromJson(json['addressDetail']);
    }
    email = json['email'];
    cardToken = json['cardToken'];
    selectedBranchId = json['selectedBranchId'];
    branchName = json['branchName'];
    pin = json['pin'];
    fullName = json['full_name'];
    establishmentId = json['establishment_id'];
    isVerified = json['is_verified'];
    phone = json['phone'];
    image = json['image'];
    dealId = json['dealId'];
    address = json['address'];
    isCompleted = json['is_completed'];
    isSocialLogin = json['is_social_login'];
    isApproved = json['is_approved'];
    createdById = json['created_by_id'];
    updatedById = json['updated_by_id'];
    createdAt = json['created_at'];
    orderType = json['orderType'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    pushNotification = json['push_notification'];
    isGuest = json['is_guest'];
    if (json['restaurant_admin_establishments'] != null) {
      restaurantAdminEstablishments = <dynamic>[];
      json['restaurant_admin_establishments'].forEach((v) {
        restaurantAdminEstablishments!.add(v);
      });
    }
    restaurantOfOwner = json['restaurantOfOwner'];
    establishment = json['establishment'] == null
        ? null
        : Eshtablishment.fromJson(json['establishment']);
    if (json['roles'] != null) {
      roles = <Roles>[];
      json['roles'].forEach((v) {
        roles!.add(Roles.fromJson(v));
      });
    }
    createdAgo = json['created_ago'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['lastOrderId'] = lastOrderId;
    if (addressDetail != null) {
      data['addressDetail'] = addressDetail!.toJson();
    }
    data['email'] = email;
    data['cardToken'] = cardToken;
    data['selectedBranchId'] = selectedBranchId;
    data['branchName'] = branchName;
    data['pin'] = pin;
    data['full_name'] = fullName;
    data['dealId'] = dealId;
    data['establishment_id'] = establishmentId;
    data['is_verified'] = isVerified;
    data['phone'] = phone;
    data['image'] = image;
    data['address'] = address;
    data['is_completed'] = isCompleted;
    data['is_social_login'] = isSocialLogin;
    data['is_approved'] = isApproved;
    data['orderType'] = orderType;
    data['created_by_id'] = createdById;
    data['updated_by_id'] = updatedById;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['push_notification'] = pushNotification;
    data['is_guest'] = isGuest;
    if (restaurantAdminEstablishments != null) {
      data['restaurant_admin_establishments'] =
          restaurantAdminEstablishments!.map((v) => v.toJson()).toList();
    }
    data['restaurantOfOwner'] = restaurantOfOwner;
    data['establishment'] = establishment;
    if (roles != null) {
      data['roles'] = roles!.map((v) => v.toJson()).toList();
    }
    data['created_ago'] = createdAgo;
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    return data;
  }
}

class Eshtablishment {
  int? id;
  String? name;
  int? status;
  String? address;
  double? latitude;
  double? longitude;
  int? restaurantId;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  int? createdById;
  int? updatedById;
  int? posDevices;
  String? createdAgo;
  String? statusText;

  Eshtablishment({
    this.id,
    this.name,
    this.status,
    this.address,
    this.latitude,
    this.longitude,
    this.restaurantId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.createdById,
    this.updatedById,
    this.posDevices,
    this.createdAgo,
    this.statusText,
  });

  Eshtablishment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    restaurantId = json['restaurant_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    createdById = json['created_by_id'];
    updatedById = json['updated_by_id'];
    posDevices = json['pos_devices'];
    createdAgo = json['created_ago'];
    statusText = json['status_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['status'] = status;
    data['address'] = address;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['restaurant_id'] = restaurantId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['created_by_id'] = createdById;
    data['updated_by_id'] = updatedById;
    data['pos_devices'] = posDevices;
    data['created_ago'] = createdAgo;
    data['status_text'] = statusText;
    return data;
  }
}

class Roles {
  int? id;
  String? name;
  String? displayName;
  String? description;
  int? establishmentId;
  int? createdById;
  int? updatedById;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  List<Permissions>? permissions;
  String? createdAgo;

  Roles({
    this.id,
    this.name,
    this.displayName,
    this.description,
    this.establishmentId,
    this.createdById,
    this.updatedById,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.permissions,
    this.createdAgo,
  });

  Roles.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    displayName = json['display_name'];
    description = json['description'];
    establishmentId = json['establishment_id'];
    createdById = json['created_by_id'];
    updatedById = json['updated_by_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    if (json['permissions'] != null) {
      permissions = <Permissions>[];
      json['permissions'].forEach((v) {
        permissions!.add(Permissions.fromJson(v));
      });
    }
    createdAgo = json['created_ago'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['display_name'] = displayName;
    data['description'] = description;
    data['establishment_id'] = establishmentId;
    data['created_by_id'] = createdById;
    data['updated_by_id'] = updatedById;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    if (permissions != null) {
      data['permissions'] = permissions!.map((v) => v.toJson()).toList();
    }
    data['created_ago'] = createdAgo;
    return data;
  }
}

class Permissions {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? createdAgo;
  UserMeta? meta;

  Permissions({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.createdAgo,
    this.meta,
  });

  Permissions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    createdAgo = json['created_ago'];
    meta = json['meta'] != null ? UserMeta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['created_ago'] = createdAgo;
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    return data;
  }
}

class UserMeta {
  String? username;
  String? verificationCode;
  String? dob;
  String? city;
  String? zip;
  String? country;
  String? latitude;
  String? longitude;
  String? socialPlatform;
  String? clientId;
  String? token;
  String? lastLoginAt;
  String? companyName;
  String? businessType;

  UserMeta({
    this.username,
    this.verificationCode,
    this.dob,
    this.city,
    this.zip,
    this.country,
    this.latitude,
    this.longitude,
    this.socialPlatform,
    this.clientId,
    this.token,
    this.lastLoginAt,
    this.companyName,
    this.businessType,
  });

  UserMeta.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    verificationCode = json['verification_code'];
    dob = json['dob'];
    city = json['city'];
    zip = json['zip'];
    country = json['country'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    socialPlatform = json['social_platform'];
    clientId = json['client_id'];
    token = json['token'];
    lastLoginAt = json['last_login_at'];
    companyName = json['company_name'];
    businessType = json['business_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['verification_code'] = verificationCode;
    data['dob'] = dob;
    data['city'] = city;
    data['zip'] = zip;
    data['country'] = country;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['social_platform'] = socialPlatform;
    data['client_id'] = clientId;
    data['token'] = token;
    data['last_login_at'] = lastLoginAt;
    data['company_name'] = companyName;
    data['business_type'] = businessType;
    return data;
  }
}
