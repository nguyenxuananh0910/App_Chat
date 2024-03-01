import 'package:chatapp/core/constants/auth_value_const.dart';
import 'package:chatapp/src/domain/models/user_model.dart';
import 'package:chatapp/src/domain/service/user_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ContactController extends GetxController {
  final RxList<UserModel> users = <UserModel>[].obs;
  late PagingController<int, UserModel> pagingController;
  final scrollController = ScrollController();
  int currentPage = 1;
  final int _pageSize = 10;
  final UserService _userService =
      Get.find(tag: AuthValueConst.uerSerServiceTAG);

  @override
  void onInit() {
    super.onInit();
    pagingController = PagingController(firstPageKey: 0);
    pagingController.addPageRequestListener(fetchUsers);
  }

  Future fetchUsers(int pageKey) async {
    try {
      final res = await _userService.getUsers();
      users.call(res);
      users.length < _pageSize
          ? pagingController.appendLastPage(users)
          : pagingController.appendPage(
              users,
              pageKey + users.length,
            );
    } catch (error) {
      pagingController.error = error;
      if (Get.isSnackbarOpen) Get.closeAllSnackbars();
      Get.snackbar(
        'Thông Báo',
        'Kết nối internet thất bại',
        backgroundColor: Get.theme.colorScheme.error,
      );
      Get.log(
        error.toString(),
      );
    }
  }
}
