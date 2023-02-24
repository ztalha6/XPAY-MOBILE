import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:get/get.dart';
import 'package:serveeasy_app/app/data/models/user_model.dart';
import 'package:serveeasy_app/app/data/repositories/user_repository.dart';
import 'package:serveeasy_app/app/data/services/user_manager.dart';
import 'package:serveeasy_app/app/modules/drawer/controllers/menu_class.dart';
import 'package:serveeasy_app/app/modules/home_summary/views/home_summary_view.dart';
import 'package:serveeasy_app/app/modules/order/order_history/views/order_history_view.dart';
import 'package:serveeasy_app/app/modules/profile/profile_menu/views/profile_menu_view.dart';
import 'package:serveeasy_app/app/modules/settings/views/settings_view.dart';
import 'package:serveeasy_app/app/routes/app_pages.dart';
import 'package:serveeasy_app/core/constants/asset_constants.dart';
import 'package:serveeasy_app/core/constants/configuration.dart';

class DrawerViewController extends GetxController {
  RxInt currentIndex = 0.obs;
  Configuration configuration = Configuration();
  ZoomDrawerController drawerController = ZoomDrawerController();
  // RxString userName = "S".obs;
  Rxn<User> user = Rxn<User>();
  List<MenuClass> menuItems = [
    const MenuClass(
      0,
      "Home",
      orderListIcon,
      HomeSummaryView(),
    ),
    const MenuClass(
      1,
      "My Orders",
      orderListIcon,
      OrderHistoryView(),
    ),
    const MenuClass(
      2,
      "Terms & Conditions",
      termsIcon,
      OrderHistoryView(),
    ),
    const MenuClass(
      3,
      "FAQ's",
      faqIcon,
      OrderHistoryView(),
    ),
    const MenuClass(
      4,
      "Privacy Policy",
      privacyIcon,
      OrderHistoryView(),
    ),
    const MenuClass(
      5,
      "Profile",
      privacyIcon,
      ProfileMenuView(),
    ),
    const MenuClass(
      6,
      "Settings",
      settingIcon,
      SettingsView(),
    ),
  ];

  String get getFirstLetter =>
      user.value == null ? "S" : user.value!.fullName!.characters.first;

  bool get isGuest {
    if (user.value == null) return true;
    return user.value!.isGuest == 1;
  }

  @override
  Future<void> onInit() async {
    user(await UserManager().getUser());
    if (isGuest) {
      menuItems.removeAt(1);
      menuItems.removeAt(4);
    }
    super.onInit();
  }

  void toggleDrawer() {
    debugPrint("Toggle drawer");
    drawerController.toggle?.call();
    update();
  }

  RxBool isLoading = false.obs;

  void changePage(int i) {
    currentIndex(i);
    toggleDrawer();
  }

  Future<void> logoutUser() async {
    await UserRepository().logout();
    Get.offAllNamed(Routes.SIGN_IN);
  }

  onSignInTap() {
    Get.toNamed(Routes.SIGN_IN);
  }
}
