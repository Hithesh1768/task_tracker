import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:task_tracker/screens/home_screen.dart';
import 'package:task_tracker/widgets/nav_bar.dart';
import 'package:task_tracker/widgets/nav_controller.dart';
import 'package:task_tracker/widgets/themenotifier.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final NavController navController = Get.put(NavController());
    final globalThemeColor = Provider.of<ThemeNotifier>(context).themeColor;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20, // Optional: Set font size
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.offAll(const HomeScreen()); // Navigate back to the Home screen
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue.shade700,
              Colors.blue.shade100
            ], // Adjust colors as needed
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundImage:
                    AssetImage('assets/profile.png'), // Placeholder
              ),
              const SizedBox(height: 20),
              const Text('Username', style: TextStyle(fontSize: 24)),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  // Add edit profile functionality
                },
                child: const Text('Edit Profile'),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar:
          CreateBottomNavigationBar(), // Ensure this is defined in your project
    );
  }
}
