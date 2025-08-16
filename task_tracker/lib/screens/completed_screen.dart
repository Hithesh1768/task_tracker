import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_tracker/task_provider.dart';
import 'package:task_tracker/widgets/gradient_background.dart'; // Import the GradientBackground widget

class CompletedTasksScreen extends StatelessWidget {
  const CompletedTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    final completedTasks = taskProvider.completedTasks;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'Completed Tasks',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: GradientBackground(
        child: Padding(
          padding: const EdgeInsets.only(top: 100.0),
          child: ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: completedTasks.length,
            itemBuilder: (context, index) {
              final task = completedTasks[index];

              return Container(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 76, 158, 224)
                      .withOpacity(0.5), // Box color
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3), // Soft shadow
                      blurRadius: 8.0,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ListTile(
                  title: Text(
                    task.name,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  subtitle: Text(task.description),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
