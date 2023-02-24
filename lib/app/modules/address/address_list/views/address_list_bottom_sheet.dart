import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:serveeasy_app/app/data/widgets/loading_widget.dart';
import 'package:serveeasy_app/app/data/widgets/shimmers.dart';
import 'package:serveeasy_app/app/modules/address/address_list/controllers/address_list_controller.dart';
import 'package:serveeasy_app/core/constants/asset_constants.dart';

class AddressBottomSheet extends StatelessWidget {
  const AddressBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(AddressListController());
    return GetX<AddressListController>(
      builder: (model) {
        return Container(
          height: Get.height,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(15.0),
              topLeft: Radius.circular(15.0),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Select Address",
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(fontSize: 16),
                      ),
                      TextButton(
                        onPressed: () {
                          model.gotoCreateAddressView();
                        },
                        child: Text(
                          '+ Add new address',
                          style:
                              Theme.of(context).textTheme.headlineMedium!.copyWith(
                                    color: model.configuration.secondaryColor,
                                  ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 16.0,
                    bottom: 16.0,
                    right: 16.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () => model.setCurrentLocationAsAddress(),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.my_location_outlined,
                              color: model.configuration.secondaryColor,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              "Use my current location",
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall!
                                  .copyWith(
                                    color: model.configuration.secondaryColor,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      if (model.isSettingLocation.isTrue) const LoadingWidget()
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 8,
                child: model.isLoading.isTrue
                    ? const ListShimmerwidget()
                    : ListView.builder(
                        itemCount: model.addresses.length,
                        itemBuilder: (context, index) {
                          return Obx(
                            () => ListTile(
                              onTap: () {
                                model.setAddress(
                                  model.addresses[index].id,
                                  index,
                                );
                              },
                              title: Text(
                                model.addresses[index].address!,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .displayLarge!
                                    .copyWith(
                                      fontSize: 14,
                                    ),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 8,
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 4.0),
                                child: Text(
                                  model.addresses[index].landmark!,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.headlineMedium,
                                ),
                              ),
                              trailing: IconButton(
                                onPressed: () {
                                  model.editAddress(index);
                                },
                                icon: Image.asset(
                                  editIcon,
                                  scale: 3,
                                  color: model.configuration.secondaryColor,
                                ),
                              ),
                              dense: true,
                              leading: Transform.scale(
                                scale: Get.height * 0.0015,
                                child: Radio<int>(
                                  activeColor:
                                      model.configuration.secondaryColor,
                                  value: model.addresses[index].id!,
                                  groupValue: model.selectedAddress.value,
                                  onChanged: (int? value) {
                                    model.setAddress(value, index);
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
