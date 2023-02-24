import 'package:serveeasy_app/app/data/enum/order_types.dart';
import 'package:serveeasy_app/app/data/models/base_response_model.dart';
import 'package:serveeasy_app/app/data/models/menu/main_menu_tabbar_respone_model.dart';
import 'package:serveeasy_app/app/data/models/menu/menu_data_response_model.dart';
import 'package:serveeasy_app/app/data/services/api_service/menu_service.dart';
import 'package:serveeasy_app/app/data/services/exception_handler.dart';
import 'package:serveeasy_app/app/data/services/snackbar_manager.dart';
import 'package:serveeasy_app/app/data/services/user_manager.dart';

class MenuRepository {
  static int currentCustomMenuId = 0;
  Future<List<TabbarData>> getMenuTabs() async {
    try {
      // final Box<String> box = await Hive.openBox<String>('menuTabBox');
      // if (box.isEmpty || !box.containsKey("menuTabs")) {
      final int eshId = (await UserManager().getUser())!.establishmentId!;
      const int orderType = 40;
      final ResponseModel<MainMenuTabbarResponse> responseModel =
          await ResponseModel.fromApiResponse<MainMenuTabbarResponse>(
        () async => await MenuApiService().getMainTabbar(eshId, orderType),
        (body) => MainMenuTabbarResponse.fromJson(body),
      );
      if (responseModel.status == ResponseStatus.success) {
        // await box.put(
        //   "menuTabs",
        //   json.encode(responseModel.response!.toJson()),
        // );
        currentCustomMenuId =
            responseModel.response!.data!.tabbarItem!.first.id!;
        return responseModel.response!.data!.tabbarItem!;
      } else if (responseModel.status == ResponseStatus.responseError ||
          responseModel.status == ResponseStatus.nullResponse) {
        SnackbarManager().showAlertSnackbar(responseModel.error!);
        return [];
      }
      // } else {
      //   return MainMenuTabbarResponse.fromJson(
      //     jsonDecode(box.get("menuTabs")!) as Map<String, dynamic>,
      //   ).data!.tabbarItem!;
      // }
    } on Exception catch (e) {
      ExceptionHandler().handle(e);
    }
    return [];
  }

  Future<MenuData?> getMenuData() async {
    try {
      // final Box<String> box = await Hive.openBox<String>('menuBox');

      // if (box.isEmpty || !box.containsKey(tabId)) {
      final int eshId = (await UserManager().getUser())!.establishmentId!;
      final ResponseModel<MenuDataResponse> responseModel =
          await ResponseModel.fromApiResponse<MenuDataResponse>(
        () async =>
            await MenuApiService().getMenuData(OrderType.online.value, eshId),
        (body) => MenuDataResponse.fromJson(body),
      );
      if (responseModel.status == ResponseStatus.success) {
        // await box.put(
        //   tabId,
        //   json.encode(responseModel.response!.data!.toJson()),
        // );

        if (responseModel.response!.data!.dealsCombos != null) {
          for (final deal in responseModel.response!.data!.dealsCombos!) {
            final List<Product> items = [];
            items.add(
              Product(
                id: deal.id,
                productSingleImage: ProductSingleImage(
                    mediaUrl: deal.dealComboImage == null
                        ? ''
                        : deal.dealComboImage!.mediaUrl,),
                name: deal.name,
                price: deal.totalSalePrice,
                description: deal.getModifierString,
                isDeal: true,
              ),
            );
            responseModel.response!.data!.menu!.insert(
              0,
              Menu(
                id: deal.id,
                name: deal.name,
                allProducts: items,
                categoryImage: CategoryImage(
                    mediaUrl: deal.dealComboImage == null
                        ? ''
                        : deal.dealComboImage!.mediaUrl,),
              ),
            );
          }
        }
        return responseModel.response!.data!;
      } else if (responseModel.status == ResponseStatus.responseError ||
          responseModel.status == ResponseStatus.nullResponse) {
        SnackbarManager().showAlertSnackbar(responseModel.error!);
      }
      // } else {
      //   return MenuData.fromJson(
      //     jsonDecode(box.get(tabId)!) as Map<String, dynamic>,
      //   );
      // }
    } on Exception catch (e) {
      ExceptionHandler().handle(e);
    }
    return null;
  }
}
