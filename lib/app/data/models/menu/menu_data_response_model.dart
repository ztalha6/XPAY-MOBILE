import 'package:serveeasy_app/app/data/models/base_response_model.dart';

class MenuDataResponse extends BaseApiResponse {
  MenuData? data;

  MenuDataResponse({this.data});

  MenuDataResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? MenuData.fromJson(json['data']) : null;
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

class MenuData {
  int? id;
  String? name;
  String? description;
  int? establishmentId;
  int? createdById;
  int? updatedById;
  int? status;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  CreatedBy? createdBy;
  CreatedBy? updatedBy;
  List<OrderTypes>? orderTypes;
  List<DealsCombos>? dealsCombos;
  String? createdAgo;
  String? statusText;
  Meta? meta;
  List<TimeTables>? timeTables;
  List<Menu>? menu;

  MenuData({
    this.id,
    this.name,
    this.description,
    this.establishmentId,
    this.createdById,
    this.updatedById,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.createdBy,
    this.updatedBy,
    this.orderTypes,
    this.dealsCombos,
    this.createdAgo,
    this.statusText,
    this.meta,
    this.timeTables,
    this.menu,
  });

  MenuData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    establishmentId = json['establishment_id'];
    createdById = json['created_by_id'];
    updatedById = json['updated_by_id'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    createdBy = json['created_by'] != null
        ? CreatedBy.fromJson(json['created_by'])
        : null;
    updatedBy = json['updated_by'] != null
        ? CreatedBy.fromJson(json['updated_by'])
        : null;
    if (json['order_types'] != null) {
      orderTypes = <OrderTypes>[];
      json['order_types'].forEach((v) {
        orderTypes!.add(OrderTypes.fromJson(v));
      });
    }
    if (json['deals_combos'] != null) {
      dealsCombos = <DealsCombos>[];
      json['deals_combos'].forEach((v) {
        dealsCombos!.add(DealsCombos.fromJson(v));
      });
    }
    createdAgo = json['created_ago'];
    statusText = json['status_text'];
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    if (json['time_tables'] != null) {
      timeTables = <TimeTables>[];
      json['time_tables'].forEach((v) {
        timeTables!.add(TimeTables.fromJson(v));
      });
    }
    if (json['menu'] != null) {
      menu = <Menu>[];
      json['menu'].forEach((v) {
        menu!.add(Menu.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['establishment_id'] = establishmentId;
    data['created_by_id'] = createdById;
    data['updated_by_id'] = updatedById;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    if (createdBy != null) {
      data['created_by'] = createdBy!.toJson();
    }
    if (updatedBy != null) {
      data['updated_by'] = updatedBy!.toJson();
    }
    if (orderTypes != null) {
      data['order_types'] = orderTypes!.map((v) => v.toJson()).toList();
    }
    if (dealsCombos != null) {
      data['deals_combos'] = dealsCombos!.map((v) => v.toJson()).toList();
    }
    data['created_ago'] = createdAgo;
    data['status_text'] = statusText;
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    if (timeTables != null) {
      data['time_tables'] = timeTables!.map((v) => v.toJson()).toList();
    }
    if (menu != null) {
      data['menu'] = menu!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CreatedBy {
  String? fullName;
  int? id;
  Meta? meta;

  CreatedBy({this.fullName, this.id, this.meta});

  CreatedBy.fromJson(Map<String, dynamic> json) {
    fullName = json['full_name'];
    id = json['id'];
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['full_name'] = fullName;
    data['id'] = id;
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    return data;
  }
}

class OrderTypes {
  int? id;
  int? customMenuId;
  int? type;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? createdAgo;
  String? typeText;
  Meta? meta;

  OrderTypes({
    this.id,
    this.customMenuId,
    this.type,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.createdAgo,
    this.typeText,
    this.meta,
  });

  OrderTypes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customMenuId = json['custom_menu_id'];
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    createdAgo = json['created_ago'];
    typeText = json['type_text'];
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['custom_menu_id'] = customMenuId;
    data['type'] = type;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['created_ago'] = createdAgo;
    data['type_text'] = typeText;
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    return data;
  }
}

class DealsCombos {
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
  List<DealComboItems>? dealComboItems;
  DealComboImage? dealComboImage;

  String? createdAgo;
  String? typeText;
  String? statusText;
  int? totalSalePrice;
  Meta? meta;

  DealsCombos({
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
    this.dealComboItems,
    this.createdAgo,
    this.typeText,
    this.statusText,
    this.dealComboImage,
    this.totalSalePrice,
    this.meta,
  });

  String get getModifierString {
    if (dealComboItems == null || dealComboItems!.isEmpty) {
      return "";
    }
    final modifierBuffer = StringBuffer();
    for (final element in dealComboItems!) {
      modifierBuffer.write("+${element.category!.name!} ");
    }
    return modifierBuffer.toString();
  }

  DealsCombos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    establishmentId = json['establishment_id'];
    name = json['name'];
    type = json['type'];
    status = json['status'];
    createdById = json['created_by_id'];
    updatedById = json['updated_by_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    if (json['deal_combo_items'] != null) {
      dealComboItems = <DealComboItems>[];
      json['deal_combo_items'].forEach((v) {
        dealComboItems!.add(DealComboItems.fromJson(v));
      });
    }
    dealComboImage = json['deal_combo_image'] != null
        ? DealComboImage.fromJson(json['deal_combo_image'])
        : null;
    createdAgo = json['created_ago'];
    typeText = json['type_text'];
    statusText = json['status_text'];
    totalSalePrice = json['total_sale_price'];
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
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
    if (dealComboItems != null) {
      data['deal_combo_items'] =
          dealComboItems!.map((v) => v.toJson()).toList();
    }
    if (dealComboImage != null) {
      data['deal_combo_image'] = dealComboImage!.toJson();
    }
    data['created_ago'] = createdAgo;
    data['type_text'] = typeText;
    data['status_text'] = statusText;
    data['total_sale_price'] = totalSalePrice;
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    return data;
  }
}

class DealComboImage {
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
  String? smallImage;
  String? mediumImage;

  DealComboImage({
    this.id,
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
    this.smallImage,
    this.mediumImage,
  });

  DealComboImage.fromJson(Map<String, dynamic> json) {
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
    smallImage = json['smallImage'];
    mediumImage = json['mediumImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['path'] = path;
    data['instance_type'] = instanceType;
    data['instance_id'] = instanceId;
    data['mime_type'] = mimeType;
    data['thumbnail'] = thumbnail;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['duration'] = duration;
    data['created_ago'] = createdAgo;
    data['mediaUrl'] = mediaUrl;
    data['smallImage'] = smallImage;
    data['mediumImage'] = mediumImage;
    return data;
  }
}

class DealComboItems {
  int? id;
  int? dealComboId;
  int? categoryId;
  int? quantity;
  int? salePrice;
  int? optional;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  Category? category;
  List<Products>? products;
  String? createdAgo;
  Meta? meta;

  bool get isOptional => optional == 1;

  DealComboItems({
    this.id,
    this.dealComboId,
    this.categoryId,
    this.quantity,
    this.salePrice,
    this.optional,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.category,
    this.products,
    this.createdAgo,
    this.meta,
  });

  DealComboItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dealComboId = json['deal_combo_id'];
    categoryId = json['category_id'];
    quantity = json['quantity'];
    salePrice = json['sale_price'];
    optional = json['optional'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    category =
        json['category'] != null ? Category.fromJson(json['category']) : null;
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
    createdAgo = json['created_ago'];
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['deal_combo_id'] = dealComboId;
    data['category_id'] = categoryId;
    data['quantity'] = quantity;
    data['sale_price'] = salePrice;
    data['optional'] = optional;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    if (category != null) {
      data['category'] = category!.toJson();
    }
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    data['created_ago'] = createdAgo;
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    return data;
  }
}

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

class Products {
  int? id;
  int? productId;
  int? dealComboItemId;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  Product? product;
  String? createdAgo;
  Meta? meta;

  Products({
    this.id,
    this.productId,
    this.dealComboItemId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.product,
    this.createdAgo,
    this.meta,
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
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
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
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    return data;
  }
}

class TimeTables {
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
  Meta? meta;

  TimeTables({
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
    this.meta,
  });

  TimeTables.fromJson(Map<String, dynamic> json) {
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
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
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
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
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
  Meta? meta;

  Day({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.createdAgo,
    this.meta,
  });

  Day.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    createdAgo = json['created_ago'];
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
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

class Menu {
  int? id;
  String? name;
  String? parentId;
  int? parentSort;
  String? description;
  int? status;
  int? establishmentId;
  int? createdById;
  String? updatedById;
  String? createdAt;
  String? updatedAt;
  CategoryImage? categoryImage;
  String? deletedAt;
  String? updatedBy;
  CreatedBy? createdBy;
  List<SubCategories>? subCategories;
  String? createdAgo;
  String? statusText;
  bool? isCategory;
  bool? isSubcategory;
  List<Product> allProducts = [];
  Meta? meta;

  Menu({
    this.id,
    this.name,
    this.parentId,
    this.allProducts = const [],
    this.parentSort,
    this.description,
    this.status,
    this.establishmentId,
    this.createdById,
    this.updatedById,
    this.createdAt,
    this.updatedAt,
    this.categoryImage,
    this.deletedAt,
    this.updatedBy,
    this.createdBy,
    this.subCategories,
    this.createdAgo,
    this.statusText,
    this.isCategory,
    this.isSubcategory,
    this.meta,
  });

  Menu.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    parentId = json['parent_id'];
    parentSort = json['parent_sort'];
    description = json['description'];
    status = json['status'];
    establishmentId = json['establishment_id'];
    createdById = json['created_by_id'];
    // updatedById = json['updated_by_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    categoryImage = json['category_image'] != null
        ? CategoryImage.fromJson(json['category_image'])
        : null;
    // updatedBy = json['updated_by'];
    createdBy = json['created_by'] != null
        ? CreatedBy.fromJson(json['created_by'])
        : null;
    if (json['subCategories'] != null) {
      subCategories = <SubCategories>[];
      json['subCategories'].forEach((v) {
        subCategories!.add(SubCategories.fromJson(v));
      });
    }
    createdAgo = json['created_ago'];
    statusText = json['status_text'];
    isCategory = json['is_category'];
    isSubcategory = json['is_subcategory'];
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    for (final subCatagory in subCategories!) {
      allProducts.addAll(subCatagory.products!);
    }
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
    if (categoryImage != null) {
      data['category_image'] = categoryImage!.toJson();
    }
    data['created_by_id'] = createdById;
    data['updated_by_id'] = updatedById;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['updated_by'] = updatedBy;
    if (createdBy != null) {
      data['created_by'] = createdBy!.toJson();
    }
    if (subCategories != null) {
      data['subCategories'] = subCategories!.map((v) => v.toJson()).toList();
    }
    data['created_ago'] = createdAgo;
    data['status_text'] = statusText;
    data['is_category'] = isCategory;
    data['is_subcategory'] = isSubcategory;
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    return data;
  }
}

class CategoryImage {
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
  String? smallImage;
  String? mediumImage;

  CategoryImage({
    this.id,
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
    this.smallImage,
    this.mediumImage,
  });

  CategoryImage.fromJson(Map<String, dynamic> json) {
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
    smallImage = json['smallImage'];
    mediumImage = json['mediumImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['path'] = path;
    data['instance_type'] = instanceType;
    data['instance_id'] = instanceId;
    data['mime_type'] = mimeType;
    data['thumbnail'] = thumbnail;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['duration'] = duration;
    data['created_ago'] = createdAgo;
    data['mediaUrl'] = mediaUrl;
    data['smallImage'] = smallImage;
    data['mediumImage'] = mediumImage;
    return data;
  }
}

class SubCategories {
  int? id;
  String? name;
  int? parentId;
  int? parentSort;
  String? description;
  int? status;
  int? establishmentId;
  int? createdById;
  String? updatedById;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  CreatedBy? createdBy;
  String? updatedBy;
  List<Product>? products;
  String? createdAgo;
  String? statusText;
  bool? isCategory;
  bool? isSubcategory;
  Meta? meta;
  CategoryImage? categoryImage;

  SubCategories({
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
    this.createdBy,
    this.updatedBy,
    this.products,
    this.createdAgo,
    this.statusText,
    this.isCategory,
    this.isSubcategory,
    this.categoryImage,
    this.meta,
  });

  SubCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    parentId = json['parent_id'];
    parentSort = json['parent_sort'];
    description = json['description'];
    status = json['status'];
    establishmentId = json['establishment_id'];
    createdById = json['created_by_id'];
    // updatedById = json['updated_by_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    createdBy = json['created_by'] != null
        ? CreatedBy.fromJson(json['created_by'])
        : null;
    // updatedBy = json['updated_by'];
    if (json['products'] != null) {
      products = <Product>[];
      json['products'].forEach((v) {
        products!.add(Product.fromJson(v));
      });
    }
    categoryImage = json['category_image'] != null
        ? CategoryImage.fromJson(json['category_image'])
        : null;
    createdAgo = json['created_ago'];
    statusText = json['status_text'];
    isCategory = json['is_category'];
    isSubcategory = json['is_subcategory'];
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
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
    if (createdBy != null) {
      data['created_by'] = createdBy!.toJson();
    }
    data['updated_by'] = updatedBy;
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    if (categoryImage != null) {
      data['category_image'] = categoryImage!.toJson();
    }
    data['created_ago'] = createdAgo;
    data['status_text'] = statusText;
    data['is_category'] = isCategory;
    data['is_subcategory'] = isSubcategory;
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    return data;
  }
}

class Product {
  int? id;
  String? name;
  String? description;
  int? soldByWeight;
  int? isShipping;
  int? sku;
  int? status;
  int? categoryId;
  int? establishmentId;
  int? createdById;
  int? updatedById;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  int? barcode;
  int? stockAmount;
  int? cost;
  int? price;
  CreatedBy? updatedBy;
  CreatedBy? createdBy;
  String? createdAgo;
  bool? isProduct;
  String? statusText;
  Category? category;
  ProductSingleImage productSingleImage = ProductSingleImage();
  Meta? meta;
  bool isDeal = false;

  Product({
    this.id,
    this.name,
    this.isDeal = false,
    this.description,
    this.soldByWeight,
    this.isShipping,
    this.sku,
    required this.productSingleImage,
    this.status,
    this.categoryId,
    this.category,
    this.establishmentId,
    this.createdById,
    this.updatedById,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.barcode,
    this.stockAmount,
    this.cost,
    this.price,
    this.updatedBy,
    this.createdBy,
    this.createdAgo,
    this.isProduct,
    this.statusText,
    this.meta,
  });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    soldByWeight = json['sold_by_weight'];
    isShipping = json['is_shipping'];
    sku = json['sku'];
    status = json['status'];
    category =
        json['category'] != null ? Category.fromJson(json['category']) : null;
    productSingleImage = json['product_single_image'] != null
        ? ProductSingleImage.fromJson(json['product_single_image'])
        : ProductSingleImage();
    categoryId = json['category_id'];
    establishmentId = json['establishment_id'];
    createdById = json['created_by_id'];
    updatedById = json['updated_by_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    barcode = json['barcode'];
    stockAmount = json['stock_amount'];
    cost = json['cost'];
    price = json['price'];
    updatedBy = json['updated_by'] != null
        ? CreatedBy.fromJson(json['updated_by'])
        : null;
    createdBy = json['created_by'] != null
        ? CreatedBy.fromJson(json['created_by'])
        : null;
    createdAgo = json['created_ago'];
    isProduct = json['is_product'];
    statusText = json['status_text'];
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['sold_by_weight'] = soldByWeight;
    data['is_shipping'] = isShipping;
    data['sku'] = sku;
    data['status'] = status;
    data['category_id'] = categoryId;
    data['establishment_id'] = establishmentId;
    data['created_by_id'] = createdById;
    data['updated_by_id'] = updatedById;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['barcode'] = barcode;
    data['stock_amount'] = stockAmount;
    data['cost'] = cost;
    data['price'] = price;
    if (updatedBy != null) {
      data['updated_by'] = updatedBy!.toJson();
    }
    if (createdBy != null) {
      data['created_by'] = createdBy!.toJson();
    }
    data['created_ago'] = createdAgo;
    data['is_product'] = isProduct;
    data['status_text'] = statusText;
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    data['product_single_image'] = productSingleImage.toJson();
    if (category != null) {
      data['category'] = category!.toJson();
    }
    return data;
  }
}

class ProductSingleImage {
  int? id;
  String path = "";
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
  String? smallImage;
  String? mediumImage;

  ProductSingleImage({
    this.id,
    this.path = "",
    this.instanceType,
    this.instanceId,
    this.mimeType,
    this.thumbnail,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.duration,
    this.createdAgo,
    this.mediaUrl = '',
    this.smallImage,
    this.mediumImage,
  });

  ProductSingleImage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    path = json['path'] ?? "";
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
    smallImage = json['smallImage'];
    mediumImage = json['mediumImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['path'] = path;
    data['instance_type'] = instanceType;
    data['instance_id'] = instanceId;
    data['mime_type'] = mimeType;
    data['thumbnail'] = thumbnail;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['duration'] = duration;
    data['created_ago'] = createdAgo;
    data['mediaUrl'] = mediaUrl;
    data['smallImage'] = smallImage;
    data['mediumImage'] = mediumImage;
    return data;
  }
}

class Meta {
  int? pivotCustomMenuId;
  int? pivotDealComboId;
  int? productsCount;
  int? subCategoriesCount;
  int? dealComboItemsCount;

  Meta({
    this.pivotCustomMenuId,
    this.pivotDealComboId,
    this.dealComboItemsCount,
  });

  Meta.fromJson(Map<String, dynamic> json) {
    pivotCustomMenuId = json['pivot_custom_menu_id'];
    pivotDealComboId = json['pivot_deal_combo_id'];
    productsCount = json['products_count'];
    subCategoriesCount = json['subCategories_count'];
    dealComboItemsCount = json['deal_combo_items_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pivot_custom_menu_id'] = pivotCustomMenuId;
    data['pivot_deal_combo_id'] = pivotDealComboId;
    data['subCategories_count'] = subCategoriesCount;
    data['deal_combo_items_count'] = dealComboItemsCount;
    data['products_count'] = productsCount;
    return data;
  }
}
