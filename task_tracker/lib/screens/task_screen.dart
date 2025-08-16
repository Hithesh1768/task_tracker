// lib/screens/task_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:task_tracker/widgets/nav_bar.dart';
import 'package:task_tracker/widgets/nav_controller.dart';
import 'package:task_tracker/widgets/themenotifier.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NavController navController = Get.put(NavController());
    final globalThemeColor = Provider.of<ThemeNotifier>(context).themeColor;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your Tasks',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        backgroundColor: globalThemeColor.shade700,
      ),
      backgroundColor: globalThemeColor.shade100,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [globalThemeColor.shade700, globalThemeColor.shade100],
          ),
        ),
        child: ListView(
          children: [
            ListTile(
              leading: const Icon(
                Icons.pending,
                color: Colors.black,
                size: 30,
              ),
              title: const Text(
                'Upcoming Tasks',
                style: TextStyle(fontSize: 18),
              ),
              onTap: () {
                Get.toNamed('/upcoming');
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.access_time,
                color: Colors.black,
                size: 30,
              ),
              title: const Text(
                'Ongoing Tasks',
                style: TextStyle(fontSize: 18),
              ),
              onTap: () {
                Get.toNamed('/ongoing');
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.check_circle,
                color: Colors.black,
                size: 30,
              ),
              title: const Text(
                'Completed Tasks',
                style: TextStyle(fontSize: 18),
              ),
              onTap: () {
                Get.toNamed('/completed');
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.warning,
                color: Colors.black,
                size: 30,
              ),
              title: const Text(
                'Overdue Tasks',
                style: TextStyle(fontSize: 18),
              ),
              onTap: () {
                Get.toNamed('/overdue');
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.list,
                color: Colors.black,
                size: 30,
              ),
              title: const Text(
                'All Tasks',
                style: TextStyle(fontSize: 18),
              ),
              onTap: () {
                Get.toNamed('/all-tasks');
              },
            ),
          ],
        ),
      ),
      // Adding the floating action button for creating a task
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed('/create-task'); // Navigate to the create task screen
        },
        backgroundColor: globalThemeColor.shade700,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      bottomNavigationBar: const CreateBottomNavigationBar(),
    );
  }
}
