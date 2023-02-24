import 'package:serveeasy_app/app/data/models/base_response_model.dart';

class MainMenuTabbarResponse extends BaseApiResponse {
  Data? data;

  MainMenuTabbarResponse({this.data});

  MainMenuTabbarResponse.fromJson(Map<String, dynamic> json) {
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
  List<TabbarData>? tabbarItem;

  Data({this.meta, this.tabbarItem});

  Data.fromJson(Map<String, dynamic> json) {
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    if (json['data'] != null) {
      tabbarItem = <TabbarData>[];
      json['data'].forEach((v) {
        tabbarItem!.add(TabbarData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    if (tabbarItem != null) {
      data['data'] = tabbarItem!.map((v) => v.toJson()).toList();
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
  int? productsCount;

  Meta({
    this.total,
    this.perPage,
    this.currentPage,
    this.lastPage,
    this.firstPage,
    this.firstPageUrl,
    this.lastPageUrl,
    this.productsCount,
    this.nextPageUrl,
    this.previousPageUrl,
  });

  Meta.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    perPage = json['per_page'];
    productsCount = json['products_count'];
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
    data['products_count'] = productsCount;
    data['previous_page_url'] = previousPageUrl;
    return data;
  }
}

class TabbarData {
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
  String? createdAgo;
  String? statusText;
  Meta? meta;

  TabbarData({
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
    this.createdAgo,
    this.statusText,
    this.meta,
  });

  TabbarData.fromJson(Map<String, dynamic> json) {
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
    createdAgo = json['created_ago'];
    statusText = json['status_text'];
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
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
    data['created_ago'] = createdAgo;
    data['status_text'] = statusText;
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    return data;
  }
}

class CreatedBy {
  String? fullName;
  int? id;

  CreatedBy({this.fullName, this.id});

  CreatedBy.fromJson(Map<String, dynamic> json) {
    fullName = json['full_name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['full_name'] = fullName;
    data['id'] = id;
    return data;
  }
}
