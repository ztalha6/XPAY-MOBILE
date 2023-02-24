import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Utils {
  static final Utils _singleton = Utils._internal();

  factory Utils() {
    return _singleton;
  }

  Utils._internal();

  void clearKeyboardFocus() {
    FocusScope.of(Get.context!).requestFocus(FocusNode());
  }

  String getTimeFromRawString({required String serveDateTime}) {
    return DateFormat.jm().format(DateTime.parse(serveDateTime));
  }

  bool isNotNull(dynamic object) {
    if (object != null) {
      return true;
    } else {
      return false;
    }
  }
}
