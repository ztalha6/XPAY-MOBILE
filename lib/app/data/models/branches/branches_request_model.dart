class BranchListRequest {
  int? page;
  double? latitude;
  double? longitude;
  int? onlineOrderType;

  BranchListRequest({
    this.page,
    this.latitude,
    this.longitude,
    this.onlineOrderType,
  });

  BranchListRequest.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    onlineOrderType = json['online_order_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['online_order_type'] = onlineOrderType;
    return data;
  }
}
