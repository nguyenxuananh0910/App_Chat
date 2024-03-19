import 'package:chatapp/src/domain/models/user_model.dart';
import 'package:chatapp/src/domain/requests/bodys/post_login_body.dart';
import 'package:chatapp/src/domain/requests/bodys/post_sign_body.dart';

abstract interface class UserService {
  Future<UserModel> signUser({required PostSignBody body});

  Future<UserModel> loginUser({required PostLoginBody body});

  Future<UserModel> getUser({required int userId});

  Future<List<UserModel>> getUsers({required int userId});

  Future<String> updateUserStatus({required int userId, required bool status});
}
