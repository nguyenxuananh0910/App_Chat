import 'package:chatapp/core/constants/auth_value_const.dart';
import 'package:chatapp/src/domain/models/user_model.dart';
import 'package:chatapp/src/domain/service/user_service.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckLoginController extends GetxController {
  RxBool isLogin = false.obs;
  RxString token = ''.obs;
  RxInt userid = 0.obs;
  final UserService _userService =
      Get.find(tag: AuthValueConst.uerSerServiceTAG);
  final Rxn<UserModel> user = Rxn<UserModel>();
  @override
  void onInit() {
    dataUser();
    super.onInit();
  }

  Future getUser({required int receiverId}) async {
    try {
      final res = await _userService.getUser(userId: receiverId);
      user.call(res);
    } catch (error) {
      if (Get.isSnackbarOpen) Get.closeAllSnackbars();
      Get.snackbar(
        'Thông Báo',
        'Kết nối internet thất bại',
        backgroundColor: Get.theme.colorScheme.error,
      );
      Get.log(
        error.toString(),
      );
    }
  }

  Future<void> dataUser() async {
    final prefs = await SharedPreferences.getInstance();
    // isLogin.value = prefs.getBool(AuthValueConst.isLogin) ?? false;
    token.value = prefs.getString(AuthValueConst.token) ?? '';
    userid.value = prefs.getInt(AuthValueConst.userId) ?? -1;
  }

  Future<void> login({required int userId, required String token}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(AuthValueConst.userId, userId);
    await prefs.setString(AuthValueConst.token, token);
    await prefs.setBool(AuthValueConst.isLogin, true);
    dataUser();
  }

  Future<void> logOut() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(AuthValueConst.isLogin, false);
    prefs.setInt(AuthValueConst.userId, -1);
    prefs.setString(AuthValueConst.token, '');
    user.value = null;
  }
}
