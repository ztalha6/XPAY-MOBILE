import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:serveeasy_app/app/data/models/menu/menu_data_response_model.dart';
import 'package:serveeasy_app/app/data/widgets/product_card_widget.dart';
import 'package:serveeasy_app/app/modules/home_summary/controllers/main_controller.dart';

class MenuSection extends StatelessWidget {
  const MenuSection({
    Key? key,
    required this.menu,
  }) : super(key: key);

  final Menu menu;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: List.generate(
          menu.allProducts.length,
          (index) {
            return GetX<MainController>(
              builder: (model) {
                return ProductCard(
                  product: menu.allProducts[index],
                  onTap: model.isModifiersLoading.isTrue
                      ? null
                      : () {
                          model.gotoModifierPage(
                            menu.allProducts[index],
                          );
                        },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
