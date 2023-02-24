import 'dart:convert';

import 'package:serveeasy_app/app/data/models/addresses/all_addresses_response_model.dart';
import 'package:serveeasy_app/app/data/models/base_repository_model.dart';
import 'package:serveeasy_app/app/data/models/order/cart_sumamry_request_model.dart';
import 'package:serveeasy_app/app/data/models/order/cart_summary_response_model.dart';
import 'package:serveeasy_app/app/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserManager {
  static final UserManager _singleton = UserManager._internal();

  factory UserManager() {
    return _singleton;
  }

  UserManager._internal();
  static const String _keyUser = '_keyUser';

  Future<bool> saveUser(User user) async {
    return (await SharedPreferences.getInstance()).setString(
      _keyUser,
      json.encode(user.toJson()),
    );
  }

  Future<bool> saveUserCartandSummary(
    List<CartItem> cartList,
    List<Deal> dealList,
    Summary summary,
  ) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final String? email = (await getUser())!.email;
    if (email == null) return false;
    if (await sharedPreferences.setString(
          "${email}_cart",
          json.encode(cartList),
        ) &&
        await sharedPreferences.setString(
          "${email}_deals",
          json.encode(dealList),
        )) {
      return sharedPreferences.setString(
        "${email}_summary",
        json.encode(summary.toJson()),
      );
    }
    return false;
  }

  Future<User?> getUser() async {
    final String savedUserString =
        (await SharedPreferences.getInstance()).getString(_keyUser) ?? '';
    return savedUserString.isNotEmpty
        ? User.fromJson(json.decode(savedUserString))
        : null;
  }

  Future<int> getSavedAddressId() async {
    final String savedUserString =
        (await SharedPreferences.getInstance()).getString(_keyUser) ?? '';

    if (savedUserString.isNotEmpty) {
      final User user = User.fromJson(json.decode(savedUserString));
      if (user.addressDetail != null && user.addressDetail!.id != null) {
        return user.addressDetail!.id!;
      }
    }
    return -1;
  }

  Future<bool> isNotAccessingSameBranch(int branchId) async {
    final int? savedBranchId = (await getUser())!.selectedBranchId;
    if (savedBranchId != null && savedBranchId != branchId) return true;
    return false;
  }

  Future<Address?> getSavedAddress() async {
    final String savedUserString =
        (await SharedPreferences.getInstance()).getString(_keyUser) ?? '';
    return savedUserString.isNotEmpty
        ? User.fromJson(json.decode(savedUserString)).addressDetail!
        : null;
  }

  Future<RepositoryResponse<Address>> hasAnySavedAddress() async {
    final String savedUserString =
        (await SharedPreferences.getInstance()).getString(_keyUser) ?? '';
    if (savedUserString.isNotEmpty &&
        User.fromJson(json.decode(savedUserString)).addressDetail != null) {
      return RepositoryResponse(
        isSuccess: true,
        data: User.fromJson(json.decode(savedUserString)).addressDetail,
      );
    }
    return RepositoryResponse(isSuccess: false);
  }

  Future<List<CartItem>> getUserCart() async {
    final String email = (await getUser())!.email!;
    final String savedUserString =
        (await SharedPreferences.getInstance()).getString("${email}_cart") ??
            '';
    return savedUserString.isNotEmpty
        ? CartItem.fromSavedJson(json.decode(savedUserString))
        : [];
  }

  Future<List<Deal>> getUserDeals() async {
    final String email = (await getUser())!.email!;
    final String savedUserString =
        (await SharedPreferences.getInstance()).getString("${email}_deals") ??
            '';
    return savedUserString.isNotEmpty
        ? Deal.fromSavedJson(json.decode(savedUserString))
        : [];
  }

  Future<bool> clearLocalCart() async {
    try {
      final String email = (await getUser())!.email!;
      (await SharedPreferences.getInstance()).remove("${email}_cart");
      (await SharedPreferences.getInstance()).remove("${email}_deals");
      (await SharedPreferences.getInstance()).remove("${email}_summary");
    } on Exception {
      return false;
    }
    return true;
  }

  Future<Summary> getUserCartSummary() async {
    final String email = (await getUser())!.email!;
    final String savedUserString =
        (await SharedPreferences.getInstance()).getString("${email}_summary") ??
            '';
    return savedUserString.isNotEmpty
        ? Summary.fromJson(json.decode(savedUserString))
        : Summary.fresh();
  }

  Future<bool> update({
    int? orderType,
    int? selectedBranchId,
    int? eshtablishmentId,
    int? cartId,
    int? dealId,
    int? lastOrderId,
    Address? addressDetail,
    String? branchName,
    String? cardToken,
  }) async {
    final User? user = await getUser();
    if (user != null) {
      if (orderType != null) {
        user.orderType = orderType;
      }
      if (selectedBranchId != null) {
        user.selectedBranchId = selectedBranchId;
      }
      if (branchName != null) {
        user.branchName = branchName;
      }
      if (eshtablishmentId != null) {
        user.establishmentId = eshtablishmentId;
      }
      if (cartId != null) {
        user.cartId = cartId;
      }
      if (dealId != null) {
        user.dealId = dealId;
      }
      if (lastOrderId != null) {
        user.lastOrderId = lastOrderId;
      }
      if (addressDetail != null) {
        user.addressDetail = addressDetail;
      }
      if (cardToken != null) {
        user.cardToken = cardToken;
      }
      saveUser(user);
      return true;
    }
    return false;
  }

  Future<bool> removeUser() async =>
      (await SharedPreferences.getInstance()).remove(_keyUser);
}
