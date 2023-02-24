import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:serveeasy_app/app/data/widgets/custom_text_form_field.dart';
import 'package:serveeasy_app/app/data/widgets/pagination_list_widget.dart';
import 'package:serveeasy_app/app/data/widgets/product_card_widget.dart';
import 'package:serveeasy_app/app/modules/home_summary/controllers/main_controller.dart';
import 'package:serveeasy_app/app/modules/search_product/controllers/search_product_controller.dart';
import 'package:serveeasy_app/core/constants/asset_constants.dart';

class SearchProductView extends StatelessWidget {
  const SearchProductView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(SearchProductController());
    final MainController mainController = Get.put(MainController());
    return GetX<SearchProductController>(
      builder: (model) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            toolbarHeight: 80,
            title: Row(
              children: [
                Expanded(
                  child: CustomTextFormField(
                    reduceContentPadding: true,
                    controller: model.seacrhTextController,
                    perfixIcon: Image.asset(
                      searchIcon,
                      scale: 3,
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(
                        Icons.clear,
                        size: 25,
                        color: Colors.grey,
                      ),
                      splashRadius: 20,
                      onPressed: () {
                        model.clearSearches();
                      },
                    ),
                    hintText: "Search",
                    textInputAction: TextInputAction.search,
                    keyboardType: TextInputType.text,
                    onDone: (s) => model.search(withSearch: true),
                  ),
                ),
              ],
            ),
            centerTitle: false,
            actions: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0, right: 8.0),
                child: TextButton(
                  onPressed: () {
                    model.oncancelTap();
                  },
                  child: Text(
                    'Cancel',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
              ),
            ],
          ),
          body: PaginationListWidget(
            isLoading: model.isSearching.value,
            padding: const EdgeInsets.all(16),
            enablePullDown: false,
            list: model.searchedProducts,
            controller: model.searchController,
            onLoading: model.onLoading,
            listItemWidget: (index) {
              return ProductCard(
                product: model.searchedProducts[index],
                onTap: () {
                  mainController.gotoModifierPage(
                    model.searchedProducts[index],
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
