import 'package:flutter/material.dart';
import 'package:task_tracker/models/task_model.dart'; // Import Task model
import 'package:task_tracker/screens/taskview_screen.dart';

class TaskCard extends StatelessWidget {
  final Task task;

  const TaskCard({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
          vertical: 8.0), // Margin between containers
      padding: const EdgeInsets.all(16.0), // Padding inside each container
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 76, 158, 224).withOpacity(0.5), // Box color
        borderRadius: BorderRadius.circular(12.0), // Rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // Soft shadow
            blurRadius: 8.0,
            offset: const Offset(0, 4), // Slight shadow offset
          ),
        ],
      ),
      child: ListTile(
        title: Text(
          task.name,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        subtitle: Text(
          task.description,
          style: const TextStyle(color: Colors.white70), // Subtitle color
        ),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TaskViewScreen(task: task),
            ),
          );
        },
      ),
    );
  }
}
