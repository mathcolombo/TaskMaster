import 'package:task_master/models/enums/task_type.dart';

class Task {
  final String title;
  final String description;
  final String location;
  final String time;
  final TaskType type;

  Task({
    required this.title,
    this.description = '',
    required this.location,
    required this.time,
    this.type = TaskType.other,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      title: json['title'] as String,
      description: json['description'] as String? ?? '',
      location: json['location'] as String,
      time: json['time'] as String,
      type: TaskType.values.firstWhere(
        (e) => e.toString().split('.').last == json['type'],
        orElse: () => TaskType.other,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'location': location,
      'time': time,
      'type': type.toString().split('.').last,
    };
  }
}