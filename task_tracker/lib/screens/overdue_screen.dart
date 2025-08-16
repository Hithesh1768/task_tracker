import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_tracker/task_provider.dart';
import 'package:task_tracker/widgets/gradient_background.dart';
import 'package:task_tracker/widgets/task_card.dart';

class OverdueTasksScreen extends StatelessWidget {
  const OverdueTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    final overdueTasks = taskProvider.overdueTasks; // Get overdue tasks

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Overdue Tasks',
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: GradientBackground(
        child: Padding(
          padding: const EdgeInsets.only(top: 100.0, left: 16.0, right: 16.0),
          child: ListView.builder(
            itemCount: overdueTasks.length,
            itemBuilder: (context, index) {
              final task = overdueTasks[index];
              return TaskCard(task: task); // Use TaskCard widget
            },
          ),
        ),
      ),
    );
  }
}
