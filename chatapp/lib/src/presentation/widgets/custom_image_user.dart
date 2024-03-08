import 'package:chatapp/core/gen/assets.gen.dart';
import 'package:chatapp/core/utils/helpers/string_ext.dart';
import 'package:flutter/material.dart';

class CircleAvatarWithErrorHandler extends StatefulWidget {
  const CircleAvatarWithErrorHandler({
    super.key,
    // required this.avatarUrl,
    required this.fullName,
    this.radius,
  });

  // final String? avatarUrl;
  final String? fullName;
  final double? radius;
  @override
  State<CircleAvatarWithErrorHandler> createState() =>
      _CircleAvatarWithErrorHandlerState();
}

class _CircleAvatarWithErrorHandlerState
    extends State<CircleAvatarWithErrorHandler> {
  bool isAvatarLoadError = false;
  // final configs = locator<DanhBaConfigs>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    TextStyle textStyle =
        theme.primaryTextTheme.titleMedium!.copyWith(color: Colors.black);
    Color backgroundColor = Colors.grey[400]!;
    // final baseUrl = configs.imageBaseUrl ?? configs.baseUrl;
    // final imageLink = '$baseUrl${widget.avatarUrl}';
    return CircleAvatar(
      backgroundColor: backgroundColor,
      radius: 40,
      child: Text(
        widget.fullName!.initialWords.toUpperCase(),
        style: textStyle.copyWith(
          fontSize: widget.radius != null ? widget.radius! / 1.5 : null,
        ),
      ),
    );
  }
}
