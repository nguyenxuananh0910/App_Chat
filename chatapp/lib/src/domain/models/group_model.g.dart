// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupModel _$GroupModelFromJson(Map<String, dynamic> json) => GroupModel(
      groupId: json['groupid'] as int?,
      groupName: json['name'] as String?,
      lastMessageId: json['lastMessageId'] as int?,
      createdBy: json['createdBy'] as int?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      members: (json['members'] as List<dynamic>?)
          ?.map((e) => GroupMemberModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GroupModelToJson(GroupModel instance) =>
    <String, dynamic>{
      'groupid': instance.groupId,
      'name': instance.groupName,
      'lastMessageId': instance.lastMessageId,
      'createdBy': instance.createdBy,
      'createdAt': instance.createdAt?.toIso8601String(),
      'members': instance.members?.map((e) => e.toJson()).toList(),
    };
