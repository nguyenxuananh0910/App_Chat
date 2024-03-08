import 'package:chatapp/src/domain/models/group_model.dart';
import 'package:chatapp/src/domain/models/messages_model.dart';
import 'package:chatapp/src/domain/requests/bodys/post_create_group_body.dart';
import 'package:chatapp/src/domain/requests/bodys/post_send_message_body.dart';

abstract interface class MessageService {
  Future<List<GroupModel>> getGroups({required int userId});

  Future<GroupModel> createGroup({required PostCreateGroupBody body});

  Future<List<MessagesModel>> messages({required int groupId});

  Future<MessagesModel> sendMessage({required PostSendMessageBody message});

  Future<List<MessagesModel>> checkIfUserMessaged(
      {required int userAId, required int userBId});
}
