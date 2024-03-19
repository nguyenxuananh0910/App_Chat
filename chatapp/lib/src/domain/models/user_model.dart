import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable(explicitToJson: true)
class UserModel {
  UserModel({
    this.userId,
    this.email,
    this.username,
    this.fullName,
    this.token,
    this.status,
    this.password,
    this.createdAt,
  });
  @JsonKey(name: 'userid')
  int? userId;
  @JsonKey(name: 'email')
  String? email;
  @JsonKey(name: 'username')
  String? username;
  @JsonKey(name: 'password')
  String? password;
  @JsonKey(name: 'fullname')
  String? fullName;
  @JsonKey(name: 'createdAt')
  DateTime? createdAt;
  @JsonKey(name: 'token')
  String? token;
  @JsonKey(name: 'status')
  bool? status;
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
