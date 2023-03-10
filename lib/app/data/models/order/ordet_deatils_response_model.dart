import 'package:serveeasy_app/app/data/models/base_response_model.dart';
import 'package:serveeasy_app/app/data/models/order/order_history_response_model.dart';
import 'package:serveeasy_app/app/data/models/order/transaction_history_response_model.dart';

class OrderDetailResponse extends BaseApiResponse {
  OrderData? orderDetail;

  OrderDetailResponse({this.orderDetail});

  OrderDetailResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    orderDetail =
        json['data'] != null ? OrderData.fromJson(json['data']) : null;
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (orderDetail != null) {
      data['data'] = orderDetail!.toJson();
    }
    return data;
  }
}

class TransactionDetailResponse extends BaseApiResponse {
  Transaction? orderDetail;

  TransactionDetailResponse({this.orderDetail});

  TransactionDetailResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    orderDetail =
        json['data'] != null ? Transaction.fromJson(json['data']) : null;
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (orderDetail != null) {
      data['data'] = orderDetail!.toJson();
    }
    return data;
  }
}
