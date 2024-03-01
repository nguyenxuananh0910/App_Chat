import 'package:json_annotation/json_annotation.dart';

part 'messages_model.g.dart';

@JsonSerializable(explicitToJson: true)
class MessagesModel {
  MessagesModel({
    this.messageId,
    this.senderId,
    this.receiverId,
    this.createdAt,
    this.content,
    this.groupId,
    this.type,
  });
  @JsonKey(name: 'messageId')
  int? messageId;
  @JsonKey(name: 'senderId')
  int? senderId;
  @JsonKey(name: 'receiverId')
  int? receiverId;
  @JsonKey(name: 'groupId')
  int? groupId;
  @JsonKey(name: 'content')
  String? content;
  @JsonKey(name: 'type')
  int? type;
  @JsonKey(name: 'createdAt')
  DateTime? createdAt;
  factory MessagesModel.fromJson(Map<String, dynamic> json) =>
      _$MessagesModelFromJson(json);
  Map<String, dynamic> toJson() => _$MessagesModelToJson(this);
}
