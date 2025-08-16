import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:task_tracker/widgets/nav_controller.dart';
import 'package:task_tracker/widgets/themenotifier.dart';

class CreateBottomNavigationBar extends StatefulWidget {
  const CreateBottomNavigationBar({super.key});

  @override
  State<CreateBottomNavigationBar> createState() =>
      _CreateBottomNavigationBarState();
}

class _CreateBottomNavigationBarState extends State<CreateBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    final globalThemeColor = Provider.of<ThemeNotifier>(context).themeColor;
    final NavController navController = Get.find<NavController>();

    return Stack(
      children: [
        Container(
          height: 60, // Height matching BottomNavigationBar
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                globalThemeColor.shade700,
                globalThemeColor.shade200,
              ],
            ),
          ),
        ),
        Obx(
          () => BottomNavigationBar(
            currentIndex: navController.selectedIndex.value,
            onTap: (index) {
              HapticFeedback.selectionClick(); // Haptic feedback on tab change
              navController.changeTabIndex(index);
              switch (index) {
                case 0:
                  Get.offNamed('/'); // Navigate to Home
                  break;
                case 1:
                  Get.offNamed('/tasks'); // Navigate to Tasks
                  break;
                case 2:
                  Get.offNamed('/profile'); // Navigate to Profile
                  break;
              }
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_rounded),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.list_alt_rounded),
                label: 'Tasks',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_rounded),
                label: 'Profile',
              ),
            ],
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.black,
            backgroundColor: Colors.transparent,
            elevation: 0, // Remove shadow
          ),
        ),
      ],
    );
  }
}
