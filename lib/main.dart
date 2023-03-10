import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:serveeasy_app/app/data/services/notification_service.dart';
import 'package:serveeasy_app/app/data/widgets/base_widget.dart';
import 'package:serveeasy_app/app/routes/app_pages.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:serveeasy_app/core/env/env.dart';
import 'package:serveeasy_app/core/env/envs.dart';
import 'package:serveeasy_app/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await setupFirebase();
  await setupLocalDatabase();
  Env.currentEnv = Envs.LocalEnv;
  runApp(const BaseWidget(Routes.SPLASH));
}

Future<void> setupFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final FCMNotificationService notificationService = FCMNotificationService();
  final AuthorizationStatus authorizationStatus =
      await notificationService.requestNotificationPermission();
  await notificationService.initialize(authorizationStatus);
  FCMNotificationService.registerBackgroundCallback(authorizationStatus);
  await FirebaseAnalytics.instance.logBeginCheckout(
    value: 10.0,
    currency: 'USD',
    items: [
      AnalyticsEventItem(itemName: 'Socks', itemId: 'xjw73ndnw', price: 10.0),
    ],
    coupon: '10PERCENTOFF',
  );
}

Future<void> setupLocalDatabase() async {
  await Hive.initFlutter();
  await Hive.deleteFromDisk();
  // Hive.deleteBoxFromDisk('menuBox');
  // Hive.deleteBoxFromDisk('menuTabBox');
}
