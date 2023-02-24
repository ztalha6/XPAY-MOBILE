import 'package:serveeasy_app/app/data/models/order/cart_summary_response_model.dart';
import 'package:serveeasy_app/app/data/models/order/create_order_response_model.dart';

class CartSummaryRequest {
  int? tableId;
  int? orderType;
  int? establishmentId;
  int? discountId;
  int? deliveryCustomerId;
  int? paymentType;
  List<CartItem>? cartItems;
  List<Deal>? deals;

  CartSummaryRequest({
    this.tableId,
    this.orderType,
    this.establishmentId,
    this.cartItems,
    this.discountId,
    this.deals,
    this.paymentType,
    this.deliveryCustomerId,
  });

  CartSummaryRequest.fromJson(Map<String, dynamic> json) {
    tableId = json['table_id'];
    orderType = json['order_type'];
    establishmentId = json['establishment_id'];
    deliveryCustomerId = json['delivery_customer_id'];
    paymentType = json['payment_type'];
    discountId = json['discount_id'];
    if (json['deals'] != null) {
      deals = <Deal>[];
      json['deals'].forEach((v) {
        deals!.add(Deal.fromJson(v));
      });
    }
    if (json['cart_items'] != null) {
      cartItems = <CartItem>[];
      json['cart_items'].forEach((v) {
        cartItems!.add(CartItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['table_id'] = tableId;
    data['order_type'] = orderType;
    data['establishment_id'] = establishmentId;
    data['delivery_customer_id'] = deliveryCustomerId;
    data['payment_type'] = paymentType;
    data['discount_id'] = discountId;
    if (deals != null) {
      data['deals'] = deals!.map((v) => v.toJson()).toList();
    }
    if (cartItems != null) {
      data['cart_items'] = cartItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Deal {
  int? id;
  int? dealId;
  int? qty;
  String? dealName;
  num? price;
  num? unitPrice;
  num? discount;
  String? image;
  String? instruction;
  List<DealItemModifier> dealItems = [];

  Deal({
    this.id,
    this.dealId,
    this.qty = 1,
    this.instruction = "",
    this.dealName = '',
    required this.dealItems,
    this.discount = 0.0,
    this.price = 0.0,
    this.unitPrice = 0.0,
    this.image = '',
  });

  static List<Deal> fromResponseCart(List<ResponseDealsItems> responseDeals) {
    final List<Deal> list = [];
    for (final element in responseDeals) {
      // int totalDealPrice = 0;
      // for (final dealModifiers in element.dealItems!) {
      //   totalDealPrice = totalDealPrice + dealModifiers.product!.price!;
      // }
      list.add(
        Deal(
          id: element.id,
          qty: element.qty ?? 1,
          dealId: element.dealId,
          unitPrice: element.payablePrice,
          price: element.payablePrice,
          discount: element.discount ?? 0.0,
          dealName: element.dealCombo!.name,
          image: element.dealCombo!.dealComboImage != null
              ? element.dealCombo!.dealComboImage!.mediaUrl
              : "",
          instruction: element.instruction ?? '',
          dealItems:
              DealItemModifier.fromResponseDealModifier(element.dealItems!),
        ),
      );
    }
    return list;
  }

  static List<Deal> fromOrderCart(List<DealCombos> responseCart) {
    final List<Deal> list = [];
    for (final DealCombos element in responseCart) {
      int totalDealPrice = 0;
      for (final dealModifiers in element.dealComboItems!) {
        totalDealPrice = totalDealPrice + dealModifiers.payablePrice!;
      }
      list.add(
        Deal(
          id: element.id,
          dealId: element.dealComboId,
          qty: element.purchasedQty ?? 1,
          dealName: element.dealCombo!.name,
          unitPrice: totalDealPrice,
          price: totalDealPrice,
          instruction: element.instructions ?? '',
          image: element.dealCombo!.dealComboImage != null
              ? element.dealCombo!.dealComboImage!.mediaUrl
              : "",
          dealItems:
              DealItemModifier.fromOrderModifier(element.dealComboItems!),
        ),
      );
    }
    return list;
  }

  static List<Deal> fromSavedJson(dynamic data) {
    if (data is List) {
      final List<Deal> cart = [];
      for (int i = 0; i < data.length; i++) {
        cart.add(Deal.fromJson(data[i]));
      }
      return cart;
    }
    return [];
  }

  Deal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dealId = json['deal_id'];
    qty = json['qty'];
    price = json['price'];
    unitPrice = json['unitPrice'];
    discount = json['discount'];
    dealName = json['productName'];
    instruction = json['instruction'];
    image = json['image'];
    if (json['deal_items'] != null) {
      dealItems = <DealItemModifier>[];
      json['deal_items'].forEach((v) {
        dealItems.add(DealItemModifier.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['deal_id'] = dealId;
    data['qty'] = qty;
    data['price'] = price;
    data['unitPrice'] = unitPrice;
    data['discount'] = discount;
    data['productName'] = dealName;
    data['instruction'] = instruction;
    data['image'] = image;
    data['deal_items'] = dealItems.map((v) => v.toJson()).toList();
    return data;
  }
}

class DealItemModifier {
  int? dealComboItemId;
  int? productId;
  String? productName;
  String? code;

  DealItemModifier({
    this.dealComboItemId,
    this.productId,
    this.productName,
    this.code,
  });

  static List<DealItemModifier> fromResponseDealModifier(
    List<ResponseDealModifiers> responseDealItemModifier,
  ) {
    final List<DealItemModifier> list = [];
    for (final modi in responseDealItemModifier) {
      list.add(
        DealItemModifier(
          dealComboItemId: modi.dealComboItemId,
          productName: modi.product!.name,
          productId: modi.productId,
          code: "",
        ),
      );
    }
    return list;
  }

  static List<DealItemModifier> fromOrderModifier(
    List<DealComboItems> responseDealItemModifier,
  ) {
    final List<DealItemModifier> list = [];
    for (final DealComboItems modi in responseDealItemModifier) {
      list.add(
        DealItemModifier(
          dealComboItemId: modi.dealComboItemId,
          productName: modi.product!.name,
          productId: modi.productId,
          code: "",
        ),
      );
    }
    return list;
  }

  DealItemModifier.fromJson(Map<String, dynamic> json) {
    dealComboItemId = json['deal_combo_item_id'];
    productId = json['product_id'];
    productName = json['productName'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['deal_combo_item_id'] = dealComboItemId;
    data['product_id'] = productId;
    data['productName'] = productName;
    data['code'] = code;
    return data;
  }
}

class CartItem {
  int? id;
  int? productId;
  String? productName;
  int? qty;
  num? price;
  num? unitPrice;
  num? discount;
  String? image;
  String? instruction;
  List<CartItemModifier>? cartItemModifiers;

  String get getModifierString {
    if (cartItemModifiers == null || cartItemModifiers!.isEmpty) {
      return "";
    }
    final modifierBuffer = StringBuffer();
    for (final element in cartItemModifiers!) {
      modifierBuffer.write("+${element.name!} ");
    }
    return modifierBuffer.toString();
  }

  CartItem({
    this.id,
    this.productId,
    this.productName = "",
    this.qty = 1,
    this.instruction = "",
    this.discount = 0.0,
    this.image = "",
    this.price = 0.0,
    this.unitPrice = 0.0,
    this.cartItemModifiers = const [],
  });

  static List<CartItem> fromResponseCart(List<ResponseCartItems> responseCart) {
    final List<CartItem> list = [];
    for (final element in responseCart) {
      list.add(
        CartItem(
          id: element.id,
          productId: element.productId,
          productName: element.product!.name,
          qty: element.qty,
          unitPrice: element.product!.price,
          price: element.payablePrice!.toInt(),
          discount: element.discount,
          instruction: element.instruction ?? '',
          image: element.product!.productSingleImage != null
              ? element.product!.productSingleImage.mediaUrl
              : "",
          cartItemModifiers:
              CartItemModifier.fromResponseModifier(element.modifiers!),
        ),
      );
    }
    return list;
  }

  static List<CartItem> fromOrderCart(List<OrderItems> responseCart) {
    final List<CartItem> list = [];
    for (final OrderItems element in responseCart) {
      list.add(
        CartItem(
          id: element.id,
          productId: element.productId,
          productName: element.product!.name,
          qty: element.purchasedQty,
          unitPrice: element.product!.price,
          price: element.payablePrice!.toInt(),
          instruction: element.instruction ?? '',
          image: element.product!.productSingleImage != null
              ? element.product!.productSingleImage.mediaUrl
              : "",
          cartItemModifiers:
              CartItemModifier.fromOrderModifier(element.orderItemModifiers!),
        ),
      );
    }
    return list;
  }

  CartItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    qty = json['qty'];
    productName = json['productName'];
    instruction = json['instruction'];
    unitPrice = json['unitPrice'];
    price = json['price'];
    discount = json['discount'];
    image = json['image'];
    if (json['modifiers'] != null) {
      cartItemModifiers = <CartItemModifier>[];
      json['modifiers'].forEach((v) {
        cartItemModifiers!.add(CartItemModifier.fromJson(v));
      });
    }
  }
  static List<CartItem> fromSavedJson(dynamic data) {
    if (data is List) {
      final List<CartItem> cart = [];
      for (int i = 0; i < data.length; i++) {
        cart.add(CartItem.fromJson(data[i]));
      }
      return cart;
    }
    return [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product_id'] = productId;
    data['productName'] = productName;
    data['unitPrice'] = unitPrice;
    data['price'] = price;
    data['discount'] = discount;
    data['qty'] = qty;
    data['image'] = image;
    data['instruction'] = instruction;
    if (cartItemModifiers != null) {
      data['modifiers'] = cartItemModifiers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CartItemModifier {
  int? modifierId;
  int? qty;
  String? name;
  int? price;

  CartItemModifier({this.modifierId, this.qty, this.name, this.price});

  static List<CartItemModifier> fromResponseModifier(
    List<ResponseCartItemModifiers> responseCartItemModifier,
  ) {
    final List<CartItemModifier> list = [];
    for (final modi in responseCartItemModifier) {
      list.add(
        CartItemModifier(
          modifierId: modi.modifierId,
          qty: modi.qty,
          name: modi.modifier!.name,
          price: modi.modifier!.price,
        ),
      );
    }
    return list;
  }

  static List<CartItemModifier> fromOrderModifier(
    List<OrderItemModifiers> responseCartItemModifier,
  ) {
    final List<CartItemModifier> list = [];
    for (final OrderItemModifiers modi in responseCartItemModifier) {
      list.add(
        CartItemModifier(
          modifierId: modi.modifierId,
          qty: modi.qty,
          name: modi.modifier!.name,
          price: modi.modifier!.price,
        ),
      );
    }
    return list;
  }

  CartItemModifier.fromJson(Map<String, dynamic> json) {
    modifierId = json['modifier_id'];
    name = json['name'];
    price = json['price'];
    qty = json['qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['modifier_id'] = modifierId;
    data['name'] = name;
    data['price'] = price;
    data['qty'] = qty;
    return data;
  }
}
