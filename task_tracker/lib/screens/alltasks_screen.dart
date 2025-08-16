import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../widgets/themenotifier.dart';
import '../widgets/section_header.dart';
import '../widgets/nav_bar.dart';
import 'task_screen.dart';
import '../task_provider.dart'; // Import your TaskProvider
import '../models/task_model.dart'; // Import your Task model

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final globalThemeColor = Provider.of<ThemeNotifier>(context).themeColor;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [globalThemeColor.shade700, globalThemeColor.shade100],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: const _CustomAppBar(),
        bottomNavigationBar: const CreateBottomNavigationBar(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _WelcomeSection(),
              GestureDetector(
                onTap: () {
                  HapticFeedback.lightImpact();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const TaskScreen()),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    style: TextStyle(color: globalThemeColor),
                    decoration: InputDecoration(
                      isDense: true,
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Search Tasks',
                      hintStyle: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: globalThemeColor),
                      prefixIcon: Icon(
                        Icons.search_rounded,
                        color: globalThemeColor,
                        size: 25,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    enabled: false, // Disable to make it act like a button
                  ),
                ),
              ),
              const _TaskCategories(), // Show upcoming tasks
            ],
          ),
        ),
      ),
    );
  }
}

class _WelcomeSection extends StatelessWidget {
  const _WelcomeSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Welcome!', style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: 3),
          Text(
            'Track Your Tasks Efficiently',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _CustomAppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.grid_view_rounded),
        onPressed: () {
          HapticFeedback.mediumImpact();
        },
      ),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 20),
          child: const Icon(
            Icons.settings,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}

class _TaskCategories extends StatelessWidget {
  const _TaskCategories();

  @override
  Widget build(BuildContext context) {
    // Accessing the TaskProvider to get the upcoming tasks
    final taskProvider = Provider.of<TaskProvider>(context);
    final upcomingTasks = taskProvider.tasks.where((task) {
      // Filter tasks that are due within 24 hours and not completed
      return !task.isCompleted &&
          task.endDate.isBefore(DateTime.now().add(Duration(hours: 24)));
    }).toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: const SectionHeader(title: 'Tasks Due Within 24 Hours'),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.21,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: upcomingTasks.length,
            itemBuilder: (context, index) {
              final task = upcomingTasks[index];
              return CategoryCard(task: task); // Pass the task to CategoryCard
            },
          ),
        ),
      ],
    );
  }
}

class CategoryCard extends StatelessWidget {
  final Task task; // Receive the task object

  const CategoryCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      width: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color.fromARGB(255, 76, 158, 224)
            .withOpacity(0.5), // Updated box color
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              task.name,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              'Due: ${task.endDate.toLocal().toString().split(' ')[0]}', // Display due date
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
