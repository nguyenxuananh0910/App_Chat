import 'package:equatable/equatable.dart';

class PostLoginBody extends Equatable {
  const PostLoginBody({
    required this.password,
    required this.username,
    required this.msgToken,
  });
  final String username;
  final String password;
  final String msgToken;
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'username': username,
      'password': password,
      'msgToken': msgToken,
    };
  }

  PostLoginBody copyWith({
    String? username,
    String? password,
    String? msgToken,
  }) {
    return PostLoginBody(
      username: username ?? this.username,
      password: password ?? this.password,
      msgToken: msgToken ?? this.msgToken,
    );
  }

  @override
  String toString() {
    return 'PostLoginBody( username: $username, password: $password,msgToken: $msgToken)';
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        username,
        password,
        msgToken,
      ];
}
