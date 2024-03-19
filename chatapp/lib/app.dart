import 'package:chatapp/core/config/theme/theme_data.dart';
import 'package:chatapp/core/global_binding.dart';
import 'package:chatapp/core/router/app_router.dart';
import 'package:chatapp/src/presentation/controller/checklogin_controller.dart';
import 'package:chatapp/src/presentation/controller/signalr_conect.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

import 'core/constants/auth_value_const.dart';

class AppRoot extends StatefulWidget {
  const AppRoot({super.key});
  static const String routeName = '/';

  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'TravelEase',
      locale: const Locale("vi", "VI"),
      builder: DevicePreview.appBuilder,
      scrollBehavior: const CupertinoScrollBehavior(),
      getPages: AppRouter.getPages,
      initialRoute: AppRouter.startRoute,
      debugShowCheckedModeBanner: false,
      initialBinding: GlobalBinding(),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', 'US'), // Support English as well, if needed
        Locale('vi', 'VN'),
      ],
      themeMode: ThemeMode.light,
      theme: AppThemeData.lightTheme,
    );
  }
}
