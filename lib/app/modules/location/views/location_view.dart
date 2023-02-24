import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:map_location_picker/map_location_picker.dart';

import '../controllers/location_controller.dart';

class LocationViewParams {
  final LatLng initialPosition;

  LocationViewParams({required this.initialPosition});
}

class LocationView extends GetWidget {
  const LocationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GeocodingResult finalResult;
    Get.put(LocationController());
    return GetX<LocationController>(
      builder: (model) {
        return model.isLoading.isTrue
            ? Container(
                color: Colors.white,
                child: const Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
              )
            : MapLocationPicker(
                showMoreOptions: false,
                showMapSwitcher: false,
                apiKey: model.mapKey.value,
                currentLatLng:
                    LatLng(model.location.value.lat, model.location.value.lng),
                bottomCardMargin: EdgeInsets.zero,
                onNext: (GeocodingResult? result) {
                  if (result != null) {
                    finalResult = result;
                    Get.back(result: finalResult);
                  }
                },
                onSuggestionSelected: (PlacesDetailsResponse? result) {
                  if (result != null) {
                    finalResult = GeocodingResult(
                      geometry: result.result.geometry!,
                      placeId: result.result.placeId,
                      formattedAddress: result.result.formattedAddress ?? "",
                    );
                  }
                },
              );
      },
    );
  }
}
