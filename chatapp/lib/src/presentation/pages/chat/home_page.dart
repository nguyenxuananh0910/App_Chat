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
import 'package:flutter/widgets.dart';
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
        child: SingleChildScrollView(
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
      child: PagedListView<int, UserModel>.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          pagingController: controller.pagingUserController,
          builderDelegate: PagedChildBuilderDelegate(
            itemBuilder: (
              BuildContext context,
              UserModel item,
              int index,
            ) {
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
                        if (item.status == 1)
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
            noItemsFoundIndicatorBuilder: (context) => const CustomNoDataWidget(
              noiDung: 'Không có dữ liệu',
              isSearch: false,
            ),
            firstPageProgressIndicatorBuilder: (context) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.red,
                ),
              );
            },
            newPageProgressIndicatorBuilder: (context) => SizedBox(
              height: 30,
              child: Center(
                child: CupertinoActivityIndicator(
                  color: Get.theme.colorScheme.primary,
                ),
              ),
            ),
            firstPageErrorIndicatorBuilder: (context) =>
                const SizedBox.shrink(),
            newPageErrorIndicatorBuilder: (context) => const CustomNoDataWidget(
              noiDung: 'Có lỗi xảy ra. Vui lòng thử lại!',
              isSearch: false,
            ),
          ),
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(
              width: 20,
            );
          }),
    );
  }
}

class ListGroupView extends GetView<HomeController> {
  const ListGroupView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PagedListView<int, GroupModel>.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      pagingController: controller.pagingGroupController,
      builderDelegate: PagedChildBuilderDelegate(
        itemBuilder: (
          BuildContext context,
          GroupModel item,
          int index,
        ) {
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
                      Text(
                        item.groupName ?? '',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        softWrap: false,
                        style: Get.theme.textTheme.titleMedium,
                      ),
                      Text(
                        'New Messages',
                        style: Get.theme.textTheme.titleSmall,
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
        noItemsFoundIndicatorBuilder: (context) => const SizedBox.shrink(),
        // firstPageProgressIndicatorBuilder: (context) {
        //   return const CircularProgressIndicator(
        //     color: Colors.red,
        //   );
        // },
        newPageProgressIndicatorBuilder: (context) => SizedBox(
          height: 30,
          child: Center(
            child: CupertinoActivityIndicator(
              color: Get.theme.colorScheme.primary,
            ),
          ),
        ),
        firstPageErrorIndicatorBuilder: (context) => const CustomNoDataWidget(
          noiDung: 'Không có dữ liệu',
          isSearch: false,
        ),
        newPageErrorIndicatorBuilder: (context) => const CustomNoDataWidget(
          noiDung: 'Có lỗi xảy ra. Vui lòng thử lại!',
          isSearch: false,
        ),
      ),
      separatorBuilder: (_, __) => const SizedBox(
        width: 20,
      ),
    );
  }
}
