import 'dart:async';

import 'package:chatapp/core/constants/auth_value_const.dart';
import 'package:chatapp/core/router/app_router.dart';
import 'package:chatapp/core/utils/helpers/even_bus.dart';
import 'package:chatapp/src/domain/models/group_model.dart';
import 'package:chatapp/src/domain/models/user_model.dart';
import 'package:chatapp/src/domain/requests/bodys/post_create_group_body.dart';
import 'package:chatapp/src/domain/service/message_service.dart';
import 'package:chatapp/src/domain/service/user_service.dart';
import 'package:chatapp/src/presentation/controller/checklogin_controller.dart';
import 'package:chatapp/src/presentation/pages/chat/room_chat/room_chat_controller.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class HomeController extends GetxController {
  final RxList<UserModel> users = <UserModel>[].obs;
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
  late TextEditingController nameGroupEditController;
  final RxList<UserModel> selectedUsers = <UserModel>[].obs;
  EventBus eventBus = Get.find();
  StreamSubscription? streamSubscription;
  @override
  void onInit() {
    super.onInit();
    pagingUserController = PagingController(firstPageKey: 0);
    pagingUserController.addPageRequestListener(fetchUsers);
    pagingGroupController = PagingController(firstPageKey: 0);
    pagingGroupController.addPageRequestListener(fetchGroup);
    nameGroupEditController = TextEditingController();
    listenEventClear();
  }

  void listenEventClear() {
    streamSubscription = eventBus.on<ReloadGroup>().listen((event) {
      pagingGroupController.refresh();
    });
  }

  Future fetchUsers(int pageKey) async {
    try {
      final res = await _userService.getUsers(
          userId: checkLoginController.userid.value);
      users.call(res);

      // users.length < _pageSize
      //     ?
      pagingUserController.appendLastPage(users);
      // : pagingUserController.appendPage(
      //     users,
      //     pageKey + users.length,
      //   );
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
      // groups.length < _pageSize
      pagingGroupController.appendLastPage(groups);
      // : pagingGroupController.appendPage(
      //     groups,
      //     pageKey + groups.length,
      //   );
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

  void selectListUsers(UserModel value) {
    if (!selectedUsers.contains(value)) {
      selectedUsers.add(value);
      // users.remove(value);
    }
  }

  void deleteMember(UserModel value) {
    selectedUsers.remove(value);
  }

  Future createGroup() async {
    if (selectedUsers.length == 1) {
      try {
        final res = await _messageService.checkIfUserMessaged(
            userAId: selectedUsers.first.userId!,
            userBId: checkLoginController.userid.value);

        if (res.isEmpty && res == null) {
          try {
            final res = await _messageService.createGroup(
              body: PostCreateGroupBody(
                groupName: nameGroupEditController.text.isEmpty
                    ? [
                        ...List.generate(selectedUsers.length,
                            (int index) => selectedUsers[index].fullName),
                      ].join(',')
                    : nameGroupEditController.text.trim(),
                createdBy: checkLoginController.userid.value,
                members: [
                  MemberList(
                      userId: checkLoginController
                          .userid.value), // Adding the logged-in user's ID
                  ...selectedUsers
                      .map((user) => MemberList(userId: user.userId!))
                      .toList(),
                ],
              ),
            );
            pagingGroupController.refresh();
            Get.toNamed(
              AppRouter.roomChatPage,
              arguments: ArgRoomChat(group: res),
            );
          } catch (error) {
            Get.log(
              error.toString(),
            );
          }
        }
        Get.toNamed(
          AppRouter.roomChatPage,
          arguments: ArgRoomChat(receiver: selectedUsers.first),
        );
      } catch (error) {
        // pagingController.error = error;
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
    } else {
      try {
        final res = await _messageService.createGroup(
          body: PostCreateGroupBody(
            groupName: nameGroupEditController.text.isEmpty
                ? [
                    ...List.generate(selectedUsers.length,
                        (int index) => selectedUsers[index].fullName),
                  ].join(',')
                : nameGroupEditController.text.trim(),
            createdBy: checkLoginController.userid.value,
            members: [
              MemberList(
                  userId: checkLoginController
                      .userid.value), // Adding the logged-in user's ID
              ...selectedUsers
                  .map((user) => MemberList(userId: user.userId!))
                  .toList(),
            ],
          ),
        );
        pagingGroupController.refresh();
        Get.toNamed(
          AppRouter.roomChatPage,
          arguments: ArgRoomChat(group: res),
        );
      } catch (error) {
        Get.log(
          error.toString(),
        );
      }
    }
  }

  Future<void> onRefresh() async {
    pagingUserController.refresh();
    pagingGroupController.refresh();
  }
}
