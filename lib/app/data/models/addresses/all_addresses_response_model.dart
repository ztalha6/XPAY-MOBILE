import 'package:serveeasy_app/app/data/models/base_response_model.dart';

class AllAddressesResponse extends BaseApiResponse {
  Data? data;

  AllAddressesResponse({this.data});

  AllAddressesResponse.fromJson(Map<String, dynamic> json) {
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
  List<Address>? addresses;

  Data({this.meta, this.addresses});

  Data.fromJson(Map<String, dynamic> json) {
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    if (json['data'] != null) {
      addresses = <Address>[];
      json['data'].forEach((v) {
        addresses!.add(Address.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    if (addresses != null) {
      data['data'] = addresses!.map((v) => v.toJson()).toList();
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

class Address {
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
  double? lat;
  double? lng;
  String? createdAgo;

  bool get isSavedOnBackend => id != null;

  bool get isAddressVerified => isVerified == 1;

  Address({
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
    this.lat,
    this.lng,
    this.createdAgo,
  });

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    landmark = json['landmark'];
    phone = json['phone'];
    alternatePhone = json['alternate_phone'];
    addressType = json['address_type'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    zipCode = json['zip_code'];
    isVerified = json['is_verified'];
    verificationCode = json['verification_code'];
    establishmentId = json['establishment_id'];
    lat = json['lat'];
    lng = json['lng'];
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
    data['lat'] = lat;
    data['lng'] = lng;
    data['created_ago'] = createdAgo;
    return data;
  }
}
