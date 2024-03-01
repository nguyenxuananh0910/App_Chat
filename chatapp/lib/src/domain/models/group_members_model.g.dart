// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_members_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupMemberModel _$GroupMemberModelFromJson(Map<String, dynamic> json) =>
    GroupMemberModel(
      groupId: json['groupsId'] as int?,
      userId: json['userid'] as int?,
      joinedAt: json['joinedAt'] == null
          ? null
          : DateTime.parse(json['joinedAt'] as String),
      leftAt: json['leftAt'] == null
          ? null
          : DateTime.parse(json['leftAt'] as String),
    );

Map<String, dynamic> _$GroupMemberModelToJson(GroupMemberModel instance) =>
    <String, dynamic>{
      'groupsId': instance.groupId,
      'userid': instance.userId,
      'joinedAt': instance.joinedAt?.toIso8601String(),
      'leftAt': instance.leftAt?.toIso8601String(),
    };
