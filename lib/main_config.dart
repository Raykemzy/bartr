import 'package:bartr/core/services/local_database/hive_keys.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  if (message.notification != null) {
    await Hive.initFlutter();
    await Hive.openBox(HiveKeys.badge);
    FlutterAppBadger.isAppBadgeSupported().then((value) {
      if (value) {
        int badgeCount = Hive.box(HiveKeys.badge).get(HiveKeys.badgeCount) ?? 0;
        int newVal = badgeCount + 1;
        Hive.box(HiveKeys.badge).put(HiveKeys.badgeCount, newVal);
        FlutterAppBadger.updateBadgeCount(newVal);
      }
    });

    return;
  }
}