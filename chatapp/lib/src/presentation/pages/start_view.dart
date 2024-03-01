import 'package:chatapp/core/constants/auth_value_const.dart';
import 'package:chatapp/core/gen/assets.gen.dart';
import 'package:chatapp/core/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppStartView extends StatefulWidget {
  const AppStartView({Key? key}) : super(key: key);

  @override
  State<AppStartView> createState() => _AppStartViewState();
}

class _AppStartViewState extends State<AppStartView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        final prefs = await SharedPreferences.getInstance();
        bool isLogin = prefs.getBool(AuthValueConst.isLogin) ?? false;
        if (isLogin) {
          print(isLogin);
          Get.offAllNamed(AppRouter.dashboardPage);
          return;
        }
        await Get.offAllNamed(AppRouter.loginPage);
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Image.asset(
            fit: BoxFit.fill,
            Assets.images.chat.path,
            width: 280,
            height: 280,
          ),
        ),
      ),
    );
  }
}
