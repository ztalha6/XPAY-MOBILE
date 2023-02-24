import 'package:flutter/material.dart';

class MenuClass {
  final String title;
  final String assetIcon;
  final Widget linkedPage;
  final int index;

  const MenuClass(this.index, this.title, this.assetIcon, this.linkedPage);
}
