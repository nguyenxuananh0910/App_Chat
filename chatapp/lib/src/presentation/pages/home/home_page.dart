import 'package:chatapp/core/gen/assets.gen.dart';
import 'package:chatapp/src/domain/models/group_model.dart';
import 'package:chatapp/src/domain/models/user_model.dart';
import 'package:chatapp/src/presentation/pages/home/home_controller.dart';
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
            return Column(
              children: [
                Stack(
                  children: [
                    ClipOval(
                      child: ExtendedImage.asset(
                        Assets.images.noImageUser.path,
                        width: 80,
                        height: 60,
                        fit: BoxFit.cover,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(6),
                        ),
                        shape: BoxShape.rectangle,
                      ),
                    ),
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
      ),
    );
  }
}

class ListGroupView extends GetView<HomeController> {
  const ListGroupView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PagedListView<int, GroupModel>.separated(
      shrinkWrap: true,
      pagingController: controller.pagingGroupController,
      builderDelegate: PagedChildBuilderDelegate(
        itemBuilder: (
          BuildContext context,
          GroupModel item,
          int index,
        ) {
          return Card(
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
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        shape: BoxShape.rectangle,
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.user.value?.fullName ?? '',
                      style: Get.theme.textTheme.titleMedium,
                    ),
                    Text(
                      'New Messages',
                      style: Get.theme.textTheme.titleSmall,
                    )
                  ],
                )
              ],
            ),
          );
        },
        noItemsFoundIndicatorBuilder: (context) => const CustomNoDataWidget(
          noiDung: 'Không có dữ liệu',
          isSearch: false,
        ),
        firstPageProgressIndicatorBuilder: (context) {
          return const CircularProgressIndicator(
            color: Colors.red,
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
