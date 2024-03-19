import 'package:chatapp/core/gen/assets.gen.dart';
import 'package:chatapp/core/router/app_router.dart';
import 'package:chatapp/src/domain/models/group_model.dart';
import 'package:chatapp/src/domain/models/user_model.dart';
import 'package:chatapp/src/presentation/pages/chat/create_group/create_group_page.dart';
import 'package:chatapp/src/presentation/pages/chat/home_controller.dart';
import 'package:chatapp/src/presentation/pages/chat/room_chat/room_chat_controller.dart';
import 'package:chatapp/src/presentation/widgets/custom_no_data_widget.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.colorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text(
          'Chat',
          style: Get.textTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListUsers(),
            SizedBox(
              height: 10,
            ),
            ListGroupView(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Get.bottomSheet(isScrollControlled: true, const CreateGroupPage()),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ListUsers extends GetView<HomeController> {
  const ListUsers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Obx(() => ListView.separated(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final item = controller.checkLoginController.users[index];
            return InkWell(
              onTap: () => Get.toNamed(
                AppRouter.roomChatPage,
                arguments: ArgRoomChat(receiver: item),
              ),
              child: Column(
                children: [
                  Stack(
                    children: [
                      ClipOval(
                        child: ExtendedImage.asset(
                          Assets.images.noImageUser.path,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(6),
                          ),
                          shape: BoxShape.rectangle,
                        ),
                      ),
                      if (item.status == true)
                        const Positioned(
                          bottom: 0,
                          right: 0,
                          child: Icon(
                            Icons.circle,
                            size: 14,
                            color: Colors.green,
                          ),
                        )
                    ],
                  ),
                  Text(
                    item.fullName?.split(' ').last ?? '',
                    style: Get.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (_, __) => const SizedBox(
                width: 20,
              ),
          itemCount: controller.checkLoginController.users.length)),
    );
  }
}

class ListGroupView extends GetView<HomeController> {
  const ListGroupView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final item = controller.groups[index];
          if (item.members?.length == 2) {
            return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: item.members?.length,
              itemBuilder: (context, index) {
                var user = item.members?[index];
                if (user?.users?.userId !=
                    controller.checkLoginController.userid.value) {
                  return InkWell(
                    onTap: () => Get.toNamed(
                      AppRouter.roomChatPage,
                      arguments: ArgRoomChat(
                        group: item,
                        receiver: user?.users,
                      ),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: Get.width * 0.2,
                          height: Get.width * 0.2,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: ClipOval(
                              child: ExtendedImage.asset(
                                Assets.images.noImageUser.path,
                                fit: BoxFit.cover,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(5),
                                ),
                                shape: BoxShape.rectangle,
                              ),
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.members!.length >= 3
                                  ? item.groupName ?? ''
                                  : user?.users?.fullName ?? '',
                              style: Get.theme.textTheme.titleMedium,
                            ),
                            Text(
                              user?.users?.userId == item.lastMessage?.senderId
                                  ? item.lastMessage?.content ?? 'new message'
                                  : 'bạn: ${item.lastMessage?.content}',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              softWrap: false,
                              style: Get.theme.textTheme.titleSmall,
                            )
                          ],
                        )
                      ],
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            );
          }
          return InkWell(
            onTap: () => Get.toNamed(
              AppRouter.roomChatPage,
              arguments: ArgRoomChat(group: item),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: Get.width * 0.2,
                  height: Get.width * 0.2,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ClipOval(
                      child: ExtendedImage.asset(
                        Assets.images.groupAvatar.path,
                        fit: BoxFit.cover,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(5),
                        ),
                        shape: BoxShape.rectangle,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.groupName ?? '',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          softWrap: false,
                          style: Get.textTheme.titleMedium),
                      Text(
                        'New Messages',
                        style: Get.textTheme.titleSmall,
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
        separatorBuilder: (_, __) {
          return const SizedBox(
            height: 20,
          );
        },
        itemCount: controller.groups.length));
  }
}
