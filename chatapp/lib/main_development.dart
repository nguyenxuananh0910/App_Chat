import 'dart:async';

import 'package:chatapp/app.dart';
import 'package:chatapp/src/domain/service/firebase/firebase.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

RemoteMessage? initMsg;
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print(message.notification?.title);
  print(message.notification?.body);
  await FirebaseServiceManager.initializeCore();
}

void main() async {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await FirebaseServiceManager.initializeCore();
    await FirebaseServiceManager.initializeServices();
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    initMsg = await FirebaseMessaging.instance.getInitialMessage();
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
    FirebaseMessaging.instance.setAutoInitEnabled(true);
    runApp(
      const AppRoot(),
    );
  },
      (error, stack) =>
          FirebaseCrashlytics.instance.recordError(error, stack, fatal: true));
}
