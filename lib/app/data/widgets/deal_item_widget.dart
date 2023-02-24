import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:serveeasy_app/app/data/models/order/cart_sumamry_request_model.dart';
import 'package:serveeasy_app/app/data/widgets/cached_image_widget.dart';
import 'package:serveeasy_app/core/constants/configuration.dart';

class DealItemWidget extends StatelessWidget {
  const DealItemWidget({
    Key? key,
    required this.dealItem,
    required this.onAdd,
    required this.onRemove,
    this.configuration,
    required this.onDelete,
  }) : super(key: key);
  final Deal dealItem;
  final Function()? onAdd;
  final Function()? onRemove;
  final Function()? onDelete;
  final Configuration? configuration;

  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
      child: Card(
        elevation: 0,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0, top: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: SizedBox(
                      height: 100,
                      width: 100,
                      child: CachedImageWidget(url: dealItem.image ?? ""),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: Get.width / 1.9,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 145,
                              child: Text(
                                dealItem.dealName!,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .copyWith(color: Colors.black),
                              ),
                            ),
                            IconButton(
                              splashRadius: 20,
                              onPressed: onDelete,
                              icon: const Icon(
                                Icons.delete_outline_rounded,
                                color: Colors.grey,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: Get.width / 1.9,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Text(
                                "\$ ${dealItem.price!}",
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .copyWith(
                                      color: Colors.black,
                                    ),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 42,
                                    child: RawMaterialButton(
                                      onPressed: onRemove,
                                      elevation: 0,
                                      fillColor: Colors.white,
                                      padding: const EdgeInsets.all(10.0),
                                      // shape: const CircleBorder(),
                                      shape: const RoundedRectangleBorder(
                                        side: BorderSide(color: Colors.grey),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10.0),
                                        ),
                                      ),
                                      child: const Icon(
                                        Icons.remove,
                                        size: 20,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    dealItem.qty.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium!
                                        .copyWith(
                                          color: Colors.black,
                                        ),
                                  ),
                                  SizedBox(
                                    width: 42,
                                    child: RawMaterialButton(
                                      onPressed: onAdd,
                                      elevation: 0,
                                      fillColor: configuration == null
                                          ? Colors.white
                                          : Theme.of(context).primaryColor,
                                      padding: const EdgeInsets.all(10.0),
                                      shape: const RoundedRectangleBorder(
                                        side: BorderSide(),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10.0),
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.add,
                                        color: configuration == null
                                            ? Colors.black
                                            : configuration!.secondaryColor,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Visibility(
              visible: dealItem.dealItems.isNotEmpty ||
                  dealItem.instruction!.isNotEmpty,
              child: ScrollOnExpand(
                scrollOnCollapse: false,
                child: ExpandablePanel(
                  theme: const ExpandableThemeData(
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    tapBodyToCollapse: true,
                  ),
                  header: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Text(
                          "Details",
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          "Tap to see deatils",
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ],
                    ),
                  ),
                  collapsed: const SizedBox.shrink(),
                  expanded: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      for (int i = 0; i < dealItem.dealItems.length; i++)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text(
                            dealItem.dealItems[i].productName!,
                            softWrap: true,
                            overflow: TextOverflow.fade,
                          ),
                        ),
                      Text(
                        "Comments: ",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(color: Colors.black),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        dealItem.instruction!,
                        softWrap: true,
                        overflow: TextOverflow.fade,
                      )
                    ],
                  ),
                  builder: (_, collapsed, expanded) {
                    return Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                        bottom: 10,
                      ),
                      child: Expandable(
                        collapsed: collapsed,
                        expanded: expanded,
                        theme: const ExpandableThemeData(
                          crossFadePoint: 0,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
