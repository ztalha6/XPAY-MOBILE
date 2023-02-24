enum PaymentType {
  cash(10, "Payment by cash"),
  card(
    20,
    "Use a credit or debit card to pay with automatic payments enabled.",
  );

  const PaymentType(this.value, this.description);
  final int value;
  final String description;

  static String getNameFromValue(int value) {
    switch (value) {
      case 10:
        return 'CASH';
      case 20:
        return 'CARD';
      default:
        return "";
    }
  }

  static PaymentType getPaymentTypeFromValue(int value) {
    switch (value) {
      case 10:
        return PaymentType.cash;
      case 20:
        return PaymentType.card;
      default:
        return PaymentType.cash;
    }
  }

  static List<PaymentType> paymentTypeList = [
    PaymentType.cash,
    PaymentType.card,
  ];
}

extension PaymentTypeExtension on PaymentType {
  String get name {
    switch (this) {
      case PaymentType.cash:
        return 'CASH';
      case PaymentType.card:
        return 'CARD';
      default:
        return "";
    }
  }
}
