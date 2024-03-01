import 'package:chatapp/core/gen/assets.gen.dart';
import 'package:chatapp/src/presentation/pages/profile/profile_controller.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text(
          'Profile',
          style: Get.textTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Center(
              child: Column(
                children: [
                  ClipOval(
                    child: ExtendedImage.asset(
                      Assets.images.noImageUser.path,
                      width: 150,
                      height: 150,
                      fit: BoxFit.cover,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(6),
                      ),
                      shape: BoxShape.rectangle,
                      loadStateChanged: (ExtendedImageState state) {
                        switch (state.extendedImageLoadState) {
                          case LoadState.loading:
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          case LoadState.completed:
                            return null;
                          case LoadState.failed:
                            return Image.asset(
                              Assets.images.noImageUser.path,
                              fit: BoxFit.cover,
                            );
                        }
                      },
                    ),
                  ),
                  Obx(
                    () => Text(
                      controller.user.value?.fullName ?? '',
                      style: context.textTheme.bodyLarge,
                    ),
                  ),
                  Obx(
                    () => Text(
                      controller.user.value?.email ?? '',
                      style: context.textTheme.bodyLarge,
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 14),
            child: InkWell(
              onTap: controller.logOut,
              child: DecoratedBox(
                decoration: BoxDecoration(
                    color: Colors.redAccent,
                    border: Border.all(
                      color: Colors.grey[300]!,
                    ),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 12,
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.login,
                        size: 30,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Log Out',
                        style: Get.textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
