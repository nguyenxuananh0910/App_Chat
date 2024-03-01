import 'package:chatapp/src/domain/models/group_members_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'group_model.g.dart';

@JsonSerializable(explicitToJson: true)
class GroupModel {
  GroupModel({
    this.groupId,
    this.groupName,
    this.lastMessageId,
    this.createdBy,
    this.createdAt,
    this.members,
  });
  @JsonKey(name: 'groupid')
  int? groupId;
  @JsonKey(name: 'name')
  String? groupName;
  @JsonKey(name: 'lastMessageId')
  int? lastMessageId;
  @JsonKey(name: 'createdBy')
  int? createdBy;
  @JsonKey(name: 'createdAt')
  DateTime? createdAt;
  @JsonKey(name: 'members')
  List<GroupMemberModel>? members;
  factory GroupModel.fromJson(Map<String, dynamic> json) =>
      _$GroupModelFromJson(json);

  Map<String, dynamic> toJson() => _$GroupModelToJson(this);
}
