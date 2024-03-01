import 'package:equatable/equatable.dart';

class PostCreateGroupBody extends Equatable {
  const PostCreateGroupBody({
    required this.groupName,
    required this.createdBy,
    required this.member,
  });
  final String groupName;
  final int createdBy;
  final List<MemberList> member;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'groupName': groupName,
      'createdBy': createdBy,
      'member': member.map((e) => e.toJson()).toList(),
    };
  }

  PostCreateGroupBody copyWith({
    String? groupName,
    int? createdBy,
    List<MemberList>? member,
  }) {
    return PostCreateGroupBody(
      groupName: groupName ?? this.groupName,
      createdBy: createdBy ?? this.createdBy,
      member: member ?? this.member,
    );
  }

  @override
  String toString() {
    return 'PostCreateGroupBody(groupName: $groupName, createdBy: $createdBy,member: $member)';
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        groupName,
        createdBy,
        member,
      ];
}

class MemberList extends Equatable {
  const MemberList({
    required this.userId,
  });

  final int userId;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'userId': userId,
    };
  }

  MemberList copyWith({
    int? userId,
  }) {
    return MemberList(
      userId: userId ?? this.userId,
    );
  }

  @override
  String toString() {
    return 'MemberList(userId: $userId)';
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        userId,
      ];
}
