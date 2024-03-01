import 'package:equatable/equatable.dart';

class PostSendMessageBody extends Equatable {
  const PostSendMessageBody({
    required this.receiverId,
    required this.senderId,
    required this.groupId,
    required this.content,
    required this.type,
  });
  final int receiverId;
  final int senderId;
  final int groupId;
  final String content;
  final int type;
  Map<String, dynamic> toJson() {
    return {
      'receiverId': receiverId,
      'senderId': senderId,
      'groupId': groupId,
      'content': content,
      'type': type,
    };
  }

  PostSendMessageBody copyWith({
    int? receiverId,
    int? senderId,
    int? groupId,
    String? content,
    int? type,
  }) {
    return PostSendMessageBody(
      receiverId: receiverId ?? this.receiverId,
      senderId: senderId ?? this.senderId,
      groupId: groupId ?? this.groupId,
      content: content ?? this.content,
      type: type ?? this.type,
    );
  }

  @override
  String toString() {
    return 'PostSendMessageBody(receiverId: $receiverId, senderId: $senderId,groupId: $groupId, content: $content, type: $type)';
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        receiverId,
        senderId,
        groupId,
        content,
        type,
      ];
}
