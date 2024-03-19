import 'package:chatapp/core/gen/assets.gen.dart';
import 'package:chatapp/src/domain/models/user_model.dart';
import 'package:chatapp/src/presentation/pages/chat/home_controller.dart';
import 'package:chatapp/src/presentation/widgets/custom_no_data_widget.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class CreateGroupPage extends StatelessWidget {
  const CreateGroupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) {
        return Container(
          height: Get.height * 0.9,
          width: Get.width,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: const Icon(Icons.close),
                    ),
                    Text(
                      'Nhóm Mới',
                      style: Get.theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => controller.createGroup(),
                      child: Text(
                        'Tạo',
                        style: Get.theme.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold, color: Colors.blue),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    // obscureText: true,
                    controller: controller.nameGroupEditController,
                    style: context.theme.textTheme.bodyMedium?.copyWith(),
                    decoration: InputDecoration(
                        hintText: "Tên Nhóm (Không bắt Buộc)",
                        hintStyle: context.theme.textTheme.bodyMedium
                            ?.copyWith(color: Colors.grey),
                        border: InputBorder.none),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Container(
                  height: Get.height * 0.06,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: TextFormField(
                      style: context.theme.textTheme.bodyMedium?.copyWith(),
                      decoration: InputDecoration(
                        hintText: "Search",
                        hintStyle: context.theme.textTheme.bodyMedium,
                        prefixIcon: const Icon(Icons.search_outlined),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Obx(
                  () {
                    return (controller.selectedUsers.isNotEmpty)
                        ? SizedBox(
                            height: 120,
                            child: ListView.separated(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: controller.selectedUsers.length,
                              itemBuilder: (context, index) {
                                var item = controller.selectedUsers[index];
                                return Column(
                                  children: [
                                    Stack(
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
                                                    const BorderRadius.all(
                                                  Radius.circular(5),
                                                ),
                                                shape: BoxShape.rectangle,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 4,
                                          right: 10,
                                          child: GestureDetector(
                                            onTap: () {
                                              controller.deleteMember(item);
                                            },
                                            child: const Icon(
                                                Iconsax.close_circle),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      item.fullName ?? '',
                                      style: Get.textTheme.bodyMedium!.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      const SizedBox(
                                width: 30,
                              ),
                            ),
                          )
                        : const SizedBox.shrink();
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  'Gợi ý',
                  style: Get.theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                const ListUserView(),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ListUserView extends GetView<HomeController> {
  const ListUserView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Obx(() => ListView.separated(
            itemBuilder: (context, index) {
              final item = controller.checkLoginController.users[index];
              return InkWell(
                onTap: () {
                  controller.selectListUsers(item);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
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
                                right: 2,
                                child: Icon(
                                  Icons.circle,
                                  size: 14,
                                  color: Colors.green,
                                ),
                              )
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          item.fullName ?? '',
                          style: Get.textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Obx(
                      () => Icon(
                        controller.selectedUsers.contains(item)
                            ? Icons.check_circle
                            : Icons.circle_outlined,
                        color: controller.selectedUsers.contains(item)
                            ? Colors.green
                            : null,
                      ),
                    )
                  ],
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(
              color: Colors.black12,
              indent: 70,
              endIndent: 10,
            ),
            itemCount: controller.checkLoginController.users.length,
          )),
      // child: PagedListView<int, UserModel>.separated(
      //   shrinkWrap: true,
      //   pagingController: controller.checkLoginController.pagingUserController,
      //   builderDelegate: PagedChildBuilderDelegate(
      //     itemBuilder: (
      //       BuildContext context,
      //       UserModel item,
      //       int index,
      //     ) {
      //
      //     },
      //     noItemsFoundIndicatorBuilder: (context) => const CustomNoDataWidget(
      //       noiDung: 'Không có dữ liệu',
      //       isSearch: false,
      //     ),
      //     firstPageProgressIndicatorBuilder: (context) {
      //       return const Center(
      //         child: CircularProgressIndicator(
      //           color: Colors.red,
      //         ),
      //       );
      //     },
      //     newPageProgressIndicatorBuilder: (context) => SizedBox(
      //       height: 30,
      //       child: Center(
      //         child: CupertinoActivityIndicator(
      //           color: Get.theme.colorScheme.primary,
      //         ),
      //       ),
      //     ),
      //     firstPageErrorIndicatorBuilder: (context) => const CustomNoDataWidget(
      //       noiDung: 'Không có dữ liệu',
      //       isSearch: false,
      //     ),
      //     newPageErrorIndicatorBuilder: (context) => const CustomNoDataWidget(
      //       noiDung: 'Có lỗi xảy ra. Vui lòng thử lại!',
      //       isSearch: false,
      //     ),
      //   ),
      //   separatorBuilder: (BuildContext context, int index) {
      //     return const Divider(
      //       color: Colors.black12,
      //       indent: 70,
      //       endIndent: 10,
      //     );
      //   },
      // ),
    );
  }
}
