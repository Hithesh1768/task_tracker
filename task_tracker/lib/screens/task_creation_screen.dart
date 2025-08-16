// lib/screens/task_creation_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart'; // Import for date and time formatting
import 'package:task_tracker/task_provider.dart';
import 'package:task_tracker/widgets/nav_bar.dart';
import 'package:task_tracker/widgets/themenotifier.dart';
import 'package:task_tracker/models/task_model.dart'; // Import Task model

class TaskCreationScreen extends StatefulWidget {
  const TaskCreationScreen({super.key});

  @override
  _TaskCreationScreenState createState() => _TaskCreationScreenState();
}

class _TaskCreationScreenState extends State<TaskCreationScreen> {
  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController taskDescriptionController =
      TextEditingController();

  DateTime? _startDate;
  DateTime? _endDate;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;

  // Function to select date
  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  // Function to select time
  Future<void> _selectTime(BuildContext context, bool isStartTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        if (isStartTime) {
          _startTime = picked;
        } else {
          _endTime = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Access the global theme color using Provider
    final globalThemeColor = Provider.of<ThemeNotifier>(context).themeColor;
    final taskProvider = Provider.of<TaskProvider>(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Create Task',
          style: TextStyle(fontWeight: FontWeight.bold), // Bold text
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Go back to Task Screen
          },
        ),
      ),
      body: Container(
        height: double.infinity, // Extend the container to fill the screen
        decoration: BoxDecoration(
          // Same gradient background as other screens
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              globalThemeColor.shade700, // Primary shade
              globalThemeColor.shade400, // Lighter shade for gradient
              globalThemeColor.shade100, // Lightest shade for bottom
            ],
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                        height: 80), // Create some space from the top
                    TextField(
                      controller: taskNameController,
                      decoration: InputDecoration(
                        labelText: 'Task Name',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextField(
                      controller: taskDescriptionController,
                      maxLines: 4,
                      decoration: InputDecoration(
                        labelText: 'Task Description',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),

                    // Start Date and Time
                    ListTile(
                      title: const Text(
                        "Start Date",
                        style:
                            TextStyle(fontWeight: FontWeight.bold), // Bold text
                      ),
                      subtitle: Text(
                        _startDate != null
                            ? DateFormat('yyyy-MM-dd').format(_startDate!)
                            : 'Select Start Date',
                        style: const TextStyle(color: Colors.black),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.calendar_today),
                        onPressed: () => _selectDate(context, true),
                      ),
                    ),
                    ListTile(
                      title: const Text(
                        "Start Time",
                        style:
                            TextStyle(fontWeight: FontWeight.bold), // Bold text
                      ),
                      subtitle: Text(
                        _startTime != null
                            ? _startTime!.format(context)
                            : 'Select Start Time',
                        style: const TextStyle(color: Colors.black),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.access_time),
                        onPressed: () => _selectTime(context, true),
                      ),
                    ),

                    // End Date and Time
                    ListTile(
                      title: const Text(
                        "End Date",
                        style:
                            TextStyle(fontWeight: FontWeight.bold), // Bold text
                      ),
                      subtitle: Text(
                        _endDate != null
                            ? DateFormat('yyyy-MM-dd').format(_endDate!)
                            : 'Select End Date',
                        style: const TextStyle(color: Colors.black),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.calendar_today),
                        onPressed: () => _selectDate(context, false),
                      ),
                    ),
                    ListTile(
                      title: const Text(
                        "End Time",
                        style:
                            TextStyle(fontWeight: FontWeight.bold), // Bold text
                      ),
                      subtitle: Text(
                        _endTime != null
                            ? _endTime!.format(context)
                            : 'Select End Time',
                        style: const TextStyle(color: Colors.black),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.access_time),
                        onPressed: () => _selectTime(context, false),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // "Create Task" Button with some padding from bottom
            Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: ElevatedButton(
                onPressed: () {
                  if (taskNameController.text.isNotEmpty &&
                      _startDate != null &&
                      _startTime != null &&
                      _endDate != null &&
                      _endTime != null) {
                    // Create a new task
                    final newTask = Task(
                      name: taskNameController.text,
                      description: taskDescriptionController.text,
                      startDate: _startDate!,
                      startTime: _startTime!,
                      endDate: _endDate!,
                      endTime: _endTime!,
                    );

                    // Add task to provider
                    final taskProvider =
                        Provider.of<TaskProvider>(context, listen: false);
                    taskProvider.addTask(newTask);

                    Navigator.pop(context); // Go back after task creation
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please fill all fields')),
                    );
                  }
                },
                child: const Text('Create Task'),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CreateBottomNavigationBar(),
    );
  }
}
