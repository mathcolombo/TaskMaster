import 'package:task_master/models/category.dart';
import 'package:task_master/models/enums/task_status.dart';

class Task {

  final String id;
  final String title;
  final String description;
  final String location;
  final String time; // Formato "HH:mmh - HH:mmh"
  final Category type;
  final DateTime date;
  final TaskStatus status;

  Task({
    required this.id,
    required this.title,
    this.description = '',
    this.location = '',
    required this.time,
    required this.type,
    required this.date,
    this.status = TaskStatus.pending,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      description: json['description'] ?? '',
      location: json['location'] ?? '',
      time: json['time'],
      type: Category.fromJson(json['type']),
      date: DateTime.parse(json['date']),
      status: TaskStatus.values.firstWhere(
        (e) => e.toString() == 'TaskStatus.${json['status']}',
        orElse: () => TaskStatus.pending,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'location': location,
      'time': time,
      'type': type.toJson(),
      'date': date.toIso8601String(),
      'status': status.toString().split('.').last,
    };
  }

  Task copyWith({
    String? id,
    String? title,
    String? description,
    String? location,
    String? time,
    Category? type,
    DateTime? date,
    TaskStatus? status,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      location: location ?? this.location,
      time: time ?? this.time,
      type: type ?? this.type,
      date: date ?? this.date,
      status: status ?? this.status,
    );
  }
}