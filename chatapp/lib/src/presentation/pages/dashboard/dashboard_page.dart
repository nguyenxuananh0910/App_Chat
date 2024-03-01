import 'package:chatapp/src/presentation/pages/dashboard/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class DashboardPage extends GetView<DashboardController> {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(
        () => controller.screens[controller.selectedIndex.value],
      ),
      bottomNavigationBar: Obx(
        () => NavigationBar(
          backgroundColor: Colors.white,
          elevation: 0,
          onDestinationSelected: (index) =>
              controller.selectedIndex.value = index,
          selectedIndex: controller.selectedIndex.value,
          indicatorColor: Colors.red[100],
          destinations: const [
            NavigationDestination(
              icon: Icon(
                Iconsax.messages_2_copy,
                size: 30,
              ),
              label: 'Chat',
            ),
            NavigationDestination(
              icon: Icon(Icons.contact_page_outlined),
              label: 'Contact',
            ),
            NavigationDestination(
              icon: Icon(Iconsax.user),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
