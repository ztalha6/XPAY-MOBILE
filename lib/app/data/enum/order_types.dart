import 'package:serveeasy_app/core/constants/asset_constants.dart';

enum OrderType {
  delivery(10, deliveryIcon),
  pickup(20, pickUpIcon),
  online(40, pickUpIcon),
  unknown(0, deliveryIcon);

  final int value;
  final String image;
  const OrderType(this.value, this.image);

  static List<OrderType> orderTypes = [OrderType.delivery, OrderType.pickup];

  static OrderType getOrderTypeFromValue(int value) {
    switch (value) {
      case 10:
        return OrderType.delivery;
      case 20:
        return OrderType.pickup;
      case 40:
        return OrderType.online;
      default:
        return OrderType.unknown;
    }
  }

  static String getNameFromValue(int orderType) {
    switch (orderType) {
      case 10:
        return 'Delivery';
      case 20:
        return 'Pick Up';
      case 40:
        return 'Online';
      default:
        return "";
    }
  }

  static String getNameFromOrderType(OrderType orderType) {
    switch (orderType) {
      case OrderType.delivery:
        return 'Delivery';
      case OrderType.pickup:
        return 'Pick Up';
      case OrderType.online:
        return 'Online';
      default:
        return "";
    }
  }
}
