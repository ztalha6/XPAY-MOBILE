class UpdateAddressRequest {
  String? address;
  String? city;
  String? state;
  String? landmark;
  int? zipCode;
  int? addressType;
  double? lat;
  double? lng;

  UpdateAddressRequest({
    this.address,
    this.city,
    this.state,
    this.landmark,
    this.zipCode,
    this.addressType,
    this.lat,
    this.lng,
  });

  UpdateAddressRequest.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    city = json['city'];
    state = json['state'];
    landmark = json['landmark'];
    zipCode = json['zip_code'];
    addressType = json['address_type'];
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address'] = address;
    data['city'] = city;
    data['state'] = state;
    data['landmark'] = landmark;
    data['zip_code'] = zipCode;
    data['address_type'] = addressType;
    data['lat'] = lat;
    data['lng'] = lng;
    return data;
  }
}
