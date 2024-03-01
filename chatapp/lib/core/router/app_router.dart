import 'package:chatapp/src/presentation/pages/contact/contact_controller.dart';
import 'package:chatapp/src/presentation/pages/contact/contact_page.dart';
import 'package:chatapp/src/presentation/pages/dashboard/dashboard_controller.dart';
import 'package:chatapp/src/presentation/pages/dashboard/dashboard_page.dart';
import 'package:chatapp/src/presentation/pages/home/home_controller.dart';
import 'package:chatapp/src/presentation/pages/home/home_page.dart';
import 'package:chatapp/src/presentation/pages/login/login_controller.dart';
import 'package:chatapp/src/presentation/pages/login/login_page.dart';
import 'package:chatapp/src/presentation/pages/profile/profile_controller.dart';
import 'package:chatapp/src/presentation/pages/profile/profile_page.dart';
import 'package:chatapp/src/presentation/pages/sign/sign_controller.dart';
import 'package:chatapp/src/presentation/pages/sign/sign_page.dart';
import 'package:chatapp/src/presentation/pages/start_view.dart';
import 'package:get/get.dart';

class AppRouter {
  static const startRoute = '/';
  static const signPage = '/sign-page';
  static const loginPage = '/login-page';
  static const dashboardPage = '/dashboard-page';
  static const homePage = '/home-page';
  static const contactPage = '/contact-page';
  static const profilePage = '/profile-page';

  static final getPages = [
    GetPage(
      name: startRoute,
      page: () => const AppStartView(),
    ),
    GetPage(
      name: loginPage,
      page: () => const LoginView(),
      binding: BindingsBuilder<void>(
        () => Get.lazyPut(LoginController.new),
      ),
    ),
    GetPage(
      name: signPage,
      page: () => const SignPage(),
      binding: BindingsBuilder<void>(
        () => Get.lazyPut(SignController.new),
      ),
    ),
    GetPage(
      name: dashboardPage,
      page: () => const DashboardPage(),
      binding: BindingsBuilder<void>(() {
        Get.lazyPut(DashboardController.new);
        Get.lazyPut(HomeController.new);
        Get.lazyPut(ContactController.new);
        Get.lazyPut(ProfileController.new);
      }),
    ),
    GetPage(
      name: homePage,
      page: () => const HomePage(),
      binding: BindingsBuilder<void>(
        () {
          Get.lazyPut(HomeController.new);
        },
      ),
    ),
    GetPage(
      name: contactPage,
      page: () => const ContactPage(),
      binding: BindingsBuilder<void>(
        () {
          Get.lazyPut(ContactController.new);
        },
      ),
    ),
    GetPage(
      name: profilePage,
      page: () => const ProfilePage(),
      binding: BindingsBuilder<void>(
        () {
          Get.lazyPut(ProfileController.new);
        },
      ),
    ),
  ];
}
