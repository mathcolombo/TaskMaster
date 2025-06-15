import 'package:task_master/models/task.dart'; // Make sure to import your Task model

class CalendarDaySummary {
  final int day;
  final String weekday;
  final List<Task> tasks;

  CalendarDaySummary({
    required this.day,
    required this.weekday,
    this.tasks = const [],
  });

  factory CalendarDaySummary.fromJson(Map<String, dynamic> json) {
    return CalendarDaySummary(
      day: json['day'] as int,
      weekday: json['weekday'] as String,
      tasks: (json['tasks'] as List?)
              ?.map((e) => Task.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'day': day,
      'weekday': weekday,
      'tasks': tasks.map((task) => task.toJson()).toList(),
    };
  }
}