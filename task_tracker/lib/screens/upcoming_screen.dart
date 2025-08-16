import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_tracker/task_provider.dart';
import 'package:task_tracker/widgets/gradient_background.dart'; // Import the GradientBackground widget
import 'package:task_tracker/widgets/task_card.dart'; // Import the TaskCard widget

class UpcomingTasksScreen extends StatelessWidget {
  const UpcomingTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    final upcomingTasks = taskProvider.upcomingTasks; // Get upcoming tasks

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Upcoming Tasks',
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: GradientBackground(
        child: Padding(
          padding: const EdgeInsets.only(
              top: 100.0,
              left: 16.0,
              right: 16.0), // Padding at the top and sides
          child: ListView.builder(
            itemCount: upcomingTasks.length,
            itemBuilder: (context, index) {
              final task = upcomingTasks[index];
              return TaskCard(task: task); // Use TaskCard widget
            },
          ),
        ),
      ),
    );
  }
}
