import 'package:flutter/material.dart';
import 'package:map_location_picker/map_location_picker.dart';

class Configuration {
  static final Configuration _singleton = Configuration._internal();

  factory Configuration() {
    return _singleton;
  }

  Configuration._internal();

  /*
  Key is defined in following files
  1. Mainfiest file
  2. AppDelegate.swift file
  */
  String mapKey = "AIzaSyCNw8p8lAjSGYr2GzQnkqwcBlEJs2tQ4cc";
  /* The given logo with image by any brand  */
  String logoWithName = 'assets/images/logo_with_name.png';
  Color primaryColor = const Color(0xFF1E2329);
  Color secondaryColor = const Color(0xFFF5A302);
  LatLng dummyLocation = const LatLng(34.999741019328795, -101.91910596179325);
}
