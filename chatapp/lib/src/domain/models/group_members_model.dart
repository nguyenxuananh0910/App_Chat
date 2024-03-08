import 'package:chatapp/src/domain/models/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'group_members_model.g.dart';

@JsonSerializable(explicitToJson: true)
class GroupMemberModel {
  GroupMemberModel({
    this.groupId,
    this.users,
    this.joinedAt,
    this.userid,
    this.leftAt,
  });
  @JsonKey(name: 'groupId')
  int? groupId;
  @JsonKey(name: 'userid')
  int? userid;
  @JsonKey(name: 'joinedAt')
  DateTime? joinedAt;
  @JsonKey(name: 'leftAt')
  DateTime? leftAt;
  @JsonKey(name: 'users')
  UserModel? users;
  factory GroupMemberModel.fromJson(Map<String, dynamic> json) =>
      _$GroupMemberModelFromJson(json);

  Map<String, dynamic> toJson() => _$GroupMemberModelToJson(this);
}
