import 'package:chatapp/core/constants/auth_value_const.dart';
import 'package:chatapp/src/domain/models/user_model.dart';
import 'package:chatapp/src/domain/service/user_service.dart';
import 'package:chatapp/src/presentation/controller/signalr_conect.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckLoginController extends GetxController {
  RxBool isLogin = false.obs;
  RxString token = ''.obs;
  RxInt userid = 0.obs;
  final UserService _userService =
      Get.find(tag: AuthValueConst.uerSerServiceTAG);
  final Rxn<UserModel> user = Rxn<UserModel>();
  // late PagingController<int, UserModel> pagingUserController;
  // final scrollController = ScrollController();
  final RxList<UserModel> users = <UserModel>[].obs;
  final SignalRService _signalRService = SignalRService();
  @override
  void onInit() {
    dataUser();
    _signalRService.connect();
    _connectToSignalR();
    super.onInit();
  }

  void _connectToSignalR() async {
    try {
      _signalRService.connection.on('UpdateUserStatus', (data) {
        Get.log('connection success');
        fetchUsers();
      });
    } catch (e) {
      Get.log('error');
      Get.log(e.toString());
    }
  }

  Future fetchUsers() async {
    try {
      final res = await _userService.getUsers(userId: userid.value);
      users.call(res);
    } catch (error) {
      // pagingUserController.error = error;
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
    isLogin.value = prefs.getBool(AuthValueConst.isLogin) ?? false;
    token.value = prefs.getString(AuthValueConst.token) ?? '';
    userid.value = prefs.getInt(AuthValueConst.userId) ?? -1;
    // updateStatus(status: true);
    if (isLogin.value == true) {
      fetchUsers();
      getUser(receiverId: userid.value);
    }
  }

  Future<void> login({required int userId, required String token}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(AuthValueConst.userId, userId);
    await prefs.setString(AuthValueConst.token, token);
    await prefs.setBool(AuthValueConst.isLogin, true);
    dataUser();
    // await _signalRService.setUserOnline(userid.value);
    // updateStatus(status: true);
  }

  Future<void> logOut() async {
    await _signalRService.disconnect();
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(AuthValueConst.isLogin, false);
    prefs.setInt(AuthValueConst.userId, -1);
    prefs.setString(AuthValueConst.token, '');
    user.value = null;
  }
}
