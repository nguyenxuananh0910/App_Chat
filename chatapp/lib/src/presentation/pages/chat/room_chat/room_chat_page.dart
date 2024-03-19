import 'package:chatapp/core/gen/assets.gen.dart';
import 'package:chatapp/src/domain/models/messages_model.dart';
import 'package:chatapp/src/presentation/pages/chat/room_chat/room_chat_controller.dart';
import 'package:chatapp/src/presentation/pages/chat/room_chat/widgets_chat/left_content.dart';
import 'package:chatapp/src/presentation/pages/chat/room_chat/widgets_chat/right_content.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RoomChatPage extends GetView<RoomChatController> {
  const RoomChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: AppBar(
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.black,
              ),
              onPressed: () => Get.back(),
            ),
            backgroundColor: Colors.redAccent,
            leadingWidth: 60,
            title: Text(
              controller.argRoomChat.group?.groupName != null
                  ? controller.argRoomChat.group?.groupName != ''
                      ? controller.argRoomChat.group!.groupName!
                      : controller.argRoomChat.receiver?.fullName ?? ''
                  : controller.argRoomChat.receiver?.fullName ?? '',
              style: Get.textTheme.titleMedium!.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.more_vert,
                  size: 26,
                  color: Colors.deepPurple[500],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: Obx(() {
                if (controller.isLoading.isTrue) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return controller.messages.isNotEmpty
                      ? ListView.builder(
                          reverse: true,
                          shrinkWrap: true,
                          itemCount: controller.messages.length,
                          itemBuilder: (context, index) {
                            final reversedList =
                                List.from(controller.messages.reversed);
                            final message = reversedList[index];
                            MessagesModel? lastItem;
                            if (index > 0) {
                              lastItem = controller.messages[index - 1];
                            }
                            MessagesModel? currentItem = message;

                            MessagesModel? nextItem;
                            if ((controller.messages.length - 1) > index) {
                              nextItem = controller.messages[index + 1];
                            }

                            if (currentItem?.senderId !=
                                controller.checkLoginController.userid.value) {
                              return LeftContent(
                                current: currentItem!,
                                last: lastItem,
                                next: nextItem,
                              );
                            }
                            return RightContent(
                              current: currentItem!,
                              last: lastItem,
                              next: nextItem,
                              currentIndex: index,
                            );
                          },
                        )
                      : Center(
                          child: Container(
                            width: 300,
                            height: 240,
                            decoration: BoxDecoration(
                                color: Colors.red.shade100,
                                borderRadius: BorderRadius.circular(14)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(
                                    "Chúng ta chưa có tin nhắn nào ở đây...",
                                    style: Get.theme.textTheme.bodyMedium,
                                  ),
                                  Text(
                                    "bắt đầu gửi tin nhắn ngay nào!",
                                    style: Get.theme.textTheme.titleMedium,
                                  ),
                                  SizedBox(
                                    width: 200,
                                    child: ExtendedImage.network(
                                      'https://cdn.dribbble.com/userupload/3271927/file/original-223856aa8fef836d7bc818da6154f3ab.gif',
                                      fit: BoxFit.cover,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5)),
                                      shape: BoxShape.rectangle,
                                      loadStateChanged:
                                          (ExtendedImageState state) {
                                        switch (state.extendedImageLoadState) {
                                          case LoadState.loading:
                                            return const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          case LoadState.completed:
                                            return null;
                                          case LoadState.failed:
                                            return Image.asset(
                                              Assets.images.nodata.path,
                                            );
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                }
              }),
            ),
            const GetBottomBar(),
          ],
        ),
      ),
    );
  }
}

class GetBottomBar extends GetView<RoomChatController> {
  const GetBottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Card(
            color: Get.theme.colorScheme.surfaceVariant,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // GestureDetector(
                  //   onTap: () {},
                  //   child: Image.asset(IconAssets.iconCamera),
                  // ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: TextField(
                      textInputAction: TextInputAction.done,
                      controller: controller.messageEditController,
                      decoration: const InputDecoration(
                          hintText: 'Message', border: InputBorder.none),
                    ),
                  ),
                  IconButton(
                    onPressed: () => controller.sendMessage(),
                    icon: const Icon(
                      Icons.send,
                      color: Colors.deepPurple,
                    ),
                  ),
                  // GestureDetector(
                  //   onTap: () => controller.getGallery(),
                  //   child: Image.asset(IconAssets.iconGallery),
                  // ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
