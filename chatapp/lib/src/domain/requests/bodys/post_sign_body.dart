import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class PostSignBody extends Equatable {
  const PostSignBody({
    required this.email,
    required this.password,
    required this.username,
    required this.fullName,
  });
  final String email;
  final String username;
  final String password;
  final String fullName;
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'email': email,
      'username': username,
      'password': password,
      'fullname': fullName,
    };
  }

  PostSignBody copyWith({
    String? email,
    String? username,
    String? password,
    String? fullName,
  }) {
    return PostSignBody(
      email: email ?? this.email,
      username: username ?? this.username,
      password: password ?? this.password,
      fullName: fullName ?? this.fullName,
    );
  }

  @override
  String toString() {
    return 'PostSignBody(email: $email, username: $username, password: $password,fullName: $fullName)';
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        email,
        username,
        password,
        fullName,
      ];
}
