import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rect_getter/rect_getter.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:serveeasy_app/app/data/enum/order_types.dart';
import 'package:serveeasy_app/app/data/models/addresses/all_addresses_response_model.dart';
import 'package:serveeasy_app/app/data/models/base_repository_model.dart';
import 'package:serveeasy_app/app/data/models/menu/main_menu_tabbar_respone_model.dart';
import 'package:serveeasy_app/app/data/models/menu/menu_data_response_model.dart';
import 'package:serveeasy_app/app/data/models/modifiers/modifiers_response_model.dart';
import 'package:serveeasy_app/app/data/models/order/cart_sumamry_request_model.dart';
import 'package:serveeasy_app/app/data/models/order/cart_summary_response_model.dart'
    as cart_summary;
import 'package:serveeasy_app/app/data/models/user_model.dart';
import 'package:serveeasy_app/app/data/repositories/menu_repositoy.dart';
import 'package:serveeasy_app/app/data/repositories/product_repository.dart';
import 'package:serveeasy_app/app/data/services/dialog_service.dart';
import 'package:serveeasy_app/app/data/services/user_manager.dart';
import 'package:serveeasy_app/app/modules/address/address_list/views/address_list_bottom_sheet.dart';
import 'package:serveeasy_app/app/modules/address/address_list/views/address_list_view.dart';
import 'package:serveeasy_app/app/routes/app_pages.dart';
import 'package:serveeasy_app/core/constants/configuration.dart';

class MainController extends GetxController with GetTickerProviderStateMixin {
  TabController? tabController;
  TabController? modifierTabController;
  TextEditingController commentsController = TextEditingController();
  late AutoScrollController scrollController;
  late AutoScrollController modifierScrollController;
  final MenuRepository _menuRepository = MenuRepository();
  RxBool isLoading = false.obs;
  Configuration configuration = Configuration();
  RxList<TabbarData> mainTabs = RxList<TabbarData>([]);
  RxBool isLoadingMenu = false.obs;
  RxBool isModifiersLoading = false.obs;
  Rxn<MenuData> menuData = Rxn<MenuData>();
  final listViewKey = RectGetter.createGlobalKey();
  final modifierlistViewKey = RectGetter.createGlobalKey();
  Map<int, dynamic> itemKeys = {};
  Map<int, dynamic> modifieritemKeys = {};

  Rx<List<ModifierType>> modifiers = Rx<List<ModifierType>>([]);
  Rx<List<DealComboItems>> dealModifiers = Rx<List<DealComboItems>>([]);

  Rx<CartItem> cartItem = Rx<CartItem>(CartItem(cartItemModifiers: []));
  Rx<Deal> dealItem = Rx<Deal>(Deal(dealItems: []));

  Rx<Map<String, int>> singleSelection = Rx<Map<String, int>>({});

  RxList<CartItem> cartItems = RxList<CartItem>([]);
  RxList<Deal> dealItems = RxList<Deal>([]);

  Rx<cart_summary.Summary> summry =
      Rx<cart_summary.Summary>(cart_summary.Summary.fresh());

  RxList<OrderType> orderTypes = RxList<OrderType>(OrderType.orderTypes);
  Rx<int> selectedOrderTypeIndex = Rx<int>(0);
  Rx<int> current = Rx<int>(0);
  Rxn<User> user = Rxn<User>();
  bool pauseRectGetterIndex = false;

