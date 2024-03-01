import 'package:chatapp/core/constants/auth_value_const.dart';
import 'package:chatapp/src/domain/models/group_model.dart';
import 'package:chatapp/src/domain/models/messages_model.dart';
import 'package:chatapp/src/domain/requests/bodys/post_create_group_body.dart';
import 'package:chatapp/src/domain/requests/bodys/post_send_message_body.dart';
import 'package:chatapp/src/domain/service/message_service.dart';
import 'package:chatapp/src/infrastructure/clients/messages_client/messages_client.dart';
import 'package:get/get.dart';

class MessagesRepository implements MessageService {
  final _messageClient =
      Get.find<MessagesClient>(tag: AuthValueConst.messageClientTAG);
  @override
  Future<List<MessagesModel>> checkIfUserMessaged(
      {required int userAId, required int userBId}) async {
    try {
      final res = await _messageClient.checkIfUserMessaged(userAId, userBId);
      if (res != null) {
        final data = (res['data'] as List)
            .map((e) => MessagesModel.fromJson(e as Map<String, dynamic>))
            .toList();
        return data;
      } else {
        throw Exception('Request Error: $res');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<GroupModel>> getGroups({required int userId}) async {
    try {
      final res = await _messageClient.getGroups(userId);
      if (res != null) {
        final data = (res['data'] as List)
            .map((e) => GroupModel.fromJson(e as Map<String, dynamic>))
            .toList();
        return data;
      } else {
        throw Exception('Request Error: $res');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<MessagesModel>> messages({required int groupId}) async {
    try {
      final res = await _messageClient.getMessages(groupId);
      if (res != null) {
        final data = (res['data'] as List)
            .map((e) => MessagesModel.fromJson(e as Map<String, dynamic>))
            .toList();
        return data;
      } else {
        throw Exception('Request Error: $res');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<GroupModel> createGroup({required PostCreateGroupBody group}) async {
    try {
      final res = await _messageClient.createGroup(group);
      if (res != null) {
        final data = GroupModel.fromJson(res['data'] as Map<String, dynamic>);
        return data;
      } else {
        throw Exception('Request Error: $res');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<MessagesModel> sendMessage(
      {required PostSendMessageBody message}) async {
    try {
      final res = await _messageClient.sendMessage(message);
      if (res != null) {
        final data =
            MessagesModel.fromJson(res['data'] as Map<String, dynamic>);
        return data;
      } else {
        throw Exception('Request Error: $res');
      }
    } catch (e) {
      rethrow;
    }
  }
}
