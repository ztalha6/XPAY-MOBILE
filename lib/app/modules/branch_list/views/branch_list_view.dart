import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:serveeasy_app/app/data/models/branches/branches_response.dart';
import 'package:serveeasy_app/app/data/widgets/pagination_list_widget.dart';
import 'package:serveeasy_app/app/data/widgets/shimmers.dart';
import 'package:serveeasy_app/core/constants/asset_constants.dart';
import 'package:sizer/sizer.dart';

import '../controllers/branch_list_controller.dart';

class BranchListView extends GetView<BranchListController> {
  const BranchListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(BranchListController());
    return GetX<BranchListController>(
      builder: (model) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.white,
          ),
          body: Column(
            children: [
              Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Select Branch",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontSize: 18),
                      ),
                      if (model.isLoading.isTrue)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: LinearProgressIndicator(
                            color: model.configs.secondaryColor,
                            backgroundColor:
                                model.configs.secondaryColor.withOpacity(0.5),
                          ),
                        )
                      else
                        model.noLocation
                            ? const Center(
                                child: Text(
                                  'It seems that you have disabled you locations services!',
                                ),
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 2.h),
                                  Row(
                                    children: List.generate(
                                      model.orderTypes.length,
                                      (index) {
                                        return Row(
                                          children: [
                                            FilterChip(
                                              label: Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Row(
                                                  children: [
                                                    Image.asset(
                                                      model.orderTypes[index]
                                                          .image,
                                                      scale: 3,
                                                    ),
                                                    // SvgPicture.asset(
                                                    //   model.orderTypes[index].image,
                                                    //   color: model
                                                    //       .configs.secondaryColor,
                                                    // ),
                                                    const SizedBox(width: 10),
                                                    Text(
                                                      model
                                                          .orderTypes[index]
                                                          .name
                                                          .capitalizeFirst!,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headlineMedium!
                                                          .copyWith(
                                                            color: model.selectedOrderTypeIndex
                                                                        .value ==
                                                                    index
                                                                ? Colors.black
                                                                : Colors.grey,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              backgroundColor:
                                                  Colors.transparent,
                                              shape:
                                                  model.selectedOrderTypeIndex
                                                              .value ==
                                                          index
                                                      ? const StadiumBorder(
                                                          side: BorderSide(),
                                                        )
                                                      : null,
                                              onSelected: (bool value) {
                                                model.changeOrderType(index);
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  InkWell(
                                    onTap: () {
                                      model.getLocationFromMap();
                                    },
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          locationImage,
                                          scale: 3,
                                        ),
                                        const SizedBox(width: 20),
                                        SizedBox(
                                          width: Get.width * 0.65,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                model.locationDetails.value!
                                                    .formattedAddress
                                                    .toString(),
                                                maxLines: 2,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displaySmall,
                                              ),
                                              SizedBox(
                                                width: 250,
                                                child: Text(
                                                  "${model.locationDetails.value!.geometry.location.lat}, ${model.locationDetails.value!.geometry.location.lng.toString()}",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headlineMedium,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                ],
                              )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Text(
                        "Select a Nearby Branches",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontSize: 16),
                      ),
                    ),
                    if (model.isNavigating.isTrue)
                      LinearProgressIndicator(
                        color: model.configs.secondaryColor,
                        backgroundColor:
                            model.configs.secondaryColor.withOpacity(0.5),
                      ),
                    SizedBox(
                      height: Get.height * 0.47,
                      child: model.isLoading.isTrue ||
                              model.isLoadingBranches.isTrue
                          ? const ListShimmerwidget()
                          : PaginationListWidget(
                              list: model.branches,
                              controller: model.refreshController,
                              onRefresh: model.onRefresh,
                              onLoading: model.onLoading,
                              listItemWidget: (index) {
                                return BranchItemWidget(
                                  branch: model.branches[index],
                                  onTap: () {
                                    model.onBranchTap(index);
                                  },
                                );
                              },
                            ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class BranchItemWidget extends StatelessWidget {
  const BranchItemWidget({
    Key? key,
    required this.branch,
    required this.onTap,
  }) : super(key: key);
  final Branch branch;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(15.0),
        ),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SizedBox(
            width: double.infinity,
            child: Row(
              children: [
                Image.asset(
                  dummyImage,
                  scale: 3,
                ),
                const SizedBox(
                  width: 20,
                ),
                SizedBox(
                  width: Get.width * 0.55,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        branch.name!,
                        maxLines: 2,
                        style: Theme.of(
                          context,
                        ).textTheme.displaySmall!.copyWith(
                              fontSize: 14,
                            ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        branch.address!,
                        style: Theme.of(
                          context,
                        ).textTheme.headlineMedium!.copyWith(fontSize: 12),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "12:00 - 11:59",
                        style: Theme.of(
                          context,
                        ).textTheme.headlineMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
