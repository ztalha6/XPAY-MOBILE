import 'package:serveeasy_app/app/data/models/base_response_model.dart';
import 'package:serveeasy_app/app/data/models/menu/menu_data_response_model.dart';

class DealModifierResponse extends BaseApiResponse {
  Data? data;

  DealModifierResponse({this.data});

  DealModifierResponse.fromJson(Map<String, dynamic> json) {
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
  int? establishmentId;
  String? name;
  int? type;
  int? status;
  int? createdById;
  String? updatedById;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  Establishment? establishment;
  String? updatedBy;
  CreatedBy? createdBy;
  EntityTimetables? entityTimetables;
  List<DealComboItems>? dealComboItems;
  String? createdAgo;
  String? typeText;
  String? statusText;
  int? totalSalePrice;

  Data({
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
    this.establishment,
    this.updatedBy,
    this.createdBy,
    this.entityTimetables,
    this.dealComboItems,
    this.createdAgo,
    this.typeText,
    this.statusText,
    this.totalSalePrice,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    establishmentId = json['establishment_id'];
    name = json['name'];
    type = json['type'];
    status = json['status'];
    createdById = json['created_by_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    establishment = json['establishment'] != null
        ? Establishment.fromJson(json['establishment'])
        : null;
    createdBy = json['created_by'] != null
        ? CreatedBy.fromJson(json['created_by'])
        : null;
    entityTimetables = json['entity_timetables'] != null
        ? EntityTimetables.fromJson(json['entity_timetables'])
        : null;
    if (json['deal_combo_items'] != null) {
      dealComboItems = <DealComboItems>[];
      json['deal_combo_items'].forEach((v) {
        dealComboItems!.add(DealComboItems.fromJson(v));
      });
    }
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
    if (establishment != null) {
      data['establishment'] = establishment!.toJson();
    }
    data['updated_by'] = updatedBy;
    if (createdBy != null) {
      data['created_by'] = createdBy!.toJson();
    }
    if (entityTimetables != null) {
      data['entity_timetables'] = entityTimetables!.toJson();
    }
    if (dealComboItems != null) {
      data['deal_combo_items'] =
          dealComboItems!.map((v) => v.toJson()).toList();
    }
    data['created_ago'] = createdAgo;
    data['type_text'] = typeText;
    data['status_text'] = statusText;
    data['total_sale_price'] = totalSalePrice;

    return data;
  }
}

class Establishment {
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

  Establishment({
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

  Establishment.fromJson(Map<String, dynamic> json) {
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

class CreatedBy {
  String? fullName;
  int? id;
  UserRestaurant? userRestaurant;
  List<Roles>? roles;

  CreatedBy({this.fullName, this.id, this.userRestaurant, this.roles});

  CreatedBy.fromJson(Map<String, dynamic> json) {
    fullName = json['full_name'];
    id = json['id'];
    userRestaurant = json['user_restaurant'] != null
        ? UserRestaurant.fromJson(json['user_restaurant'])
        : null;
    if (json['roles'] != null) {
      roles = <Roles>[];
      json['roles'].forEach((v) {
        roles!.add(Roles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['full_name'] = fullName;
    data['id'] = id;
    if (userRestaurant != null) {
      data['user_restaurant'] = userRestaurant!.toJson();
    }
    if (roles != null) {
      data['roles'] = roles!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserRestaurant {
  int? id;
  int? userId;
  int? restaurantId;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? createdAgo;

  UserRestaurant({
    this.id,
    this.userId,
    this.restaurantId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.createdAgo,
  });

  UserRestaurant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    restaurantId = json['restaurant_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    createdAgo = json['created_ago'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['restaurant_id'] = restaurantId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['created_ago'] = createdAgo;
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

  Permissions({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.createdAgo,
  });

  Permissions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    createdAgo = json['created_ago'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['created_ago'] = createdAgo;

    return data;
  }
}

class EntityTimetables {
  int? id;
  int? entityId;
  int? entityType;
  int? status;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  List<Timetables>? timetables;
  String? createdAgo;

  EntityTimetables({
    this.id,
    this.entityId,
    this.entityType,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.timetables,
    this.createdAgo,
  });

  EntityTimetables.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    entityId = json['entity_id'];
    entityType = json['entity_type'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    if (json['timetables'] != null) {
      timetables = <Timetables>[];
      json['timetables'].forEach((v) {
        timetables!.add(Timetables.fromJson(v));
      });
    }
    createdAgo = json['created_ago'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['entity_id'] = entityId;
    data['entity_type'] = entityType;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    if (timetables != null) {
      data['timetables'] = timetables!.map((v) => v.toJson()).toList();
    }
    data['created_ago'] = createdAgo;
    return data;
  }
}

class Timetables {
  int? id;
  String? startTime;
  String? endTime;
  int? dayId;
  int? entityTimetableId;
  String? fromDate;
  int? status;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  Day? day;
  String? createdAgo;

  Timetables({
    this.id,
    this.startTime,
    this.endTime,
    this.dayId,
    this.entityTimetableId,
    this.fromDate,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.day,
    this.createdAgo,
  });

  Timetables.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    dayId = json['day_id'];
    entityTimetableId = json['entity_timetable_id'];
    fromDate = json['from_date'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    day = json['day'] != null ? Day.fromJson(json['day']) : null;
    createdAgo = json['created_ago'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['day_id'] = dayId;
    data['entity_timetable_id'] = entityTimetableId;
    data['from_date'] = fromDate;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    if (day != null) {
      data['day'] = day!.toJson();
    }
    data['created_ago'] = createdAgo;
    return data;
  }
}

class Day {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? createdAgo;

  Day({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.createdAgo,
  });

  Day.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    createdAgo = json['created_ago'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['created_ago'] = createdAgo;
    return data;
  }
}

class Products {
  int? id;
  int? productId;
  int? dealComboItemId;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  Product? product;
  String? createdAgo;

  Products({
    this.id,
    this.productId,
    this.dealComboItemId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.product,
    this.createdAgo,
  });

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    dealComboItemId = json['deal_combo_item_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
    createdAgo = json['created_ago'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product_id'] = productId;
    data['deal_combo_item_id'] = dealComboItemId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    if (product != null) {
      data['product'] = product!.toJson();
    }
    data['created_ago'] = createdAgo;
    return data;
  }
}

// class Product {
//   int? id;
//   String? name;
//   String? description;
//   int? soldByWeight;
//   int? isShipping;
//   int? sku;
//   int? status;
//   int? categoryId;
//   int? establishmentId;
//   int? createdById;
//   int? updatedById;
//   String? createdAt;
//   String? updatedAt;
//   String? deletedAt;
//   int? barcode;
//   int? stockAmount;
//   int? cost;
//   int? price;
//   String? createdAgo;
//   bool? isProduct;
//   String? statusText;

//   Product({
//     this.id,
//     this.name,
//     this.description,
//     this.soldByWeight,
//     this.isShipping,
//     this.sku,
//     this.status,
//     this.categoryId,
//     this.establishmentId,
//     this.createdById,
//     this.updatedById,
//     this.createdAt,
//     this.updatedAt,
//     this.deletedAt,
//     this.barcode,
//     this.stockAmount,
//     this.cost,
//     this.price,
//     this.createdAgo,
//     this.isProduct,
//     this.statusText,
//   });

//   Product.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     description = json['description'];
//     soldByWeight = json['sold_by_weight'];
//     isShipping = json['is_shipping'];
//     sku = json['sku'];
//     status = json['status'];
//     categoryId = json['category_id'];
//     establishmentId = json['establishment_id'];
//     createdById = json['created_by_id'];
//     updatedById = json['updated_by_id'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     deletedAt = json['deleted_at'];
//     barcode = json['barcode'];
//     stockAmount = json['stock_amount'];
//     cost = json['cost'];
//     price = json['price'];
//     createdAgo = json['created_ago'];
//     isProduct = json['is_product'];
//     statusText = json['status_text'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['name'] = name;
//     data['description'] = description;
//     data['sold_by_weight'] = soldByWeight;
//     data['is_shipping'] = isShipping;
//     data['sku'] = sku;
//     data['status'] = status;
//     data['category_id'] = categoryId;
//     data['establishment_id'] = establishmentId;
//     data['created_by_id'] = createdById;
//     data['updated_by_id'] = updatedById;
//     data['created_at'] = createdAt;
//     data['updated_at'] = updatedAt;
//     data['deleted_at'] = deletedAt;
//     data['barcode'] = barcode;
//     data['stock_amount'] = stockAmount;
//     data['cost'] = cost;
//     data['price'] = price;
//     data['created_ago'] = createdAgo;
//     data['is_product'] = isProduct;
//     data['status_text'] = statusText;
//     return data;
//   }
// }

class Category {
  int? id;
  String? name;
  int? parentId;
  int? parentSort;
  String? description;
  int? status;
  int? establishmentId;
  int? createdById;
  int? updatedById;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? categoryImage;
  String? createdAgo;
  String? statusText;
  bool? isCategory;
  bool? isSubcategory;

  Category({
    this.id,
    this.name,
    this.parentId,
    this.parentSort,
    this.description,
    this.status,
    this.establishmentId,
    this.createdById,
    this.updatedById,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.categoryImage,
    this.createdAgo,
    this.statusText,
    this.isCategory,
    this.isSubcategory,
  });

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    parentId = json['parent_id'];
    parentSort = json['parent_sort'];
    description = json['description'];
    status = json['status'];
    establishmentId = json['establishment_id'];
    createdById = json['created_by_id'];
    updatedById = json['updated_by_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    categoryImage = json['category_image'];
    createdAgo = json['created_ago'];
    statusText = json['status_text'];
    isCategory = json['is_category'];
    isSubcategory = json['is_subcategory'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['parent_id'] = parentId;
    data['parent_sort'] = parentSort;
    data['description'] = description;
    data['status'] = status;
    data['establishment_id'] = establishmentId;
    data['created_by_id'] = createdById;
    data['updated_by_id'] = updatedById;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['category_image'] = categoryImage;
    data['created_ago'] = createdAgo;
    data['status_text'] = statusText;
    data['is_category'] = isCategory;
    data['is_subcategory'] = isSubcategory;

    return data;
  }
}
