// lib/models/task_model.dart
import 'package:flutter/material.dart';

class Task {
  String name;
  String description;
  DateTime startDate;
  TimeOfDay startTime;
  DateTime endDate;
  TimeOfDay endTime;
  bool isCompleted;

  Task({
    required this.name,
    required this.description,
    required this.startDate,
    required this.startTime,
    required this.endDate,
    required this.endTime,
    this.isCompleted = false,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'description': description,
        'startDate': startDate.toIso8601String(),
        'startTime': startTime.hour * 60 + startTime.minute,
        'endDate': endDate.toIso8601String(),
        'endTime': endTime.hour * 60 + endTime.minute,
      };

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      name: json['name'],
      description: json['description'],
      startDate: DateTime.parse(json['startDate']),
      startTime: TimeOfDay(
        hour: json['startTime'] ~/ 60,
        minute: json['startTime'] % 60,
      ),
      endDate: DateTime.parse(json['endDate']),
      endTime: TimeOfDay(
        hour: json['endTime'] ~/ 60,
        minute: json['endTime'] % 60,
      ),
    );
  }
}
