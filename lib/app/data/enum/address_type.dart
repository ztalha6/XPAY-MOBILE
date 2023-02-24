import 'package:serveeasy_app/core/constants/asset_constants.dart';

enum AddressType {
  home(10, homeIcon),
  work(20, workIcon),
  unknown(0, "");

  static List<AddressType> addresses = [AddressType.home, AddressType.work];
  final int value;
  final String assetString;
  const AddressType(this.value, this.assetString);
}

int getAddress(AddressType addressType) {
  switch (addressType) {
    case AddressType.home:
      return 10;
    case AddressType.work:
      return 20;
    default:
      return 0;
  }
}

AddressType getAddressFromNum(int addressType) {
  switch (addressType) {
    case 10:
      return AddressType.home;
    case 20:
      return AddressType.work;
    default:
      return AddressType.unknown;
  }
}
