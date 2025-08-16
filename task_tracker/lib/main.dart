// lib/main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:task_tracker/screens/alltasks_screen.dart';
import 'package:task_tracker/screens/profile_screen.dart';
import 'package:task_tracker/screens/task_creation_screen.dart';
import 'package:task_tracker/task_provider.dart';
import 'package:task_tracker/widgets/nav_controller.dart';
import 'package:task_tracker/widgets/themenotifier.dart';
import 'screens/home_screen.dart'; // Import your home screen
import 'screens/task_screen.dart'; // Import the task screen
import 'screens/upcoming_screen.dart'; // Import upcoming screen
import 'screens/ongoing_screen.dart'; // Import ongoing screen
import 'screens/completed_screen.dart'; // Import completed screen
import 'screens/overdue_screen.dart'; // Import overdue screen

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeNotifier()),
        ChangeNotifierProvider(
            create: (context) => TaskProvider()), // Add TaskProvider here
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Initialize NavController
    final NavController navController = Get.put(NavController());

    return GetMaterialApp(
      title: 'Task Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false, // Disable debug banner
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const HomeScreen()),
        GetPage(name: '/tasks', page: () => const TaskScreen()),
        GetPage(name: '/upcoming', page: () => const UpcomingTasksScreen()),
        GetPage(name: '/ongoing', page: () => const OngoingTasksScreen()),
        GetPage(name: '/completed', page: () => const CompletedTasksScreen()),
        GetPage(name: '/overdue', page: () => const OverdueTasksScreen()),
        GetPage(name: '/all-tasks', page: () => const AllTasksScreen()),
        GetPage(name: '/create-task', page: () => const TaskCreationScreen()),
        GetPage(name: '/profile', page: () => const ProfileScreen()),
      ],
    );
  }
}
