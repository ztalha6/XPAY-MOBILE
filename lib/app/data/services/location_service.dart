import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:map_location_picker/map_location_picker.dart';
import 'package:serveeasy_app/app/data/services/snackbar_manager.dart';
import 'package:serveeasy_app/core/constants/configuration.dart';

class LocationException implements Exception {
  final String message;

  LocationException(this.message);
}

class LocationService {
  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw LocationException('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw LocationException('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      throw LocationException(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }
    return Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  Future<Location> determineLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw LocationException('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw LocationException('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      throw LocationException(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }
    final Position pos = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    return Location(lat: pos.latitude, lng: pos.longitude);
  }

  Future<bool> hasLocationPermission() async {
    final LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return false;
    }
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      return true;
    }
    return false;
  }

  Future<bool> hasLocationPermissionDeniedForever() async {
    final LocationPermission permission = await Geolocator.checkPermission();

    return permission == LocationPermission.deniedForever;
  }

  Future<String?> getPlaceNameFromLocation({
    required Location location,
  }) async {
    try {
      final GeocodingResponse place = await GoogleMapsGeocoding(
        apiKey: Configuration().mapKey,
      ).searchByLocation(
        location,
      );
      return place.results.first.formattedAddress;
    } on Exception catch (e) {
      SnackbarManager().showAlertSnackbar(e.toString());
    }
    return null;
  }

  Future<List<String>> getCityStatefromLocation({
    required Location location,
  }) async {
    try {
      final List<geocoding.Placemark> addresses =
          await geocoding.placemarkFromCoordinates(location.lat, location.lng);
      final geocoding.Placemark first = addresses.first;
      return [first.administrativeArea!, first.locality!];
    } on Exception catch (e) {
      SnackbarManager().showAlertSnackbar(e.toString());
    }
    return ["", ""];
  }

  Future<String?> getPlaceNameFromCurrentLocation() async {
    try {
      final Position pos = await determinePosition();
      final GeocodingResponse place = await GoogleMapsGeocoding(
        apiKey: Configuration().mapKey,
      ).searchByLocation(Location(lat: pos.latitude, lng: pos.longitude));
      return place.results.first.formattedAddress;
    } on LocationException catch (e) {
      SnackbarManager().showAlertSnackbar(e.message);
    }
    return null;
  }

  Future<GeocodingResult?> getGeocodingFromCurrentLocation() async {
    try {
      final Position pos = await determinePosition();
      final GeocodingResponse place = await GoogleMapsGeocoding(
        apiKey: Configuration().mapKey,
      ).searchByLocation(Location(lat: pos.latitude, lng: pos.longitude));
      return GeocodingResult(
        geometry: Geometry(
          location: Location(lat: pos.latitude, lng: pos.longitude),
        ),
        placeId: "",
        formattedAddress: place.results.first.formattedAddress,
      );
    } on LocationException catch (e) {
      SnackbarManager().showAlertSnackbar(e.message);
    }
    return null;
  }
}
