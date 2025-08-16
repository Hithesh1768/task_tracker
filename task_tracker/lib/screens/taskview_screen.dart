import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date formatting
import '../models/task_model.dart';
import '../widgets/gradient_background.dart'; // Import the GradientBackground widget
import '../task_provider.dart'; // Import TaskProvider
import 'package:provider/provider.dart'; // Import provider package

class TaskViewScreen extends StatelessWidget {
  final Task task;

  const TaskViewScreen({Key? key, required this.task}) : super(key: key);

  // Helper method to format DateTime without time (milliseconds)
  String formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);

    return Scaffold(
      extendBodyBehindAppBar: true, // Extend gradient behind the app bar
      appBar: AppBar(
        title: Text(
          task.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent, // Transparent app bar
        elevation: 0,
      ),
      body: GradientBackground(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Container(
              width: double.infinity, // Full width container
              padding: const EdgeInsets.all(24.0), // Padding inside the box
              decoration: BoxDecoration(
                color:
                    Colors.white.withOpacity(0.3), // Slightly transparent box
                borderRadius: BorderRadius.circular(16.0), // Rounded corners
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 20), // Space from the top

                  // Task Title with Icon
                  Row(
                    children: [
                      const Icon(Icons.task_alt,
                          color: Colors.white, size: 28), // Task icon
                      const SizedBox(width: 8),
                      Text(
                        task.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Task Description with Icon
                  Row(
                    children: [
                      const Icon(Icons.description,
                          color: Colors.white, size: 28), // Description icon
                      const SizedBox(width: 8),
                      Text(
                        'Task Description:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    task.description,
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  const SizedBox(height: 24), // Space between sections

                  // Start Date and Time with Icon
                  Row(
                    children: [
                      const Icon(Icons.calendar_today,
                          color: Colors.white, size: 28), // Start date icon
                      const SizedBox(width: 8),
                      Text(
                        'Start Date & Time:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Date: ${formatDate(task.startDate)}',
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Time: ${task.startTime.format(context)}',
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  const SizedBox(height: 24),

                  // End Date and Time with Icon
                  Row(
                    children: [
                      const Icon(Icons.event,
                          color: Colors.white, size: 28), // End date icon
                      const SizedBox(width: 8),
                      Text(
                        'End Date & Time:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Date: ${formatDate(task.endDate)}',
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Time: ${task.endTime.format(context)}',
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  const SizedBox(height: 24),

                  // Task Status
                  Text(
                    'Status: ${task.isCompleted ? "Completed" : "Not Completed"}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: task.isCompleted ? Colors.green : Colors.red,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Mark as Completed Button
                  if (!task.isCompleted) // Show button only if not completed
                    ElevatedButton(
                      onPressed: () {
                        taskProvider.toggleTaskCompletion(
                            task); // Mark task as completed
                        Navigator.pop(context); // Go back after updating
                      },
                      child: const Text('Mark as Completed'),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
