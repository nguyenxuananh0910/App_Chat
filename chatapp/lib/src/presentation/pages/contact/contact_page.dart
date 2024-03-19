import 'package:chatapp/core/router/app_router.dart';
import 'package:chatapp/src/domain/models/user_model.dart';
import 'package:chatapp/src/presentation/pages/chat/room_chat/room_chat_controller.dart';
import 'package:chatapp/src/presentation/pages/contact/contact_controller.dart';
import 'package:chatapp/src/presentation/widgets/contact_item_card.dart';
import 'package:chatapp/src/presentation/widgets/custom_no_data_widget.dart';
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
              ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final item = controller.checkLoginController.users[index];
                    return InkWell(
                      onTap: () => Get.toNamed(
                        AppRouter.roomChatPage,
                        arguments: ArgRoomChat(receiver: item),
                      ),
                      child: Row(
                        children: [
                          ContactItemCard(
                            data: item,
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (_, __) => const SizedBox(
                        height: 20,
                      ),
                  itemCount: controller.checkLoginController.users.length)
            ],
          ),
        ),
      ),
    );
  }
}
