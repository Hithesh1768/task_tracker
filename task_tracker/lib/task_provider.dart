// lib/task_provider.dart
import 'package:flutter/material.dart';
import 'models/task_model.dart'; // Import the Task model

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];

  // Get all tasks
  List<Task> get tasks => _tasks;

  // Get only the ongoing tasks (currently active)
  List<Task> get ongoingTasks =>
      _tasks.where((task) => !task.isCompleted && isTaskOngoing(task)).toList();

  // Get only the completed tasks
  List<Task> get completedTasks =>
      _tasks.where((task) => task.isCompleted).toList();

  // Get overdue tasks (tasks with a past due date that are not completed)
  List<Task> get overdueTasks => _tasks
      .where(
          (task) => !task.isCompleted && DateTime.now().isAfter(task.endDate))
      .toList();

  // Get upcoming tasks (tasks that haven't started yet)
  List<Task> get upcomingTasks => _tasks
      .where((task) => !task.isCompleted && isTaskUpcoming(task))
      .toList();

  // Check if a task is ongoing
  bool isTaskOngoing(Task task) {
    return !task.isCompleted &&
        DateTime.now().isAfter(task.startDate) &&
        DateTime.now().isBefore(task.endDate);
  }

  // Check if a task is upcoming
  bool isTaskUpcoming(Task task) {
    return task.startDate.isAfter(DateTime.now());
  }

  // Add a new task
  void addTask(Task task) {
    _tasks.add(task);
    notifyListeners(); // Notify listeners about the changes
  }

  // Mark a task as completed or move it to overdue if the time has passed
  void toggleTaskCompletion(Task task) {
    // Only mark as completed if the task is checked
    task.isCompleted = !task.isCompleted; // Toggle the completion state
    notifyListeners(); // Notify listeners about the changes
  }

  // Update task status based on time
  void updateTaskStatus() {
    for (var task in _tasks) {
      if (!task.isCompleted && isTaskOverdue(task)) {
        task.isCompleted = false; // Keep it as ongoing if not completed
      }
    }
    notifyListeners(); // Notify listeners about the changes
  }

  // Check if a task is overdue
  bool isTaskOverdue(Task task) {
    return task.endDate.isBefore(DateTime.now()) && !task.isCompleted;
  }

  // Remove a task
  void removeTask(Task task) {
    _tasks.remove(task);
    notifyListeners(); // Notify listeners about the changes
  }
}
