import 'package:chatapp/firebase_options.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseServiceManager {
  static bool get isInitialized => Firebase.apps.isNotEmpty;
  static Future<void> initializeCore() async {
    await Firebase.initializeApp(
      options: _getOptions(),
    );
  }

  static Future<void> initializeServices() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }

    if (!isInitialized) {
      throw Exception(
        'Firebase is not initialized, call [FirebaseServiceManager.initializeCore()] first',
      );
    }

    //Add all services of firebase here
  }

  static FirebaseOptions _getOptions() {
    return DefaultFirebaseOptions.currentPlatform;
  }
}
