import 'package:flutter/material.dart';

enum OrderStatus {
  ordered(10, Color(0xFFFCBB36)),
  hold(20, Color(0xFFF18345)),
  kitchen(30, Color(0xFF0178E5)),
  dispatch(40, Color(0xFF646C7C)),
  delivered(50, Color(0xFF5DCED6)),
  cancelled(60, Color(0xFFF5697A)),
  completed(70, Color(0xFF6EC9A8)),
  unknown(0, Color(0xFF6EC9A8));

  final int value;
  final Color color;
  const OrderStatus(this.value, this.color);

  static String getNameFromValue(int value) {
    switch (value) {
      case 10:
        return OrderStatus.ordered.name;
      case 20:
        return OrderStatus.hold.name;
      case 30:
        return OrderStatus.kitchen.name;
      case 40:
        return OrderStatus.dispatch.name;
      case 50:
        return OrderStatus.delivered.name;
      case 60:
        return OrderStatus.cancelled.name;
      case 70:
        return OrderStatus.completed.name;
      default:
        return "";
    }
  }

  static OrderStatus getOrderStatusFromValue(int value) {
    switch (value) {
      case 10:
        return OrderStatus.ordered;
      case 20:
        return OrderStatus.hold;
      case 30:
        return OrderStatus.kitchen;
      case 40:
        return OrderStatus.dispatch;
      case 50:
        return OrderStatus.delivered;
      case 60:
        return OrderStatus.cancelled;
      case 70:
        return OrderStatus.completed;
      default:
        return OrderStatus.unknown;
    }
  }
}

extension OrderStatusExtension on OrderStatus {
  String get name {
    switch (this) {
      case OrderStatus.ordered:
        return 'ORDERED';
      case OrderStatus.hold:
        return "HOLD";
      case OrderStatus.kitchen:
        return "KITCHEN";
      case OrderStatus.dispatch:
        return "DISPATCH";
      case OrderStatus.delivered:
        return "DELIVERED";
      case OrderStatus.cancelled:
        return "CANCELLED";
      case OrderStatus.completed:
        return "COMPLETED";
      default:
        return "";
    }
  }
}
