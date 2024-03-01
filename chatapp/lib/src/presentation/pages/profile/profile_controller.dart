import 'package:chatapp/core/constants/auth_value_const.dart';
import 'package:chatapp/core/router/app_router.dart';
import 'package:chatapp/src/domain/models/user_model.dart';
import 'package:chatapp/src/domain/service/user_service.dart';
import 'package:chatapp/src/presentation/controller/checklogin_controller.dart';
import 'package:chatapp/src/presentation/widgets/dialog_notification.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final Rxn<UserModel> user = Rxn<UserModel>();
  final CheckLoginController checkLoginController = Get.find();
  final UserService _userService =
      Get.find(tag: AuthValueConst.uerSerServiceTAG);

  @override
  void onInit() {
    fetchUser();
    super.onInit();
  }

  Future<void> fetchUser() async {
    try {
      final res =
          await _userService.getUser(userId: checkLoginController.userid.value);
      user.call(res);
    } catch (e) {
      Get.log(
        e.toString(),
      );
    }
  }

  Future<void> logOut() async {
    Get.dialog(
      DiaLogLogOut(
        onTap: () async {
          await checkLoginController.logOut();
          await Get.offAllNamed(AppRouter.loginPage);
        },
        title: 'Sign Out',
        content: 'Are you sure you want to sign out?',
        okText: 'Yes, Sign out',
      ),
    );
  }
}
