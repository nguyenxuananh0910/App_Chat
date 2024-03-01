// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messages_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessagesModel _$MessagesModelFromJson(Map<String, dynamic> json) =>
    MessagesModel(
      messageId: json['messageId'] as int?,
      senderId: json['senderId'] as int?,
      receiverId: json['receiverId'] as int?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      content: json['content'] as String?,
      groupId: json['groupId'] as int?,
      type: json['type'] as int?,
    );

Map<String, dynamic> _$MessagesModelToJson(MessagesModel instance) =>
    <String, dynamic>{
      'messageId': instance.messageId,
      'senderId': instance.senderId,
      'receiverId': instance.receiverId,
      'groupId': instance.groupId,
      'content': instance.content,
      'type': instance.type,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
