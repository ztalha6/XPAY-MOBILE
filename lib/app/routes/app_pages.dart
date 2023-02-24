import 'package:get/get.dart';

import '../modules/address/address_detail/bindings/address_detail_binding.dart';
import '../modules/address/address_detail/views/address_detail_view.dart';
import '../modules/address/address_list/bindings/address_list_binding.dart';
import '../modules/address/address_list/views/address_list_view.dart';
import '../modules/address/verify_address/bindings/verify_address_binding.dart';
import '../modules/address/verify_address/views/verify_address_view.dart';
import '../modules/auth/create_password/bindings/create_password_binding.dart';
import '../modules/auth/create_password/views/create_password_view.dart';
import '../modules/auth/forget_passsword/bindings/forget_passsword_binding.dart';
import '../modules/auth/forget_passsword/views/forget_passsword_view.dart';
import '../modules/auth/onboarding/bindings/onboarding_binding.dart';
import '../modules/auth/onboarding/views/onboarding_view.dart';
import '../modules/auth/sign_in/bindings/sign_in_binding.dart';
import '../modules/auth/sign_in/views/sign_in_view.dart';
import '../modules/auth/sign_up/bindings/sign_up_binding.dart';
import '../modules/auth/sign_up/views/sign_up_view.dart';
import '../modules/auth/verify_otp/bindings/verify_otp_binding.dart';
import '../modules/auth/verify_otp/views/verify_otp_view.dart';
import '../modules/branch_list/bindings/branch_list_binding.dart';
import '../modules/branch_list/views/branch_list_view.dart';
import '../modules/cart/bindings/cart_binding.dart';
import '../modules/cart/views/cart_view.dart';
import '../modules/checkout/bindings/checkout_binding.dart';
import '../modules/checkout/payment/bindings/payment_binding.dart';
import '../modules/checkout/payment/views/payment_view.dart';
import '../modules/checkout/promo/bindings/promo_binding.dart';
import '../modules/checkout/promo/views/promo_view.dart';
import '../modules/checkout/views/checkout_view.dart';
import '../modules/drawer/bindings/drawer_binding.dart';
import '../modules/drawer/views/drawer_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/home_summary/bindings/home_summary_binding.dart';
import '../modules/home_summary/views/home_summary_view.dart';
import '../modules/location/ask_location/bindings/ask_location_binding.dart';
import '../modules/location/ask_location/views/ask_location_view.dart';
import '../modules/location/bindings/location_binding.dart';
import '../modules/location/views/location_view.dart';
import '../modules/menu/views/menu_view.dart';
import '../modules/modifier/bindings/modifier_binding.dart';
import '../modules/modifier/views/modifier_view.dart';
import '../modules/order/order_detail/bindings/order_detail_binding.dart';
import '../modules/order/order_detail/views/order_detail_view.dart';
import '../modules/order/order_history/bindings/order_history_binding.dart';
import '../modules/order/order_history/views/order_history_view.dart';
import '../modules/order/order_success/bindings/order_success_binding.dart';
import '../modules/order/order_success/views/order_success_view.dart';
import '../modules/profile/delete_account/bindings/delete_account_binding.dart';
import '../modules/profile/delete_account/views/delete_account_view.dart';
import '../modules/profile/edit_profile/bindings/edit_profile_binding.dart';
import '../modules/profile/edit_profile/views/edit_profile_view.dart';
import '../modules/profile/profile_menu/bindings/profile_menu_binding.dart';
import '../modules/profile/profile_menu/views/profile_menu_view.dart';
import '../modules/search_product/bindings/search_product_binding.dart';
import '../modules/search_product/views/search_product_view.dart';
import '../modules/settings/bindings/settings_binding.dart';
import '../modules/settings/views/settings_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_IN,
      page: () => const SignInView(),
      binding: SignInBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_UP,
      page: () => const SignUpView(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: _Paths.FORGET_PASSSWORD,
      page: () => const ForgetPassswordView(),
      binding: ForgetPassswordBinding(),
    ),
    GetPage(
      name: _Paths.VERIFY_OTP,
      page: () => VerifyOtpView(
        fromSignUp: Get.arguments[0],
        fromSignIn: Get.arguments[1],
        email: Get.arguments[2],
      ),
      binding: VerifyOtpBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_PASSWORD,
      page: () => const CreatePasswordView(),
      binding: CreatePasswordBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.LOCATION,
      page: () => const LocationView(),
      binding: LocationBinding(),
      children: [
        GetPage(
          name: _Paths.ASK_LOCATION,
          page: () => const AskLocationView(),
          binding: AskLocationBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.BRANCH_LIST,
      page: () => const BranchListView(),
      binding: BranchListBinding(),
    ),
    GetPage(
      name: _Paths.HOME_SUMMARY,
      page: () => const HomeSummaryView(),
      binding: HomeSummaryBinding(),
    ),
    GetPage(
      name: _Paths.DRAWER,
      page: () => const DrawerView(),
      binding: DrawerBinding(),
    ),
    GetPage(
      name: _Paths.MENU,
      page: () => const MenuView(),
      // binding: MenuBinding(),
    ),
    GetPage(
      name: _Paths.MODIFIER,
      page: () => const ModifierView(),
      binding: ModifierBinding(),
    ),
    GetPage(
      name: _Paths.CART,
      page: () => const CartView(),
      binding: CartBinding(),
    ),
    GetPage(
      name: _Paths.CHECKOUT,
      page: () => const CheckoutView(),
      binding: CheckoutBinding(),
      children: [
        GetPage(
          name: _Paths.PROMO,
          page: () => const PromoView(),
          binding: PromoBinding(),
        ),
        GetPage(
          name: _Paths.PAYMENT,
          page: () => const PaymentView(),
          binding: PaymentBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.ADDRESS_DETAIL,
      page: () => const AddressDetailView(),
      binding: AddressDetailBinding(),
    ),
    GetPage(
      name: _Paths.ADDRESS_LIST,
      page: () => const AddressListView(),
      binding: AddressListBinding(),
    ),
    GetPage(
      name: _Paths.VERIFY_ADDRESS,
      page: () => const VerifyAddressView(),
      binding: VerifyAddressBinding(),
    ),
    GetPage(
      name: _Paths.ORDER_SUCCESS,
      page: () => const OrderSuccessView(),
      binding: OrderSuccessBinding(),
    ),
    GetPage(
      name: _Paths.ORDER_DETAIL,
      page: () => const OrderDetailView(),
      binding: OrderDetailBinding(),
    ),
    GetPage(
      name: _Paths.ORDER_HISTORY,
      page: () => const OrderHistoryView(),
      binding: OrderHistoryBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH_PRODUCT,
      page: () => const SearchProductView(),
      binding: SearchProductBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE_MENU,
      page: () => const ProfileMenuView(),
      binding: ProfileMenuBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_PROFILE,
      page: () => const EditProfileView(),
      binding: EditProfileBinding(),
    ),
    GetPage(
      name: _Paths.DELETE_ACCOUNT,
      page: () => const DeleteAccountView(),
      binding: DeleteAccountBinding(),
    ),
    GetPage(
      name: _Paths.SETTINGS,
      page: () => const SettingsView(),
      binding: SettingsBinding(),
    ),
  ];
}
