import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:serveeasy_app/app/routes/app_pages.dart';
import 'package:serveeasy_app/core/theme/app_theme.dart';
import 'package:sizer/sizer.dart';

final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

class BaseWidget extends StatelessWidget {
  final String initalRoute;
  const BaseWidget(this.initalRoute, {super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: GetMaterialApp(
            // translations: LocalizationService(),
            locale: Get.deviceLocale,
            fallbackLocale: const Locale('en', 'US'),
            scaffoldMessengerKey: rootScaffoldMessengerKey,
            debugShowCheckedModeBanner: false,
            initialRoute: initalRoute,
            getPages: AppPages.routes,
            theme: AppTheme().getAppTheme(context),
          ),
        );
      },
    );
  }
}
