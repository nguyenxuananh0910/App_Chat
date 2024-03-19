import 'package:chatapp/core/constants/auth_value_const.dart';
import 'package:chatapp/src/domain/models/user_model.dart';
import 'package:chatapp/src/domain/service/user_service.dart';
import 'package:chatapp/src/presentation/controller/checklogin_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ContactController extends GetxController {
  // final RxList<UserModel> users = <UserModel>[].obs;
  // late PagingController<int, UserModel> pagingController;
  // final scrollController = ScrollController();
  // int currentPage = 1;
  // // final int _pageSize = 10;
  // final UserService _userService =
  //     Get.find(tag: AuthValueConst.uerSerServiceTAG);
  final CheckLoginController checkLoginController = Get.find();
  @override
  void onInit() {
    super.onInit();
    // pagingController = PagingController(firstPageKey: 0);
    // pagingController.addPageRequestListener(fetchUsers);
  }

  // Future fetchUsers(int pageKey) async {
  //   try {
  //     final res = await _userService.getUsers(
  //         userId: checkLoginController.userid.value);
  //     users.call(res);
  //     // users.length < _pageSize
  //     pagingController.appendLastPage(users);
  //     // : pagingController.appendPage(
  //     //     users,
  //     //     pageKey + users.length,
  //     //   );
  //   } catch (error) {
  //     pagingController.error = error;
  //     if (Get.isSnackbarOpen) Get.closeAllSnackbars();
  //     Get.snackbar(
  //       'Thông Báo',
  //       'Kết nối internet thất bại',
  //       backgroundColor: Get.theme.colorScheme.error,
  //     );
  //     Get.log(
  //       error.toString(),
  //     );
  //   }
  // }

  // int checkLetter(String letter) {
  //   int number = 0;
  //   for (int i = 0; i < checkLoginController.users.length; i++) {
  //     if (checkLoginController.users[i].fullName![0] == letter) {
  //       number = number + 1;
  //     }
  //   }
  //   return number;
  // }
}
