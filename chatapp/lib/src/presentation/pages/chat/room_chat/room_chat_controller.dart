import 'package:chatapp/core/constants/auth_value_const.dart';
import 'package:chatapp/core/utils/helpers/even_bus.dart';
import 'package:chatapp/src/domain/models/group_model.dart';
import 'package:chatapp/src/domain/models/messages_model.dart';
import 'package:chatapp/src/domain/models/user_model.dart';
import 'package:chatapp/src/domain/requests/bodys/post_create_group_body.dart';
import 'package:chatapp/src/domain/requests/bodys/post_send_message_body.dart';
import 'package:chatapp/src/domain/service/message_service.dart';
import 'package:chatapp/src/presentation/controller/checklogin_controller.dart';
import 'package:chatapp/src/presentation/pages/chat/home_controller.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:signalr_netcore/signalr_client.dart';

class RoomChatController extends GetxController {
  final RxList<MessagesModel> messages = <MessagesModel>[].obs;
  final RxList<GroupModel> groups = <GroupModel>[].obs;
  late PagingController<int, MessagesModel> pagingController;
  final scrollController = ScrollController();
  final int _pageSize = 10;
  int currentPage = 1;
  final CheckLoginController checkLoginController = Get.find();
  final MessageService _messageService =
      Get.find(tag: AuthValueConst.messageServiceTAG);
  late TextEditingController messageEditController;
  late ArgRoomChat argRoomChat;
  final hubConnection = HubConnectionBuilder()
      .withUrl('${AuthValueConst.baseApiUrl}/message-hub')
      .build();
  final Rxn<GroupModel> newGroup = Rxn<GroupModel>();
  final EventBus eventBus = Get.find();
  @override
  void onInit() {
    super.onInit();
    argRoomChat = Get.arguments as ArgRoomChat;
    _connectToSignalR();
    // pagingController = PagingController(firstPageKey: 0);
    fetchMessages();
    // pagingController.addPageRequestListener(fetchMessages);
    messageEditController = TextEditingController();
  }

  void _connectToSignalR() async {
    try {
      hubConnection.on('ReceiveMessage', (data) {
        Get.log('connection success');
        // Assuming data is a List and you want to access the first map in the list
        if (data is List) {
          final message =
              MessagesModel.fromJson(data[0] as Map<String, dynamic>);
          if (message.groupId == argRoomChat.group?.groupId ||
              message.groupId == newGroup.value?.groupId ||
              message.groupId == messages[0].groupId) {
            eventBus.fire(ReloadGroup());
            messages.add(message);
            // pagingController.refresh();
          }
        } else {
          // Handle the case where data is not a List
          Get.log('Data is not a list');
        }
      });

      await hubConnection.start();
    } catch (e) {
      Get.log('error');
      Get.log(e.toString());
    }
  }

  Future fetchMessages() async {
    if (argRoomChat.group?.groupId != null) {
      try {
        final res = await _messageService.messages(
            groupId: argRoomChat.group!.groupId!);
        if (res.isEmpty) {
          messages.call(null);
        }
        messages.call(res);
        // pagingController.appendLastPage(messages);
        // messages.length < _pageSize
        //     ? pagingController.appendLastPage(messages)
        //     : pagingController.appendPage(
        //         messages,
        //         pageKey + messages.length,
        //       );
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
    } else if (argRoomChat.receiver?.userId != null) {
      try {
        final res = await _messageService.checkIfUserMessaged(
            userAId: argRoomChat.receiver!.userId!,
            userBId: checkLoginController.userid.value);

        if (res.isEmpty) {
          messages.call(null);
        }
        messages.call(res);
        // pagingController.appendLastPage(messages);
        // messages.length < _pageSize
        //     ? pagingController.appendLastPage(messages)
        //     : pagingController.appendPage(
        //         messages,
        //         pageKey + messages.length,
        //       );
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
      messages.call(null);
    }
  }

  void sendMessage() async {
    try {
      if (argRoomChat.group?.groupId == null && messages.isEmpty) {
        final res = await _messageService.createGroup(
          body: PostCreateGroupBody(
            groupName: '',
            createdBy: checkLoginController.userid.value,
            members: [
              MemberList(
                  userId: argRoomChat.receiver?.userId != null
                      ? argRoomChat.receiver!.userId!
                      : -1),
              MemberList(userId: checkLoginController.userid.value),
            ],
          ),
        );
        newGroup.call(res);
      }
    } catch (e) {
      Get.log('error');
      Get.log(e.toString());
    }
    // messageEditController.text = '';
    try {
      if (messageEditController.text != '') {
        final res = await _messageService.sendMessage(
          message: PostSendMessageBody(
              receiverId: argRoomChat.receiver?.userId != null
                  ? argRoomChat.receiver!.userId!
                  : (newGroup.value?.groupId ??
                      argRoomChat.group?.groupId! ??
                      -1),
              senderId: checkLoginController.userid.value,
              groupId: argRoomChat.group?.groupId != null
                  ? argRoomChat.group!.groupId!
                  : (newGroup.value?.groupId != null
                      ? newGroup.value!.groupId!
                      : messages[0].groupId!),
              content: messageEditController.text.trim(),
              type: 1),
        );
        messageEditController.text = '';
        // messages.add(res);
        // await hubConnection.invoke("SendMessage", args: [res]);
      }
      messageEditController.text = '';
    } catch (e) {
      Get.log('error');
      Get.log(e.toString());
    }
  }

  @override
  void dispose() {
    pagingController.dispose();
    hubConnection.stop();
    super.dispose();
  }
}

class ArgRoomChat {
  ArgRoomChat({
    this.group,
    // this.receiverId,
    this.receiver,
  });
  final GroupModel? group;
  // final int? receiverId;
  final UserModel? receiver;
}
