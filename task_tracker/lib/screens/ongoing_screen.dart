import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../task_provider.dart'; // Import TaskProvider
import '../models/task_model.dart'; // Import Task model
import '../screens/taskview_screen.dart'; // Import TaskViewScreen
import '../widgets/gradient_background.dart'; // Import the GradientBackground widget

class OngoingTasksScreen extends StatelessWidget {
  const OngoingTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    final ongoingTasks = taskProvider.ongoingTasks; // Get ongoing tasks

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'Ongoing Tasks',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent, // Transparent app bar
        elevation: 0,
      ),
      body: GradientBackground(
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Padding around the list
          child: ListView.builder(
            itemCount: ongoingTasks.length,
            itemBuilder: (context, index) {
              final task = ongoingTasks[index];

              return Container(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color:
                      const Color.fromARGB(255, 76, 158, 224).withOpacity(0.5),
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8.0,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ListTile(
                        title: Text(
                          task.name,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                        subtitle: Text(
                          task.description,
                          style: const TextStyle(color: Colors.white),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TaskViewScreen(task: task),
                            ),
                          );
                        },
                      ),
                    ),
                    Checkbox(
                      value: task.isCompleted,
                      onChanged: (bool? value) {
                        if (value != null) {
                          if (value) {
                            // Mark the task as completed
                            taskProvider.toggleTaskCompletion(task);
                          } else {
                            // Optionally, handle unchecking if needed
                            // Currently, we won't allow unchecking
                          }
                        }
                      },
                      activeColor: Colors.green, // Color for checked state
                      // Optional: add an inactive color
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
