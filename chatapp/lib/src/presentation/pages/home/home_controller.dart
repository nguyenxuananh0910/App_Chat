import 'package:chatapp/core/constants/auth_value_const.dart';
import 'package:chatapp/src/domain/models/group_model.dart';
import 'package:chatapp/src/domain/models/user_model.dart';
import 'package:chatapp/src/domain/service/message_service.dart';
import 'package:chatapp/src/domain/service/user_service.dart';
import 'package:chatapp/src/presentation/controller/checklogin_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class HomeController extends GetxController {
  final RxList<UserModel> users = <UserModel>[].obs;
  final Rxn<UserModel> user = Rxn<UserModel>();
  final RxList<GroupModel> groups = <GroupModel>[].obs;
  late PagingController<int, GroupModel> pagingGroupController;
  late PagingController<int, UserModel> pagingUserController;
  final scrollController = ScrollController();
  final int _pageSize = 10;
  int currentPage = 1;
  final UserService _userService =
      Get.find(tag: AuthValueConst.uerSerServiceTAG);
  final MessageService _messageService =
      Get.find(tag: AuthValueConst.messageServiceTAG);
  final CheckLoginController checkLoginController = Get.find();
  final RxBool isLoading = true.obs;
  @override
  void onInit() {
    super.onInit();
    pagingUserController = PagingController(firstPageKey: 0);
    pagingUserController.addPageRequestListener(fetchUsers);
    pagingGroupController = PagingController(firstPageKey: 0);
    pagingGroupController.addPageRequestListener(fetchGroup);
  }

  Future fetchUsers(int pageKey) async {
    try {
      final res = await _userService.getUsers();
      users.call(res);
      users.length < _pageSize
          ? pagingUserController.appendLastPage(users)
          : pagingUserController.appendPage(
              users,
              pageKey + users.length,
            );
    } catch (error) {
      pagingUserController.error = error;
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

  Future fetchGroup(int pageKey) async {
    try {
      final res = await _messageService.getGroups(
          userId: checkLoginController.userid.value);
      groups.call(res);
      groups.length < _pageSize
          ? pagingGroupController.appendLastPage(groups)
          : pagingGroupController.appendPage(
              groups,
              pageKey + groups.length,
            );
    } catch (error) {
      pagingGroupController.error = error;
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

  Future getUser({required int receiverId}) async {
    try {
      final res = await _userService.getUser(userId: receiverId);
      user.call(res);
    } catch (error) {
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
