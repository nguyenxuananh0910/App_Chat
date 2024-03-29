import 'package:chatapp/src/presentation/controller/checklogin_controller.dart';
import 'package:chatapp/src/presentation/controller/signalr_conect.dart';
import 'package:chatapp/src/presentation/pages/chat/home_page.dart';
import 'package:chatapp/src/presentation/pages/contact/contact_page.dart';
import 'package:chatapp/src/presentation/pages/profile/profile_page.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;
  final SignalRService _signalRService = SignalRService();
  final screens = const [
    HomePage(),
    ContactPage(),
    ProfilePage(),
  ];
}