  final List<String> imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80',
  ];

  bool isPresent(int id) => cartItem.value.cartItemModifiers!
      .any((element) => element.modifierId == id);

  // int? getSingleTypeValue(ModifierType modifierClass) =>
  //     singleSelection.value.isEmpty
  //         ? -1
  //         : singleSelection.value[modifierClass.name];

  String getDealModifierPrice(int classIndex, int modifierIndex) =>
      dealModifiers.value[classIndex].salePrice == 0
          ? "Free"
          : dealModifiers.value[classIndex].salePrice.toString();

  int? getSingleTypeValue(
    int modifierIndex, {
    bool isDeal = false,
    int quantityIndex = 0,
    int? modifierClassIndex,
  }) =>
      singleSelection.value.isEmpty
          ? -1
          : isDeal
              ? singleSelection.value[
                  "${dealModifiers.value[modifierIndex].category!.name}"
                      "$quantityIndex"]
              : singleSelection
                  .value[modifiers.value[modifierClassIndex!].name];

  String get getAddress {
    if (user.value == null) {
      return "Loading...";
    }
    return user.value!.addressDetail!.address!;
  }

  String get getBranch {
    if (user.value == null) {
      return "Loading...";
    }
    return user.value!.branchName!;
  }

  @override
  Future<void> onInit() async {
    getMenuData();
    await updateUserData();
    cartItems.value = await UserManager().getUserCart();
    dealItems.value = await UserManager().getUserDeals();
    summry.value = await UserManager().getUserCartSummary();
    scrollController = AutoScrollController();
    modifierScrollController = AutoScrollController();
    setChip();
    super.onInit();
  }

  bool onScrollNotification(ScrollNotification notification) {
    if (pauseRectGetterIndex) return true;
    final int lastTabIndex = tabController!.length - 1;
    final List<int> visibleItems = getVisibleItemsIndex();

    final bool reachLastTabIndex = visibleItems.isNotEmpty &&
        visibleItems.length <= 2 &&
        visibleItems.last == lastTabIndex;
    if (reachLastTabIndex) {
      tabController!.animateTo(lastTabIndex);
    } else if (visibleItems.isNotEmpty) {
      final int sumIndex =
          visibleItems.reduce((value, element) => value + element);
      final int middleIndex = sumIndex ~/ visibleItems.length;
      if (tabController!.index != middleIndex) {
        tabController!.animateTo(middleIndex);
      }
    }
    return false;
  }

  bool modifierOnScrollNotification(ScrollNotification notification) {
    if (pauseRectGetterIndex) return true;
    final int lastTabIndex = modifierTabController!.length - 1;
    final List<int> visibleItems = getModifierVisibleItemsIndex();

    final bool reachLastTabIndex = visibleItems.isNotEmpty &&
        visibleItems.length <= 2 &&
        visibleItems.last == lastTabIndex;
    if (reachLastTabIndex) {
      modifierTabController!.animateTo(lastTabIndex);
    } else if (visibleItems.isNotEmpty) {
      final int sumIndex =
          visibleItems.reduce((value, element) => value + element);
      final int middleIndex = sumIndex ~/ visibleItems.length;
      if (modifierTabController!.index != middleIndex) {
        modifierTabController!.animateTo(middleIndex);
      }
    }
    return false;
  }

  void animateAndScrollTo(int index) {
    pauseRectGetterIndex = true;
    tabController!.animateTo(index);
    scrollController
        .scrollToIndex(index, preferPosition: AutoScrollPosition.begin)
        .then((value) => pauseRectGetterIndex = false);
  }

  void modifierAnimateAndScrollTo(int index) {
    pauseRectGetterIndex = true;
    modifierTabController!.animateTo(index);
    modifierScrollController
        .scrollToIndex(index, preferPosition: AutoScrollPosition.begin)
        .then((value) => pauseRectGetterIndex = false);
  }

  List<int> getVisibleItemsIndex() {
    final Rect? rect = RectGetter.getRectFromKey(listViewKey);
    final List<int> items = [];
    if (rect == null) return items;
    itemKeys.forEach((index, key) {
      final Rect? itemRect = RectGetter.getRectFromKey(key);
      if (itemRect == null) return;
      if (itemRect.top > rect.bottom) return;
      if (itemRect.bottom < rect.top) return;
      items.add(index);
    });
    return items;
  }

  void selectModifier(
    ModifierType modifierList,
    int index, {
    bool insert = false,
  }) {
    if (!modifierList.isSupportMultiSelect) {
      if (!cartItem.value.cartItemModifiers!.any(
        (element) => element.modifierId == modifierList.modifiers![index].id!,
      )) {
        cartItem.value.cartItemModifiers!.removeWhere(
          (element) =>
              element.modifierId == singleSelection.value[modifierList.name!],
        );
        cartItem.value.cartItemModifiers!.add(
          CartItemModifier(
            modifierId: modifierList.modifiers![index].id,
            name: modifierList.modifiers![index].name,
            price: modifierList.modifiers![index].price,
            qty: 1,
          ),
        );
      }
      singleSelection.value[modifierList.name!] =
          modifierList.modifiers![index].id!;
      singleSelection.refresh();
    } else {
      if (!cartItem.value.cartItemModifiers!.any(
            (element) =>
                element.modifierId == modifierList.modifiers![index].id!,
          ) &&
          insert) {
        cartItem.value.cartItemModifiers!.add(
          CartItemModifier(
            modifierId: modifierList.modifiers![index].id,
            name: modifierList.modifiers![index].name,
            price: modifierList.modifiers![index].price,
            qty: 1,
          ),
        );
      } else {
        cartItem.value.cartItemModifiers!.removeWhere(
          (element) => element.modifierId == modifierList.modifiers![index].id!,
        );
      }
    }
    cartItem.refresh();
  }

  void selectDealModifier(
    DealComboItems dealModifier,
    int quntityIndex,
    int productIndex,
  ) {
    final String uniqueCode = "${dealModifier.category!.name}" "$quntityIndex";

    /* Optional Deal Modifier case */

    if (dealModifier.isOptional &&
        dealItem.value.dealItems.any(
          (element) =>
              element.code == uniqueCode &&
              element.productId ==
                  dealModifier.products![productIndex].productId,
        )) {
      dealItem.value.dealItems.removeWhere(
        (element) => element.code == uniqueCode,
      );
      singleSelection.value.remove(uniqueCode);
      singleSelection.refresh();
      dealItem.refresh();
      return;
    }

    /* Required Deal Modifier case */

    if (!dealItem.value.dealItems.any(
      (element) =>
          element.code == uniqueCode &&
          element.productId == dealModifier.products![productIndex].productId,
    )) {
      dealItem.value.dealItems.removeWhere(
        (element) => element.code == uniqueCode,
      );
      dealItem.value.dealItems.add(
        DealItemModifier(
          dealComboItemId: dealModifier.id,
          productId: dealModifier.products![productIndex].productId,
          productName: dealModifier.products![productIndex].product!.name,
          code: uniqueCode,
        ),
      );
    }
    singleSelection.value[uniqueCode] =
        dealModifier.products![productIndex].productId!;
    singleSelection.refresh();
    dealItem.refresh();
  }

  List<int> getModifierVisibleItemsIndex() {
    final Rect? rect = RectGetter.getRectFromKey(modifierlistViewKey);
    final List<int> items = [];
    if (rect == null) return items;
    modifieritemKeys.forEach((index, key) {
      final Rect? itemRect = RectGetter.getRectFromKey(key);
      if (itemRect == null) return;
      if (itemRect.top > rect.bottom) return;
      if (itemRect.bottom < rect.top) return;
      items.add(index);
    });
    return items;
  }

  Future<void> changeOrderType(int index) async {
    selectedOrderTypeIndex(index);
    await UserManager().update(orderType: orderTypes[index].value);
  }

  Future<void> getData() async {
    // if (await getMenuTabs()) {
    await getMenuData();
    // }
  }

  Future<void> getMenuData() async {
    isLoadingMenu.value = true;
    menuData.value = await _menuRepository.getMenuData();
    tabController =
        TabController(vsync: this, length: menuData.value!.menu!.length);
    isLoadingMenu.value = false;
  }

  Future<bool> getMenuTabs() async {
    isLoadingMenu.value = true;
    mainTabs.value = await _menuRepository.getMenuTabs();
    isLoadingMenu.value = false;

    return mainTabs.isNotEmpty;
  }

  Future<void> setChip() async {
    final OrderType selectedOrerType = OrderType.getOrderTypeFromValue(
      user.value!.orderType!,
    );
    selectedOrderTypeIndex.value = orderTypes
        .firstWhere((element) => element.value == selectedOrerType.value)
        .index;
  }

  Future<void> gotoMenu({int menuIndex = 0}) async {
    Get.toNamed(Routes.MENU);
    animateAndScrollTo(menuIndex);
  }

  Future<void> updateUserData() async {
    user.value = await UserManager().getUser();
  }

  Future<void> getProductModifiers(Product product) async {
    modifiers.value.clear();
    modifierTabController = null;
    isModifiersLoading.value = true;
    cartItem.value.productId = product.id;
    cartItem.value.productName = product.name;
    cartItem.value.price = product.price;
    cartItem.value.image = product.productSingleImage.mediaUrl;
    modifiers.value = await ProductRepository()
        .getProductModifiers(cartItem.value.productId!);
    modifierTabController =
        TabController(vsync: this, length: modifiers.value.length);
    singleSelection.value = {};
    isModifiersLoading.value = false;
  }

  Future<void> getDealModifiers(Product product) async {
    isModifiersLoading(true);
    dealModifiers.value.clear();
    modifierTabController = null;
    isModifiersLoading.value = true;
    dealItem.value.dealId = product.id;
    dealItem.value.dealName = product.name;
    dealItem.value.image = product.productSingleImage.mediaUrl;

    /* TODO: major error need to be fixed

    List<DealComboItems> val =
         menuData.value!.dealsCombos![dealIndex].dealComboItems!;
    
    dealModifiers(menuData.value!.dealsCombos![dealIndex].dealComboItems);

    */

    dealModifiers.value =
        await ProductRepository().getDealModifiers(product.id!);
    modifierTabController =
        TabController(vsync: this, length: dealModifiers.value.length);
    singleSelection.value = {};
    num totalModifireSum = 0;

    for (final dealModifier in dealModifiers.value) {
      if (!dealModifier.isOptional) {
        for (var i = 0; i < dealModifier.quantity!; i++) {
          selectDealModifier(dealModifier, i, 0);
          totalModifireSum =
              totalModifireSum + dealModifier.salePrice!.toDouble();
        }
      }
    }
    dealItem.value.price = totalModifireSum;
    dealItem.value.unitPrice = totalModifireSum;
    dealItem.refresh();
    isModifiersLoading.value = false;
  }

  void gotoModifierPage(Product product) {
    product.isDeal ? getDealModifiers(product) : getProductModifiers(product);
    Get.toNamed(Routes.MODIFIER, arguments: product);
  }

  void removeQuantity({bool isDeal = false}) {
    if (isDeal) {
      if (dealItem.value.qty! > 1) {
        dealItem.value.qty = dealItem.value.qty! - 1;
        dealItem.refresh();
      }
      return;
    }
    if (cartItem.value.qty! > 1) {
      cartItem.value.qty = cartItem.value.qty! - 1;
      cartItem.refresh();
    }
  }

  void addQuantity({bool isDeal = false}) {
    if (isDeal) {
      dealItem.value.qty = dealItem.value.qty! + 1;
      dealItem.refresh();
      return;
    }
    cartItem.value.qty = cartItem.value.qty! + 1;
    cartItem.refresh();
  }

  Future<void> addProductToCart({bool isDeal = false}) async {
    if (isDeal) {
      /* Saving deal into cart */

      dealItem.value.instruction = commentsController.text;
      dealItem.value.unitPrice = dealItem.value.price;
      dealItem.value.price = dealItem.value.price! * dealItem.value.qty!;
      dealItems.add(dealItem.value);
    } else {
      /* Saving product into cart */

      cartItem.value.instruction = commentsController.text;
      cartItem.value.unitPrice = cartItem.value.price;
      cartItem.value.price = cartItem.value.price! * cartItem.value.qty!;
      num totalModifireSum = 0;
      for (final modifier in cartItem.value.cartItemModifiers!) {
        totalModifireSum =
            totalModifireSum + (modifier.price! * cartItem.value.qty!);
      }
      cartItem.value.price = cartItem.value.price! + totalModifireSum.toInt();
      cartItems.add(cartItem.value);
    }
    setSummary();
    resetData();
    await saveCartToLocalDB();
    Get.back(result: false);
  }

  Future<void> saveCartToLocalDB() async {
    await UserManager()
        .saveUserCartandSummary(cartItems, dealItems, summry.value);
  }

  void setSummary() {
    num sum = 0;
    for (final element in cartItems) {
      sum = sum + element.price!;
    }
    for (final dealItem in dealItems) {
      sum = sum + dealItem.price!;
    }
    summry.value.netAmount = sum;
    summry.value.grossAmount = sum;
    summry.refresh();
  }

  void resetData() {
    cartItem.value = CartItem(cartItemModifiers: []);
    dealItem.value = Deal(dealItems: []);
    commentsController.text = '';
  }

  Future<void> resetModifiers() async {
    cartItem.value.cartItemModifiers = [];
    singleSelection.value = {};
    cartItem.refresh();
    await saveCartToLocalDB();
  }

  Future<void> remove(CartItem cartItem) async {
    final bool? confirmClear = await DialogService().showConfirmationDialog(
      title: 'Warning',
      description: 'Are you sure you want to delete this item?',
    );
    if (!confirmClear!) return;
    cartItems
        .removeWhere((element) => element.productName == cartItem.productName);
    setSummary();
    cartItems.refresh();
    if (cartItems.isEmpty) {
      await saveCartToLocalDB();
      Get.back();
    }
  }

  Future<void> removeDeal(Deal dealItem) async {
    final bool? confirmClear = await DialogService().showConfirmationDialog(
      title: 'Warning',
      description: 'Are you sure you want to delete this item?',
    );
    if (!confirmClear!) return;
    dealItems.removeWhere((element) => element.dealName == dealItem.dealName);
    dealItems.refresh();
    if (dealItems.isEmpty) {
      await saveCartToLocalDB();
      Get.back();
    }
  }

  Future<void> addCartItemQuantity(int index) async {
    cartItems[index].qty = cartItems[index].qty! + 1;
    cartItems.refresh();
    await saveCartToLocalDB();
  }

  Future<void> addDealItemQuantity(int index) async {
    dealItems[index].qty = dealItems[index].qty! + 1;
    dealItems.refresh();
    await saveCartToLocalDB();
  }

  Future<void> removeCartItemQuantity(int index) async {
    if (cartItems[index].qty! > 1) {
      cartItems[index].qty = cartItems[index].qty! - 1;
      cartItems.refresh();
      await saveCartToLocalDB();
    }
  }

  Future<void> removeDealItemQuantity(int index) async {
    if (dealItems[index].qty! > 1) {
      dealItems[index].qty = dealItems[index].qty! - 1;
      dealItems.refresh();
      await saveCartToLocalDB();
    }
  }

  Future<void> clearCart() async {
    final bool? confirmClear = await DialogService().showConfirmationDialog(
      title: 'Warning',
      description: 'Are you sure you want to clear the cart?',
    );
    if (confirmClear!) cartItems.removeWhere((element) => element.id == null);
    if (cartItems.isEmpty) {
      await saveCartToLocalDB();
      Get.back();
    }
  }

  Future<void> proceedToCheckout() async {
    final RepositoryResponse<Address> savedAddress =
        await UserManager().hasAnySavedAddress();
    if (savedAddress.isSuccess && savedAddress.data!.isSavedOnBackend) {
      Get.toNamed(Routes.CHECKOUT);
      return;
    }
    Get.toNamed(
      Routes.ADDRESS_LIST,
      arguments: AddressListViewParams(fromCheckoutView: false),
    );
  }

  void gotoBranchListing() {
    Get.offAllNamed(Routes.BRANCH_LIST);
  }

  Future<void> gotoCart() async {
    await Get.toNamed(Routes.CART);
    await updateUserData();
  }

  Future<void> addressBottomsheet() async {
    final dynamic res = await Get.bottomSheet(const AddressBottomSheet());
    if (res != null && res) {
      await updateUserData();
      Get.offAllNamed(Routes.BRANCH_LIST);
    }
  }
}
