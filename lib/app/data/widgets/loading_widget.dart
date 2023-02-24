import 'package:flutter/material.dart';
import 'package:serveeasy_app/core/constants/configuration.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator.adaptive(
      valueColor: AlwaysStoppedAnimation<Color>(
        Configuration().secondaryColor,
      ),
    );
  }
}
