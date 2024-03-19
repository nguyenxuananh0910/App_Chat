import 'package:chatapp/core/constants/auth_value_const.dart';
import 'package:chatapp/core/modules/other_modules/other_modules.dart';
import 'package:chatapp/src/domain/service/message_service.dart';
import 'package:chatapp/src/domain/service/user_service.dart';
import 'package:chatapp/src/infrastructure/clients/messages_client/messages_client.dart';
import 'package:chatapp/src/infrastructure/clients/user_client/user_client.dart';
import 'package:chatapp/src/infrastructure/repositories/messages_repository.dart';
import 'package:chatapp/src/infrastructure/repositories/user_repository.dart';
import 'package:chatapp/src/presentation/controller/checklogin_controller.dart';
import 'package:chatapp/src/presentation/controller/signalr_conect.dart';
import 'package:dio/dio.dart';
import 'package:event_bus/event_bus.dart';
import 'package:get/get.dart';

class GlobalBinding extends Bindings {
  @override
  void dependencies() {
    final otherModules = OtherModules();
    // TODO: implement dependencies

    Get.put<Dio>(otherModules.initDio(),
        permanent: true, tag: AuthValueConst.dioTAG);

    /// User
    Get.put<UserClient>(
      UserClient(
        Get.find<Dio>(tag: AuthValueConst.dioTAG),
        baseUrl: AuthValueConst.baseApiUrl,
      ),
      permanent: true,
      tag: AuthValueConst.userClientTAG,
    );
    Get.put<UserService>(
      UserRepository(),
      permanent: true,
      tag: AuthValueConst.uerSerServiceTAG,
    );

    /// Message
    Get.put<MessagesClient>(
      MessagesClient(
        Get.find<Dio>(tag: AuthValueConst.dioTAG),
        baseUrl: AuthValueConst.baseApiUrl,
      ),
      permanent: true,
      tag: AuthValueConst.messageClientTAG,
    );
    Get.put<MessageService>(
      MessagesRepository(),
      permanent: true,
      tag: AuthValueConst.messageServiceTAG,
    );

    Get.put(CheckLoginController(), permanent: true);
    Get.put(SignalRService(), permanent: true);
  }
}
