import 'package:chatapp/core/constants/auth_value_const.dart';
import 'package:chatapp/core/router/app_router.dart';
import 'package:chatapp/src/domain/requests/bodys/post_login_body.dart';
import 'package:chatapp/src/domain/service/user_service.dart';
import 'package:chatapp/src/presentation/controller/checklogin_controller.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  late TextEditingController userNameEditController;
  late TextEditingController passwordEditController;
  bool isChecked = false;
  final RxBool isLoading = false.obs;
  RxBool showPassword = false.obs;
  final keyForm = GlobalKey<FormState>();
  final UserService _userService =
      Get.find(tag: AuthValueConst.uerSerServiceTAG);
  final CheckLoginController checkLoginController = Get.find();
  @override
  void onInit() {
    userNameEditController = TextEditingController(text: 'XuanAnh');
    passwordEditController = TextEditingController(text: 'Anh123456@');
    super.onInit();
  }

  void togglePasswordVisibility() {
    showPassword.toggle();
  }

  Future<void> onSend() async {
    if (keyForm.currentState!.validate()) {
      login();
    }
  }

  // Future<void> getToForgotPassword() async {
  //   await Get.dialog(const ForgotPassWordPage());
  // }

  Future login() async {
    isLoading.call(true);
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    String? msgToken = await messaging.getToken();
    try {
      final res = await _userService.loginUser(
        body: PostLoginBody(
            username: userNameEditController.text.trim(),
            password: passwordEditController.text.trim(),
            msgToken: msgToken ?? ''),
      );
      await checkLoginController.login(
        userId: res.userId ?? -1,
        token: res.token ?? '',
      );
      _cleanInput();

      Get.offAllNamed(AppRouter.dashboardPage);
    } catch (e) {
      Get.snackbar(
        'Thông Báo',
        'Email hoặc Password không đúng.Vui Lòng thử Lại !',
        backgroundColor: Colors.orangeAccent,
      );
    }
    isLoading.call(false);
  }

  void _cleanInput() {
    userNameEditController.text = '';
    passwordEditController.text = '';
  }
}
