import 'package:equatable/equatable.dart';

class PostCreateGroupBody extends Equatable {
  const PostCreateGroupBody({
    required this.groupName,
    required this.createdBy,
    required this.members,
  });
  final String groupName;
  final int createdBy;
  final List<MemberList> members;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'groupName': groupName,
      'createdBy': createdBy,
      'members': members.map((e) => e.toJson()).toList(),
    };
  }

  PostCreateGroupBody copyWith({
    String? groupName,
    int? createdBy,
    List<MemberList>? members,
  }) {
    return PostCreateGroupBody(
      groupName: groupName ?? this.groupName,
      createdBy: createdBy ?? this.createdBy,
      members: members ?? this.members,
    );
  }

  @override
  String toString() {
    return 'PostCreateGroupBody(groupName: $groupName, createdBy: $createdBy,member: $members)';
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        groupName,
        createdBy,
        members,
      ];
}

class MemberList extends Equatable {
  const MemberList({
    required this.userId,
  });

  final int userId;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'userid': userId,
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
