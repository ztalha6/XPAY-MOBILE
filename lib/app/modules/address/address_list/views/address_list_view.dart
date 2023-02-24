import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:serveeasy_app/app/data/widgets/shimmers.dart';
import 'package:serveeasy_app/core/constants/asset_constants.dart';

import '../controllers/address_list_controller.dart';

class AddressListViewParams {
  final bool fromCheckoutView;
  final bool fromHomeView;

  AddressListViewParams({
    required this.fromCheckoutView,
    this.fromHomeView = true,
  });
}

class AddressListView extends GetView<AddressListController> {
  const AddressListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(AddressListController());
    return GetX<AddressListController>(
      builder: (model) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Addresses',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  model.gotoCreateAddressView();
                },
                child: Text(
                  '+ Add new',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .copyWith(color: model.configuration.secondaryColor),
                ),
              )
            ],
          ),
          body: model.isLoading.isTrue
              ? const ListShimmerwidget()
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: model.addresses.length,
                  itemBuilder: (context, index) {
                    return Obx(
                      () => Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: ListTile(
                          onTap: () {
                            model.setAddress(model.addresses[index].id, index);
                          },
                          title: Text(
                            model.addresses[index].address!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style:
                                Theme.of(context).textTheme.displayLarge!.copyWith(
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
                              activeColor: model.configuration.secondaryColor,
                              value: model.addresses[index].id!,
                              groupValue: model.selectedAddress.value,
                              onChanged: (int? value) {
                                model.setAddress(value, index);
                              },
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}
