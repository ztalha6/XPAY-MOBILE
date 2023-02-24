import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:rect_getter/rect_getter.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:serveeasy_app/app/data/models/menu/menu_data_response_model.dart';
import 'package:serveeasy_app/app/data/models/modifiers/modifiers_response_model.dart';
import 'package:serveeasy_app/app/data/widgets/cached_image_widget.dart';
import 'package:serveeasy_app/app/data/widgets/custom_text_form_field.dart';
import 'package:serveeasy_app/app/data/widgets/primary_button.dart';
import 'package:serveeasy_app/app/modules/home_summary/controllers/main_controller.dart';
import 'package:sizer/sizer.dart';

class ModifierView extends GetView {
  const ModifierView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Product product = Get.arguments;
    Get.put(MainController());
    return GetX<MainController>(
      builder: (model) {
        return Scaffold(
          body: Stack(
            children: [
              NestedScrollView(
                // controller: model.modifierScrollController,
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverAppBar(
                      pinned: true,
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      expandedHeight: 250,
                      flexibleSpace: FlexibleSpaceBar(
                        background: CachedImageWidget(
                          url: product.productSingleImage.mediaUrl!,
                        ),
                      ),
                      actions: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: TextButton(
                            onPressed: () {
                              model.resetModifiers();
                            },
                            child: Text(
                              "Reset",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(
                                    color: Colors.black,
                                  ),
                            ),
                          ),
                        )
                      ],
                    )
                  ];
                },
                body: Builder(
                  builder: (context) {
                    return Obx(
                      () => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 16.0,
                              right: 16,
                              top: 16,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 250,
                                      child: Text(
                                        product.name!,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayLarge,
                                      ),
                                    ),
                                    Text(
                                      "\$ ${product.price}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayLarge!
                                          .copyWith(
                                            fontSize: 16,
                                            color: const Color(0xFF707581),
                                          ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  product.description!,
                                  maxLines: 3,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          if (model.isModifiersLoading.isTrue)
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              child: LinearProgressIndicator(
                                color: model.configuration.secondaryColor,
                                backgroundColor: model
                                    .configuration.secondaryColor
                                    .withOpacity(0.5),
                              ),
                            )
                          else
                            TabBar(
                              isScrollable: true,
                              controller: model.modifierTabController,
                              indicatorPadding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                              ),
                              indicatorColor:
                                  model.configuration.secondaryColor,
                              labelColor: Theme.of(context).primaryColor,
                              unselectedLabelColor: Colors.grey,
                              indicatorWeight: 3.0,
                              labelStyle: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                  .copyWith(fontSize: 14),
                              unselectedLabelStyle:
                                  Theme.of(context).textTheme.headlineMedium,
                              tabs: product.isDeal
                                  ? model.dealModifiers.value.map((e) {
                                      return Tab(text: e.category!.name);
                                    }).toList()
                                  : model.modifiers.value.map((e) {
                                      return Tab(text: e.name);
                                    }).toList(),
                              onTap: (index) =>
                                  model.modifierAnimateAndScrollTo(index),
                            ),
                          Expanded(
                            child: RectGetter(
                              key: model.modifierlistViewKey,
                              child: NotificationListener<ScrollNotification>(
                                onNotification:
                                    model.modifierOnScrollNotification,
                                child: CustomScrollView(
                                  controller: model.modifierScrollController,
                                  slivers: [
                                    if (model.isModifiersLoading.isFalse)
                                      SliverList(
                                        delegate: SliverChildBuilderDelegate(
                                          (context, index) {
                                            model.modifieritemKeys[index] =
                                                RectGetter.createGlobalKey();
                                            DealComboItems dealModifierClass =
                                                DealComboItems();
                                            ModifierType modifierClass =
                                                ModifierType();
                                            if (product.isDeal) {
                                              dealModifierClass = model
                                                  .dealModifiers.value[index];
                                            } else {
                                              modifierClass =
                                                  model.modifiers.value[index];
                                            }
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                top: 16.0,
                                              ),
                                              child: RectGetter(
                                                key: model
                                                    .modifieritemKeys[index],
                                                child: AutoScrollTag(
                                                  key: ValueKey(index),
                                                  index: index,
                                                  controller: model
                                                      .modifierScrollController,
                                                  child: product.isDeal
                                                      ? DealModifierSection(
                                                          modifierClass:
                                                              dealModifierClass,
                                                          modifierIndex: index,
                                                        )
                                                      : ModifierSection(
                                                          modifierClass:
                                                              modifierClass,
                                                          modifierClassIndex:
                                                              index,
                                                        ),
                                                ),
                                              ),
                                            );
                                          },
                                          childCount: product.isDeal
                                              ? model.dealModifiers.value.length
                                              : model.modifiers.value.length,
                                        ),
                                      ),
                                    SliverList(
                                      delegate: SliverChildBuilderDelegate(
                                        childCount: 1,
                                        (BuildContext context, int index) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 16.0,
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Add Comments",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .displaySmall!
                                                      .copyWith(
                                                        fontSize: 14,
                                                        color: Colors.black,
                                                      ),
                                                ),
                                                const SizedBox(height: 10),
                                                Text(
                                                  "Give us additional information about your order",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .displaySmall!
                                                      .copyWith(
                                                        fontSize: 14,
                                                        color: const Color(
                                                          0xFF707581,
                                                        ),
                                                      ),
                                                ),
                                                CustomTextFormField(
                                                  controller:
                                                      model.commentsController,
                                                  hintText:
                                                      "Your comments here",
                                                  keyboardType: TextInputType
                                                      .emailAddress,
                                                  textInputAction:
                                                      TextInputAction.next,
                                                ),
                                                const SizedBox(height: 10),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 12.h),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Positioned(
                bottom: 0.h,
                child: Container(
                  width: Get.width,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15.0),
                      topLeft: Radius.circular(15.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 3,
                          child: SizedBox(
                            // width: 38.w,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 42,
                                  child: RawMaterialButton(
                                    onPressed: () {
                                      model.removeQuantity(
                                        isDeal: product.isDeal,
                                      );
                                    },
                                    elevation: 0,
                                    fillColor: Colors.white,
                                    padding: const EdgeInsets.all(10.0),
                                    // shape: const CircleBorder(),
                                    shape: const RoundedRectangleBorder(
                                      side: BorderSide(),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10.0),
                                      ),
                                    ),
                                    child: const Icon(
                                      Icons.remove,
                                      size: 20,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                Text(
                                  product.isDeal
                                      ? model.dealItem.value.qty.toString()
                                      : model.cartItem.value.qty.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall!
                                      .copyWith(
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),
                                ),
                                SizedBox(
                                  width: 42,
                                  child: RawMaterialButton(
                                    onPressed: () {
                                      model.addQuantity(
                                        isDeal: product.isDeal,
                                      );
                                    },
                                    elevation: 0,
                                    fillColor: Colors.white,
                                    padding: const EdgeInsets.all(10.0),
                                    shape: const RoundedRectangleBorder(
                                      side: BorderSide(),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10.0),
                                      ),
                                    ),
                                    // shape: const CircleBorder(),
                                    child: const Icon(
                                      Icons.add,
                                      color: Colors.black,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: SizedBox(
                            height: 12.h,
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: Get.height * 0.035,
                                bottom: Get.height * 0.028,
                                left: Get.width * 0.250,
                                right: Get.width * 0.040,
                              ),
                              child: PrimaryButton(
                                text: 'Add To Cart',
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .copyWith(
                                      fontWeight: FontWeight.w500,
                                      // fontSize: 13,
                                      color: model.configuration.secondaryColor,
                                    ),
                                onTap: () {
                                  model.addProductToCart(
                                    isDeal: product.isDeal,
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class ModifierSection extends StatelessWidget {
  const ModifierSection({
    Key? key,
    required this.modifierClass,
    required this.modifierClassIndex,
  }) : super(key: key);

  final ModifierType modifierClass;
  final int modifierClassIndex;

  @override
  Widget build(BuildContext context) {
    return GetX<MainController>(
      builder: (model) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          margin: const EdgeInsets.only(bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      modifierClass.name!,
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                    ),
                    Text(
                      modifierClass.isSupportMultiSelect
                          ? "Select Many"
                          : "Select One",
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                fontSize: 12,
                              ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2.h),
              for (int index = 0;
                  index < modifierClass.modifiers!.length;
                  index++)
                Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: ListTile(
                    onTap: () {
                      model.selectModifier(
                        modifierClass,
                        index,
                      );
                    },
                    title: Text(
                      modifierClass.modifiers![index].name!,
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                color: const Color(0xFF646C7C),
                              ),
                    ),
                    subtitle: Text(
                      " (\$ ${modifierClass.modifiers![index].price})",
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                color: const Color(0xFF646C7C),
                              ),
                    ),
                    leading: modifierClass.isSupportMultiSelect
                        ? SizedBox(
                            height: Get.height * 0.06,
                            width: Get.width * 0.12,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                8,
                              ),
                              child: CachedImageWidget(
                                url: modifierClass
                                            .modifiers![index].modifierImage ==
                                        null
                                    ? ""
                                    : modifierClass.modifiers![index]
                                        .modifierImage!.mediaUrl!,
                              ),
                            ),
                          )
                        : null,
                    dense: true,
                    trailing: modifierClass.isSupportMultiSelect
                        ? Transform.scale(
                            scale: 1.2,
                            child: Checkbox(
                              activeColor: model.configuration.secondaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              onChanged: (bool? value) {
                                model.selectModifier(
                                  modifierClass,
                                  index,
                                  insert: value!,
                                );
                              },
                              value: model.isPresent(
                                modifierClass.modifiers![index].id!,
                              ),
                            ),
                          )
                        : Transform.scale(
                            scale: 1.2,
                            child: Radio<int>(
                              activeColor: model.configuration.secondaryColor,
                              value: modifierClass.modifiers![index].id!,
                              groupValue: model.getSingleTypeValue(
                                modifierClassIndex: modifierClassIndex,
                                index,
                              ),
                              onChanged: (int? value) {
                                model.selectModifier(
                                  modifierClass,
                                  index,
                                );
                                model.modifiers.refresh();
                              },
                            ),
                          ),
                  ),
                )
            ],
          ),
        );
      },
    );
  }
}

class DealModifierSection extends StatelessWidget {
  const DealModifierSection({
    Key? key,
    required this.modifierClass,
    required this.modifierIndex,
  }) : super(key: key);

  final DealComboItems modifierClass;
  final int modifierIndex;

  @override
  Widget build(BuildContext context) {
    return GetX<MainController>(
      builder: (model) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          margin: const EdgeInsets.only(bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      modifierClass.category!.name!,
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                    ),
                    Text(
                      modifierClass.isOptional ? "Optional" : "Required",
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                fontSize: 12,
                              ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2.h),
              for (int quantityIndex = 0;
                  quantityIndex < modifierClass.quantity!;
                  quantityIndex++)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: 3.w,
                        top: 1.h,
                      ),
                      child: Text(
                        "Choice ${quantityIndex + 1}",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(fontSize: 14),
                      ),
                    ),
                    const SizedBox(height: 10),
                    for (int productIndex = 0;
                        productIndex < modifierClass.products!.length;
                        productIndex++)
                      Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: ListTile(
                          onTap: () {
                            model.selectDealModifier(
                              modifierClass,
                              quantityIndex,
                              productIndex,
                            );
                          },
                          title: Text(
                            modifierClass
                                .products![productIndex].product!.name!,
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                                  color: const Color(0xFF646C7C),
                                ),
                          ),
                          subtitle: Text(
                            " (\$ ${modifierClass.salePrice})",
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                                  color: const Color(0xFF646C7C),
                                ),
                          ),
                          leading: SizedBox(
                            height: Get.height * 0.06,
                            width: Get.width * 0.12,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                8,
                              ),
                              child: CachedImageWidget(
                                url: modifierClass.products![productIndex]
                                    .product!.productSingleImage.mediaUrl!,
                              ),
                            ),
                          ),
                          dense: true,
                          trailing: Transform.scale(
                            scale: Get.height * 0.0015,
                            child: Radio<int>(
                              activeColor: model.configuration.secondaryColor,
                              value: modifierClass
                                  .products![productIndex].productId!,
                              groupValue: model.getSingleTypeValue(
                                modifierIndex,
                                isDeal: true,
                                quantityIndex: quantityIndex,
                              ),
                              onChanged: (int? value) {
                                model.selectDealModifier(
                                  modifierClass,
                                  quantityIndex,
                                  productIndex,
                                );
                                model.dealModifiers.refresh();
                              },
                            ),
                          ),
                        ),
                      )
                  ],
                )
            ],
          ),
        );
      },
    );
  }
}
