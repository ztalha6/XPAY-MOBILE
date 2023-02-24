import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:get/get.dart';
import 'package:map_location_picker/map_location_picker.dart';
import 'package:serveeasy_app/app/data/widgets/custom_text_form_field.dart';
import 'package:serveeasy_app/app/data/widgets/loading_widget.dart';
import 'package:serveeasy_app/app/data/widgets/primary_button.dart';
import 'package:serveeasy_app/core/constants/asset_constants.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

import '../controllers/address_detail_controller.dart';

class AddressDetailViewParams {
  final bool fromCartView;
  final bool fromCheckoutView;
  final bool isEditMode;
  final int? addressId;

  AddressDetailViewParams({
    this.fromCartView = false,
    this.fromCheckoutView = false,
    this.isEditMode = false,
    this.addressId,
  });
}

class AddressDetailView extends GetView<AddressDetailController> {
  const AddressDetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetX<AddressDetailController>(
      builder: (model) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(
              'Address Details',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            backgroundColor: Colors.white,
          ),
          body: Column(
            children: [
              Expanded(
                child: Stepper(
                  elevation: 0,
                  type: StepperType.horizontal,
                  currentStep: model.currentAddressStep.value,
                  controlsBuilder: (BuildContext ctx, ControlsDetails dtl) {
                    return SizedBox.shrink();
                  },
                  onStepTapped: model.currentAddressStep.value == 0
                      ? null
                      : (index) {
                          model.currentAddressStep(index);
                        },
                  margin: EdgeInsets.zero,
                  steps: [
                    Step(
                      state: model.currentAddressStep.value == 1
                          ? StepState.complete
                          : StepState.indexed,
                      isActive: model.currentAddressStep.value == 0,
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                            child: SizedBox(
                              height: 200,
                              child: model.isLoadingLocation.isTrue
                                  ? Shimmer.fromColors(
                                      key: const ValueKey<int>(0),
                                      baseColor: Colors.white,
                                      highlightColor: Colors.grey.shade200,
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(20),
                                          ),
                                        ),
                                        // height: 15.h,
                                      ),
                                    )
                                  : Stack(
                                      key: const ValueKey<int>(1),
                                      children: [
                                        GoogleMap(
                                          scrollGesturesEnabled: false,
                                          zoomControlsEnabled: false,
                                          zoomGesturesEnabled: false,
                                          onMapCreated: (
                                            GoogleMapController controller,
                                          ) async {
                                            SchedulerBinding.instance
                                                .addPostFrameCallback(
                                                    (timeStamp) {
                                              model.controller
                                                  .complete(controller);
                                            });
                                          },
                                          myLocationButtonEnabled: false,
                                          initialCameraPosition: CameraPosition(
                                            target: LatLng(
                                              model.locationDetails.value!
                                                  .geometry.location.lat,
                                              model.locationDetails.value!
                                                  .geometry.location.lng,
                                            ),
                                            zoom: 13.0,
                                          ),
                                        ),
                                        Center(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Image.asset(
                                                markerIcon,
                                                scale: 2,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 20,
                                          left: Get.width / 2.75,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(15),
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  spreadRadius: 10,
                                                  blurRadius: 20,
                                                  offset: const Offset(
                                                    0,
                                                    3,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            child: InkWell(
                                              onTap: () {
                                                model.getLocationFromMap();
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "Adjust Pin",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headlineMedium!
                                                      .copyWith(
                                                        color: Colors.black,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                            ),
                          ),
                          SizedBox(height: 2.h),
                          if (model.isLoadingLocation.isTrue)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Fetching location",
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayLarge!
                                      .copyWith(color: Colors.grey),
                                ),
                                const LoadingWidget(),
                              ],
                            )
                          else
                            Text(
                              model.locationDetails.value!.formattedAddress!,
                              style: Theme.of(context).textTheme.displayLarge,
                            ),
                          SizedBox(height: 4.h),
                          CustomTextFormField(
                            label: 'Name',
                            errorText: model.nameErrorText.value,
                            controller: model.nameController,
                            hintText: "Your name here",
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                          ),
                          SizedBox(height: 2.h),
                          CustomTextFormField(
                            label: 'Phone Number',
                            errorText: model.phoneErrorText.value,
                            controller: model.phoneController,
                            hintText: "Your phone number here",
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                          ),
                          SizedBox(height: 4.h),
                          Container(
                            height: 60,
                            color: Colors.white,
                            child: PrimaryButton(
                              isLoading: model.isLoading.value,
                              text: 'Next',
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                              onTap: () {
                                model.onNextTap();
                              },
                            ),
                          ),
                        ],
                      ),
                      title: Text(
                        "Personal Details",
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(color: Colors.black),
                      ),
                    ),
                    Step(
                      isActive: model.currentAddressStep.value == 1,
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // SizedBox(height: 4.h),
                          CustomTextFormField(
                            label: 'Address Line',
                            errorText: model.addressErrorText.value,
                            controller: model.addressController,
                            hintText: "Your Address / Unit / Floor here ",
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                          ),
                          SizedBox(height: 2.h),
                          CustomTextFormField(
                            label: 'Street',
                            errorText: model.streetErrorText.value,
                            controller: model.streetController,
                            hintText: "Your street here",
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            "Delivery Instructions",
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                          SizedBox(height: 1.h),
                          CustomTextFormField(
                            label:
                                'Give us more information about your address',
                            // errorText: model.emailErrorText.value,
                            controller: model.instructionsController,
                            hintText: "Your instructions here",
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            "Add a label",
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                          SizedBox(height: 1.h),
                          SizedBox(
                            height: 9.h,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: model.addresses.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Obx(
                                  () => Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          FilterChip(
                                            label: Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: Row(
                                                children: [
                                                  Image.asset(
                                                    model.addresses[index]
                                                        .assetString,
                                                    scale: 3,
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Text(
                                                    model.addresses[index].name
                                                        .capitalizeFirst!,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .displayLarge!
                                                        .copyWith(
                                                          color: model.selectedAddress
                                                                      .value ==
                                                                  index
                                                              ? Colors.black
                                                              : Colors.grey,
                                                          fontSize: 14,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            backgroundColor: Colors.transparent,
                                            shape:
                                                model.selectedAddress.value ==
                                                        index
                                                    ? const StadiumBorder(
                                                        side: BorderSide(),
                                                      )
                                                    : null,
                                            onSelected: (bool value) {
                                              model.changeAddressType(index);
                                            },
                                          ),
                                          const SizedBox(width: 5)
                                        ],
                                      ),
                                      if (index == 2)
                                        Text(
                                          "Most Common",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineMedium!
                                              .copyWith(
                                                color:
                                                    model.config.secondaryColor,
                                                fontSize: 10,
                                              ),
                                        )
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Container(
                            height: 60,
                            color: Colors.white,
                            child: PrimaryButton(
                              isLoading: model.isLoading.value,
                              text: 'Save',
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                              onTap: () {
                                model.saveChanges();
                              },
                            ),
                          ),
                        ],
                      ),
                      title: Text(
                        "Delivery Details",
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Stack(
          //   children: [
          //     Padding(
          //       padding: const EdgeInsets.all(16.0),
          //       child: ListView(
          //         children: [
          //           Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          // ClipRRect(
          //   borderRadius:
          //       const BorderRadius.all(Radius.circular(15)),
          //   child: SizedBox(
          //     height: 200,
          //     child: model.isLoadingLocation.isTrue
          //         ? Shimmer.fromColors(
          //             key: const ValueKey<int>(0),
          //             baseColor: Colors.white,
          //             highlightColor: Colors.grey.shade200,
          //             child: Container(
          //               decoration: const BoxDecoration(
          //                 color: Colors.white,
          //                 borderRadius: BorderRadius.all(
          //                   Radius.circular(20),
          //                 ),
          //               ),
          //               // height: 15.h,
          //             ),
          //           )
          //         : Stack(
          //             key: const ValueKey<int>(1),
          //             children: [
          //               GoogleMap(
          //                 scrollGesturesEnabled: false,
          //                 zoomControlsEnabled: false,
          //                 zoomGesturesEnabled: false,
          //                 onMapCreated: (
          //                   GoogleMapController controller,
          //                 ) async {
          //                   SchedulerBinding.instance
          //                       .addPostFrameCallback(
          //                           (timeStamp) {
          //                     model.controller
          //                         .complete(controller);
          //                   });
          //                 },
          //                 myLocationButtonEnabled: false,
          //                 initialCameraPosition: CameraPosition(
          //                   target: LatLng(
          //                     model.locationDetails.value!
          //                         .geometry.location.lat,
          //                     model.locationDetails.value!
          //                         .geometry.location.lng,
          //                   ),
          //                   zoom: 13.0,
          //                 ),
          //               ),
          //               Center(
          //                 child: Column(
          //                   mainAxisSize: MainAxisSize.min,
          //                   children: [
          //                     Image.asset(
          //                       markerIcon,
          //                       scale: 2,
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //               Positioned(
          //                 bottom: 20,
          //                 left: Get.width / 2.75,
          //                 child: Container(
          //                   decoration: BoxDecoration(
          //                     color: Colors.white,
          //                     borderRadius:
          //                         const BorderRadius.all(
          //                       Radius.circular(15),
          //                     ),
          //                     boxShadow: [
          //                       BoxShadow(
          //                         color: Colors.grey
          //                             .withOpacity(0.5),
          //                         spreadRadius: 10,
          //                         blurRadius: 20,
          //                         offset: const Offset(
          //                           0,
          //                           3,
          //                         ),
          //                       ),
          //                     ],
          //                   ),
          //                   child: InkWell(
          //                     onTap: () {
          //                       model.getLocationFromMap();
          //                     },
          //                     child: Padding(
          //                       padding:
          //                           const EdgeInsets.all(8.0),
          //                       child: Text(
          //                         "Adjust Pin",
          //                         style: Theme.of(context)
          //                             .textTheme
          //                             .headlineMedium!
          //                             .copyWith(
          //                               color: Colors.black,
          //                             ),
          //                       ),
          //                     ),
          //                   ),
          //                 ),
          //               )
          //             ],
          //           ),
          //   ),
          // ),
          // SizedBox(height: 2.h),
          // if (model.isLoadingLocation.isTrue)
          //   Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Text(
          //         "Fetching location",
          //         style: Theme.of(context)
          //             .textTheme
          //             .displayLarge!
          //             .copyWith(color: Colors.grey),
          //       ),
          //       const LoadingWidget(),
          //     ],
          //   )
          // else
          //   Text(
          //                   model.locationDetails.value!.formattedAddress!,
          //                   style: Theme.of(context).textTheme.displayLarge,
          //                 ),
          //               Stepper(
          //                 type: StepperType.horizontal,
          //                 currentStep: model.currentAddressStep.value,
          //                 controlsBuilder:
          //                     (BuildContext ctx, ControlsDetails dtl) {
          //                   return Row(
          //                     children: <Widget>[
          //                       TextButton(
          //                         onPressed: dtl.onStepContinue,
          //                         child: Text(
          //                           model.currentAddressStep.value != 0
          //                               ? ''
          //                               : 'NEXT',
          //                         ),
          //                       ),
          //                       TextButton(
          //                         onPressed: dtl.onStepCancel,
          //                         child: Text(
          //                           model.currentAddressStep.value != 0
          //                               ? ''
          //                               : 'CANCEL',
          //                         ),
          //                       ),
          //                     ],
          //                   );
          //                 },
          //                 onStepContinue: () {
          //                   model.currentAddressStep(1);
          //                 },
          //                 onStepTapped: (index) {
          //                   model.currentAddressStep(index);
          //                 },
          //                 margin: EdgeInsets.zero,
          //                 physics: NeverScrollableScrollPhysics(),
          //                 steps: [
          //                   Step(
          //                     content: Column(
          //                       children: [
          //                         CustomTextFormField(
          //                           label: 'Address Line',
          //                           errorText: model.addressErrorText.value,
          //                           controller: model.addressController,
          //                           hintText:
          //                               "Your Address / Unit / Floor here ",
          //                           keyboardType: TextInputType.emailAddress,
          //                           textInputAction: TextInputAction.next,
          //                         ),
          //                       ],
          //                     ),
          //                     title: Text(
          //                       "Personal Details",
          //                       style: Theme.of(context)
          //                           .textTheme
          //                           .displayLarge!
          //                           .copyWith(color: Colors.black),
          //                     ),
          //                   ),
          //                   Step(
          //                     content: Column(
          //                       crossAxisAlignment: CrossAxisAlignment.start,
          //                       children: [
          //                         // SizedBox(height: 4.h),
          //                         CustomTextFormField(
          //                           label: 'Address Line',
          //                           errorText: model.addressErrorText.value,
          //                           controller: model.addressController,
          //                           hintText:
          //                               "Your Address / Unit / Floor here ",
          //                           keyboardType: TextInputType.emailAddress,
          //                           textInputAction: TextInputAction.next,
          //                         ),
          //                         SizedBox(height: 2.h),
          //                         CustomTextFormField(
          //                           label: 'Street',
          //                           errorText: model.streetErrorText.value,
          //                           controller: model.streetController,
          //                           hintText: "Your street here",
          //                           keyboardType: TextInputType.emailAddress,
          //                           textInputAction: TextInputAction.next,
          //                         ),
          //                         SizedBox(height: 2.h),
          //                         Text(
          //                           "Delivery Instructions",
          //                           style: Theme.of(context)
          //                               .textTheme
          //                               .displayLarge,
          //                         ),
          //                         SizedBox(height: 1.h),
          //                         CustomTextFormField(
          //                           label:
          //                               'Give us more information about your address',
          //                           // errorText: model.emailErrorText.value,
          //                           controller: model.instructionsController,
          //                           hintText: "Your instructions here",
          //                           keyboardType: TextInputType.emailAddress,
          //                           textInputAction: TextInputAction.next,
          //                         ),
          //                         SizedBox(height: 2.h),
          //                         Text(
          //                           "Add a label",
          //                           style: Theme.of(context)
          //                               .textTheme
          //                               .displayLarge,
          //                         ),
          //                         SizedBox(height: 1.h),
          //                         SizedBox(
          //                           height: 9.h,
          //                           child: ListView.builder(
          //                             scrollDirection: Axis.horizontal,
          //                             itemCount: model.addresses.length,
          //                             itemBuilder:
          //                                 (BuildContext context, int index) {
          //                               return Obx(
          //                                 () => Column(
          //                                   mainAxisSize: MainAxisSize.min,
          //                                   children: [
          //                                     Row(
          //                                       mainAxisSize: MainAxisSize.min,
          //                                       children: [
          //                                         FilterChip(
          //                                           label: Padding(
          //                                             padding:
          //                                                 const EdgeInsets.all(
          //                                                     2.0),
          //                                             child: Row(
          //                                               children: [
          //                                                 Image.asset(
          //                                                   model
          //                                                       .addresses[
          //                                                           index]
          //                                                       .assetString,
          //                                                   scale: 3,
          //                                                 ),
          //                                                 const SizedBox(
          //                                                     width: 10),
          //                                                 Text(
          //                                                   model
          //                                                       .addresses[
          //                                                           index]
          //                                                       .name
          //                                                       .capitalizeFirst!,
          //                                                   style: Theme.of(
          //                                                           context)
          //                                                       .textTheme
          //                                                       .displayLarge!
          //                                                       .copyWith(
          //                                                         color: model.selectedAddress
          //                                                                     .value ==
          //                                                                 index
          //                                                             ? Colors
          //                                                                 .black
          //                                                             : Colors
          //                                                                 .grey,
          //                                                         fontSize: 14,
          //                                                       ),
          //                                                 ),
          //                                               ],
          //                                             ),
          //                                           ),
          //                                           backgroundColor:
          //                                               Colors.transparent,
          //                                           shape: model.selectedAddress
          //                                                       .value ==
          //                                                   index
          //                                               ? const StadiumBorder(
          //                                                   side: BorderSide(),
          //                                                 )
          //                                               : null,
          //                                           onSelected: (bool value) {
          //                                             model.changeAddressType(
          //                                                 index);
          //                                           },
          //                                         ),
          //                                         const SizedBox(width: 5)
          //                                       ],
          //                                     ),
          //                                     if (index == 2)
          //                                       Text(
          //                                         "Most Common",
          //                                         style: Theme.of(context)
          //                                             .textTheme
          //                                             .headlineMedium!
          //                                             .copyWith(
          //                                               color: model.config
          //                                                   .secondaryColor,
          //                                               fontSize: 10,
          //                                             ),
          //                                       )
          //                                   ],
          //                                 ),
          //                               );
          //                             },
          //                           ),
          //                         ),
          //                         SizedBox(height: 2.h),
          //                         Container(
          //                           height: 60,
          //                           color: Colors.white,
          //                           child: PrimaryButton(
          //                             isLoading: model.isLoading.value,
          //                             text: 'Save',
          //                             textStyle: Theme.of(context)
          //                                 .textTheme
          //                                 .headlineMedium!
          //                                 .copyWith(
          //                                   fontSize: 16,
          //                                   color: Colors.white,
          //                                 ),
          //                             onTap: () {
          //                               model.saveChanges();
          //                             },
          //                           ),
          //                         ),
          //                       ],
          //                     ),
          //                     title: Text(
          //                       "Delivery Details",
          //                       style: Theme.of(context)
          //                           .textTheme
          //                           .displayLarge!
          //                           .copyWith(color: Colors.black),
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //             ],
          //           ),
          //         ],
          //       ),
          //     ),
          //     // Positioned(
          //     //   bottom: 0.h,
          //     //   child: Container(
          //     //     height: 60,
          //     //     color: Colors.white,
          //     //     child: PrimaryButton(
          //     //       isLoading: model.isLoading.value,
          //     //       text: 'Save',
          //     //       textStyle:
          //     //           Theme.of(context).textTheme.headlineMedium!.copyWith(
          //     //                 fontSize: 16,
          //     //                 color: Colors.white,
          //     //               ),
          //     //       onTap: () {
          //     //         model.saveChanges();
          //     //       },
          //     //     ),
          //     //   ),
          //     // ),
          //   ],
          // ),
        );
      },
    );
  }
}
