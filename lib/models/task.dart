// lib/models/task.dart
// Mantenha este arquivo EXATAMENTE como você me enviou na última vez.
// A correção está na classe Category.

import 'package:task_master/models/category.dart';
import 'package:task_master/models/enums/task_status.dart';

class Task {
  final String title;
  final String description;
  final String location;
  final String time;
  final Category type;
  final TaskStatus status;

  Task({
    required this.title,
    this.description = '',
    required this.location,
    required this.time,
    required this.type,
    this.status = TaskStatus.pending,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'location': location,
      'time': time,
      'type': type.toJson(), // Agora Category.toJson() existe!
      'status': status.name,
    };
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      title: json['title'],
      description: json['description'] ?? '',
      location: json['location'],
      time: json['time'],
      type: Category.fromJson(json['type']), // Agora Category.fromJson() existe!
      status: TaskStatus.values.firstWhere((e) => e.name == json['status']),
    );
  }

  Task copyWith({
    String? title,
    String? description,
    String? location,
    String? time,
    Category? type,
    TaskStatus? status,
  }) {
    return Task(
      title: title ?? this.title,
      description: description ?? this.description,
      location: location ?? this.location,
      time: time ?? this.time,
      type: type ?? this.type,
      status: status ?? this.status,
    );
  }
}