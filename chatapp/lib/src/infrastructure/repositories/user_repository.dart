import 'package:chatapp/core/constants/auth_value_const.dart';
import 'package:chatapp/src/domain/models/user_model.dart';
import 'package:chatapp/src/domain/requests/bodys/post_login_body.dart';
import 'package:chatapp/src/domain/requests/bodys/post_sign_body.dart';
import 'package:chatapp/src/domain/service/user_service.dart';
import 'package:chatapp/src/infrastructure/clients/user_client/user_client.dart';
import 'package:get/get.dart';

class UserRepository implements UserService {
  final _userClient = Get.find<UserClient>(tag: AuthValueConst.userClientTAG);
  @override
  Future<UserModel> signUser({required PostSignBody body}) async {
    try {
      final res = await _userClient.signUser(body);
      if (res != null) {
        final data = UserModel.fromJson(res['data'] as Map<String, dynamic>);
        return data;
      } else {
        throw Exception('Request Error: $res');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserModel> loginUser({required PostLoginBody body}) async {
    try {
      final res = await _userClient.loginUser(body);
      if (res != null) {
        final data = UserModel.fromJson(res['data'] as Map<String, dynamic>);
        return data;
      } else {
        throw Exception('Request Error: $res');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserModel> getUser({required int userId}) async {
    try {
      final res = await _userClient.getUser(userId);
      if (res != null) {
        final data = UserModel.fromJson(res['data'] as Map<String, dynamic>);
        return data;
      } else {
        throw Exception('Request Error: $res');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<UserModel>> getUsers({required int userId}) async {
    try {
      final res = await _userClient.getUsers(userId);
      if (res != null) {
        final data = (res['data'] as List)
            .map((e) => UserModel.fromJson(e as Map<String, dynamic>))
            .toList();
        return data;
      } else {
        throw Exception('Request Error: $res');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> updateUserStatus(
      {required int userId, required bool status}) async {
    try {
      final res = await _userClient.updateUserStatus(userId, status);
      if (res != null) {
        return res['message'];
      } else {
        throw Exception('Request Error: $res');
      }
    } catch (e) {
      rethrow;
    }
  }
}
