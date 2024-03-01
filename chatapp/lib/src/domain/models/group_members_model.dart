import 'package:json_annotation/json_annotation.dart';

part 'group_members_model.g.dart';

@JsonSerializable(explicitToJson: true)
class GroupMemberModel {
  GroupMemberModel({
    this.groupId,
    this.userId,
    this.joinedAt,
    this.leftAt,
  });
  @JsonKey(name: 'groupsId')
  int? groupId;
  @JsonKey(name: 'userid')
  int? userId;
  @JsonKey(name: 'joinedAt')
  DateTime? joinedAt;
  @JsonKey(name: 'leftAt')
  DateTime? leftAt;
  factory GroupMemberModel.fromJson(Map<String, dynamic> json) =>
      _$GroupMemberModelFromJson(json);

  Map<String, dynamic> toJson() => _$GroupMemberModelToJson(this);
}
