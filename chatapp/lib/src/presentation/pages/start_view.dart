import 'package:chatapp/core/constants/auth_value_const.dart';
import 'package:chatapp/core/gen/assets.gen.dart';
import 'package:chatapp/core/router/app_router.dart';
import 'package:chatapp/src/presentation/controller/checklogin_controller.dart';
import 'package:chatapp/src/presentation/controller/signalr_conect.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppStartView extends StatefulWidget {
  const AppStartView({Key? key}) : super(key: key);

  @override
  State<AppStartView> createState() => _AppStartViewState();
}

class _AppStartViewState extends State<AppStartView>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final prefs = await SharedPreferences.getInstance();
      bool isLogin = prefs.getBool(AuthValueConst.isLogin) ?? false;
      if (isLogin) {
        Get.offAllNamed(AppRouter.dashboardPage);
        return;
      }
      await Get.offAllNamed(AppRouter.loginPage);
    });
  }
  //
  // void setStatus() async {
  //   await signalRService.setUserOffline(1);
  //   print(123);
  // }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.inactive:
        // TODO: Handle this case.
        // setStatus();
        break;
      case AppLifecycleState.paused:
        // TODO: Handle this case.
        // setStatus();
        break;
      default:
        break;
    }
  }

  // @override
  // void dispose() {
  //   Get.find<SignalRService>().disconnect();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Image.asset(
            Assets.images.chat.path,
            fit: BoxFit.fill,
            width: 280,
            height: 280,
          ),
        ),
      ),
    );
  }
}
