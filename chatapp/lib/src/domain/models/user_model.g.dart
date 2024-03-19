// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      userId: json['userid'] as int?,
      email: json['email'] as String?,
      username: json['username'] as String?,
      fullName: json['fullname'] as String?,
      token: json['token'] as String?,
      status: json['status'] as bool?,
      password: json['password'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'userid': instance.userId,
      'email': instance.email,
      'username': instance.username,
      'password': instance.password,
      'fullname': instance.fullName,
      'createdAt': instance.createdAt?.toIso8601String(),
      'token': instance.token,
      'status': instance.status,
    };
