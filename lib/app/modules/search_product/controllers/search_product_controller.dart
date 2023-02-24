import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:serveeasy_app/app/data/models/menu/menu_data_response_model.dart';
import 'package:serveeasy_app/app/data/repositories/product_repository.dart';
import 'package:serveeasy_app/core/constants/configuration.dart';
import 'package:serveeasy_app/core/utils/utils.dart';

class SearchProductController extends GetxController {
  Configuration configs = Configuration();
  RxBool isSearching = false.obs;
  RefreshController searchController = RefreshController();
  TextEditingController seacrhTextController = TextEditingController();
  Rx<int> page = Rx<int>(1);
  RxList<Product> searchedProducts = RxList<Product>([]);

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  Future<void> search({required bool withSearch}) async {
    Utils().clearKeyboardFocus();
    if (seacrhTextController.text.isEmpty) {
      return;
    }
    isSearching.value = true;
    page.value = 1;
    await searchProduct(withClear: true, withSearch: withSearch);
    isSearching.value = false;
  }

  Future<void> onLoading() async {
    page.value++;
    await searchProduct();
    searchController.loadComplete();
  }

  Future<void> searchProduct({
    bool withClear = false,
    bool withSearch = false,
  }) async {
    final List<Product> data = await ProductRepository()
        .searchProducts(page.value, productName: seacrhTextController.text);
    if (data.isEmpty) page.value--;
    if (withClear) searchedProducts.clear();
    searchedProducts.addAll(data);
  }

  void clearSearches() {
    seacrhTextController.clear();
  }

  void oncancelTap() {
    seacrhTextController.clear();
    searchedProducts.clear();
    searchedProducts.refresh();
    Get.back();
  }
}
