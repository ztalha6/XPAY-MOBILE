import 'package:serveeasy_app/app/data/models/base_response_model.dart';
import 'package:serveeasy_app/app/data/models/menu/menu_data_response_model.dart';

class ModifiersResponse extends BaseApiResponse {
  List<ModifierType>? modifierType;

  ModifiersResponse({this.modifierType});

  ModifiersResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      modifierType = <ModifierType>[];
      json['data']['data'].forEach((v) {
        modifierType!.add(ModifierType.fromJson(v));
      });
    }
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (modifierType != null) {
      data['data'] = modifierType!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ModifierType {
  int? id;
  String? name;
  int? multiSelect;
  int? status;
  int? establishmentId;
  int? createdById;
  int? updatedById;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  int? maxAmount;
  int? minAmount;
  List<Modifiers>? modifiers;
  String? createdAgo;
  String? statusText;
  Meta? meta;

  ModifierType({
    this.id,
    this.name,
    this.status,
    this.establishmentId,
    this.createdById,
    this.updatedById,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.maxAmount,
    this.minAmount,
    this.modifiers,
    this.createdAgo,
    this.multiSelect,
    this.statusText,
    this.meta,
  });

  bool get isSupportMultiSelect => multiSelect == 1;

  ModifierType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    establishmentId = json['establishment_id'];
    createdById = json['created_by_id'];
    updatedById = json['updated_by_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    maxAmount = json['max_amount'];
    minAmount = json['min_amount'];
    multiSelect = json['multi_select'];
    if (json['modifiers'] != null) {
      modifiers = <Modifiers>[];
      json['modifiers'].forEach((v) {
        modifiers!.add(Modifiers.fromJson(v));
      });
    }
    createdAgo = json['created_ago'];
    statusText = json['status_text'];
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['status'] = status;
    data['establishment_id'] = establishmentId;
    data['created_by_id'] = createdById;
    data['updated_by_id'] = updatedById;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['multi_select'] = multiSelect;
    data['max_amount'] = maxAmount;
    data['min_amount'] = minAmount;
    if (modifiers != null) {
      data['modifiers'] = modifiers!.map((v) => v.toJson()).toList();
    }
    data['created_ago'] = createdAgo;
    data['status_text'] = statusText;
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    return data;
  }
}

class Modifiers {
  int? id;
  String? name;
  int? status;
  int? modifierClassId;
  int? establishmentId;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  int? price;
  int? barcode;
  int? cost;
  int? createdById;
  int? updatedById;
  String? createdAgo;
  String? statusText;
  ProductSingleImage? modifierImage;

  Modifiers({
    this.id,
    this.name,
    this.status,
    this.modifierClassId,
    this.establishmentId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.price,
    this.barcode,
    this.cost,
    this.createdById,
    this.updatedById,
    this.createdAgo,
    this.statusText,
    this.modifierImage,
  });

  Modifiers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    modifierClassId = json['modifier_class_id'];
    establishmentId = json['establishment_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    price = json['price'];
    barcode = json['barcode'];
    cost = json['cost'];
    modifierImage = json['modifier_image'] != null
        ? ProductSingleImage.fromJson(json['modifier_image'])
        : null;
    createdById = json['created_by_id'];
    updatedById = json['updated_by_id'];
    createdAgo = json['created_ago'];
    statusText = json['status_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['status'] = status;
    data['modifier_class_id'] = modifierClassId;
    data['establishment_id'] = establishmentId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['price'] = price;
    data['barcode'] = barcode;
    data['cost'] = cost;
    data['created_by_id'] = createdById;
    data['updated_by_id'] = updatedById;
    data['created_ago'] = createdAgo;
    data['status_text'] = statusText;
    if (modifierImage != null) {
      data['modifier_image'] = modifierImage!.toJson();
    }
    return data;
  }
}

class Meta {
  int? modifiersCount;

  Meta({this.modifiersCount});

  Meta.fromJson(Map<String, dynamic> json) {
    modifiersCount = json['modifiers_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['modifiers_count'] = modifiersCount;
    return data;
  }
}
