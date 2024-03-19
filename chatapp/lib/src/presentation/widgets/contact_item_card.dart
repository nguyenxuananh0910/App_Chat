import 'package:chatapp/src/domain/models/user_model.dart';
import 'package:chatapp/src/presentation/widgets/custom_image_user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactItemCard extends StatelessWidget {
  const ContactItemCard({
    super.key,
    required this.data,
  });

  final UserModel data;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(
          children: [
            CircleAvatarWithErrorHandler(
              fullName: data.fullName,
            ),
            if (data.status == true)
              const Positioned(
                bottom: 6,
                right: 2,
                child: Icon(
                  Icons.circle,
                  size: 16,
                  color: Colors.green,
                ),
              ),
          ],
        ),
        const SizedBox(
          width: 16,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              data.fullName ?? '',
              style: Get.textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              data.email ?? '',
              style: Get.textTheme.bodyMedium!.copyWith(),
            ),
          ],
        ),
      ],
    );
  }
}
