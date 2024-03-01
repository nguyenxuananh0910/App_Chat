import 'package:chatapp/core/constants/auth_value_const.dart';
import 'package:chatapp/core/router/app_router.dart';
import 'package:chatapp/src/domain/service/user_service.dart';
import 'package:chatapp/src/presentation/controller/checklogin_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  late TextEditingController emailEditController;
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
    emailEditController = TextEditingController(text: 'XuanAnh');
    passwordEditController = TextEditingController(text: 'Anh12345@');
    super.onInit();
  }

  void togglePasswordVisibility() {
    showPassword.toggle();
  }

  Future<void> onSend() async {
    if (keyForm.currentState!.validate()) {
      login();
      _cleanInput();
    }
  }

  // Future<void> getToForgotPassword() async {
  //   await Get.dialog(const ForgotPassWordPage());
  // }

  Future login() async {
    isLoading.call(true);
    try {
      final res = await _userService.loginUser(
          username: emailEditController.text.trim(),
          password: passwordEditController.text.trim());
      await checkLoginController.login(
        userId: res.userId ?? -1,
        token: res.token ?? '',
      );
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
    emailEditController.text = '';
    passwordEditController.text = '';
  }
}
