import 'package:serveeasy_app/app/data/models/base_response_model.dart';

class BranchListResponse extends BaseApiResponse {
  List<Branch>? branches;

  BranchListResponse({this.branches});

  BranchListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      branches = <Branch>[];
      json['data'].forEach((v) {
        branches!.add(Branch.fromJson(v));
      });
    }
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (branches != null) {
      data['data'] = branches!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Branch {
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
  List<EstablishmentOrderTypes>? establishmentOrderTypes;
  List<EstablishmentOnlineOrderTypes>? establishmentOnlineOrderTypes;
  String? createdAgo;
  String? statusText;

  Branch({
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
    this.establishmentOrderTypes,
    this.establishmentOnlineOrderTypes,
    this.createdAgo,
    this.statusText,
  });

  Branch.fromJson(Map<String, dynamic> json) {
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
    if (json['establishment_order_types'] != null) {
      establishmentOrderTypes = <EstablishmentOrderTypes>[];
      json['establishment_order_types'].forEach((v) {
        establishmentOrderTypes!.add(EstablishmentOrderTypes.fromJson(v));
      });
    }
    if (json['establishment_online_order_types'] != null) {
      establishmentOnlineOrderTypes = <EstablishmentOnlineOrderTypes>[];
      json['establishment_online_order_types'].forEach((v) {
        establishmentOnlineOrderTypes!
            .add(EstablishmentOnlineOrderTypes.fromJson(v));
      });
    }
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
    if (establishmentOrderTypes != null) {
      data['establishment_order_types'] =
          establishmentOrderTypes!.map((v) => v.toJson()).toList();
    }
    if (establishmentOnlineOrderTypes != null) {
      data['establishment_online_order_types'] =
          establishmentOnlineOrderTypes!.map((v) => v.toJson()).toList();
    }
    data['created_ago'] = createdAgo;
    data['status_text'] = statusText;
    return data;
  }
}

class EstablishmentOrderTypes {
  int? id;
  int? orderType;
  int? establishmentId;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? createdAgo;

  EstablishmentOrderTypes({
    this.id,
    this.orderType,
    this.establishmentId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.createdAgo,
  });

  EstablishmentOrderTypes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderType = json['order_type'];
    establishmentId = json['establishment_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    createdAgo = json['created_ago'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['order_type'] = orderType;
    data['establishment_id'] = establishmentId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['created_ago'] = createdAgo;
    return data;
  }
}

class EstablishmentOnlineOrderTypes {
  int? id;
  int? onlineOrderType;
  int? establishmentId;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? createdAgo;

  EstablishmentOnlineOrderTypes({
    this.id,
    this.onlineOrderType,
    this.establishmentId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.createdAgo,
  });

  EstablishmentOnlineOrderTypes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    onlineOrderType = json['online_order_type'];
    establishmentId = json['establishment_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    createdAgo = json['created_ago'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['online_order_type'] = onlineOrderType;
    data['establishment_id'] = establishmentId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['created_ago'] = createdAgo;
    return data;
  }
}
