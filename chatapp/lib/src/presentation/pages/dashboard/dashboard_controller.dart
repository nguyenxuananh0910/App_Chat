import 'package:chatapp/src/presentation/pages/contact/contact_page.dart';
import 'package:chatapp/src/presentation/pages/home/home_page.dart';
import 'package:chatapp/src/presentation/pages/profile/profile_page.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = const [
    HomePage(),
    ContactPage(),
    ProfilePage(),
  ];
}
