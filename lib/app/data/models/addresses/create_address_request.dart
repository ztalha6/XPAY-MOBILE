class CreateAddressRequest {
  String? name;
  String? phone;

  CreateAddressRequest({required this.name, required this.phone});

  CreateAddressRequest.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phone'] = this.phone;
    return data;
  }
}
