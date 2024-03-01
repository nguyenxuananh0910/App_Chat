import 'package:chatapp/core/gen/assets.gen.dart';
import 'package:chatapp/src/domain/models/user_model.dart';
import 'package:chatapp/src/presentation/pages/contact/contact_controller.dart';
import 'package:chatapp/src/presentation/widgets/custom_no_data_widget.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ContactPage extends GetView<ContactController> {
  static const String routeName = '/HomePage';
  const ContactPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text(
          'Danh Bạ',
          style: Get.textTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PagedListView<int, UserModel>.separated(
                  shrinkWrap: true,
                  pagingController: controller.pagingController,
                  builderDelegate: PagedChildBuilderDelegate(
                    itemBuilder: (
                      BuildContext context,
                      UserModel item,
                      int index,
                    ) {
                      return Row(
                        children: [
                          Stack(
                            children: [
                              ClipOval(
                                child: ExtendedImage.asset(
                                  Assets.images.noImageUser.path,
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(6),
                                  ),
                                  shape: BoxShape.rectangle,
                                ),
                              ),
                              const Positioned(
                                bottom: 0,
                                right: 10,
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.fullName ?? '',
                                style: Get.textTheme.titleMedium!.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                item.email ?? '',
                                style: Get.textTheme.bodyMedium!.copyWith(),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                    noItemsFoundIndicatorBuilder: (context) =>
                        const CustomNoDataWidget(
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
                        const CustomNoDataWidget(
                      noiDung: 'Không có dữ liệu',
                      isSearch: false,
                    ),
                    newPageErrorIndicatorBuilder: (context) =>
                        const CustomNoDataWidget(
                      noiDung: 'Có lỗi xảy ra. Vui lòng thử lại!',
                      isSearch: false,
                    ),
                  ),
                  separatorBuilder: (_, __) => const SizedBox(
                        height: 20,
                      ))
            ],
          ),
        ),
      ),
    );
  }
}
