import 'package:serveeasy_app/app/data/models/addresses/all_addresses_response_model.dart';
import 'package:serveeasy_app/app/data/models/base_response_model.dart';

class GetSingleAddressResponse extends BaseApiResponse {
  Address? address;

  GetSingleAddressResponse({this.address});

  GetSingleAddressResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    address = json['data'] != null ? Address.fromJson(json['data']) : null;
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (address != null) {
      data['data'] = address!.toJson();
    }
    return data;
  }
}
