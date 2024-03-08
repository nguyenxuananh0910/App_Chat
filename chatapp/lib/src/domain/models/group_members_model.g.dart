// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_members_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupMemberModel _$GroupMemberModelFromJson(Map<String, dynamic> json) =>
    GroupMemberModel(
      groupId: json['groupId'] as int?,
      users: json['users'] == null
          ? null
          : UserModel.fromJson(json['users'] as Map<String, dynamic>),
      joinedAt: json['joinedAt'] == null
          ? null
          : DateTime.parse(json['joinedAt'] as String),
      userid: json['userid'] as int?,
      leftAt: json['leftAt'] == null
          ? null
          : DateTime.parse(json['leftAt'] as String),
    );

Map<String, dynamic> _$GroupMemberModelToJson(GroupMemberModel instance) =>
    <String, dynamic>{
      'groupId': instance.groupId,
      'userid': instance.userid,
      'joinedAt': instance.joinedAt?.toIso8601String(),
      'leftAt': instance.leftAt?.toIso8601String(),
      'users': instance.users?.toJson(),
    };
