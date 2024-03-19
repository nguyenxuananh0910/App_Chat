import 'package:chatapp/core/constants/auth_value_const.dart';
import 'package:chatapp/src/domain/requests/bodys/post_sign_body.dart';
import 'package:chatapp/src/domain/service/user_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignController extends GetxController {
  late TextEditingController nameEditController;
  late TextEditingController usernameEditController;
  late TextEditingController emailEditController;
  late TextEditingController passwordEditController;
  late TextEditingController confirmPasswordEditController;
  final RegExp phoneRegex = RegExp(r'^([1-9])?\d{10}$');
  final RegExp specialCharsRegex =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
  bool isChecked = false;
  final RxBool isLoading = false.obs;
  RxBool showPassword = false.obs;
  RxBool showConfirmPassword = false.obs;
  final keyForm = GlobalKey<FormState>();
  final UserService _userService =
      Get.find(tag: AuthValueConst.uerSerServiceTAG);
  @override
  void onInit() {
    emailEditController = TextEditingController(text: 'anh@gmail.com');
    usernameEditController = TextEditingController(text: 'AnhTuan');
    passwordEditController = TextEditingController(text: 'Tuan123456@');
    nameEditController = TextEditingController(text: 'Nguyen Anh Tuan');
    confirmPasswordEditController = TextEditingController();
    super.onInit();
  }

  void togglePasswordVisibility(int id) {
    if (id == 1) {
      showPassword.toggle();
    } else {
      showConfirmPassword.toggle();
    }
  }

  Future<void> onSend() async {
    isLoading.call(true);
    if (keyForm.currentState!.validate()) {
      try {
        await _userService.signUser(
          body: PostSignBody(
            email: emailEditController.text.trim(),
            password: passwordEditController.text.trim(),
            username: usernameEditController.text.trim(),
            fullName: nameEditController.text.trim(),
          ),
        );
        _cleanInput();
        Get.snackbar(
          'Thông Báo',
          'Đăng ký thành công, vui lòng đăng nhập!',
          backgroundColor: Colors.orangeAccent,
        );
        Get.back();
      } catch (error) {
        String errorMessage = "Có lỗi xảy ra, thử lại nhé!";
        if (error is DioException) {
          if (error.response?.statusCode == 409 &&
              error.response?.data['message'] != null) {
            errorMessage = error.response?.data['message'] ??
                "Có lỗi xảy ra, thử lại nhé!";
          }
        }
        Get.snackbar(
          'Thông báo',
          errorMessage,
          backgroundColor: Colors.red,
        );
        Get.log(
          error.toString(),
        );
      }
    }
    isLoading.call(false);
  }

  void _cleanInput() {
    nameEditController.clear();
    usernameEditController.text = '';
    confirmPasswordEditController.text = '';
    emailEditController.text = '';
    passwordEditController.text = '';
  }
}
