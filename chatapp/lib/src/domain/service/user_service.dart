import 'package:chatapp/src/domain/models/user_model.dart';
import 'package:chatapp/src/domain/requests/bodys/post_sign_body.dart';

abstract interface class UserService {
  Future<UserModel> signUser({required PostSignBody body});

  Future<UserModel> loginUser(
      {required String username, required String password});

  Future<UserModel> getUser({required int userId});
  Future<List<UserModel>> getUsers({required int userId});
}
