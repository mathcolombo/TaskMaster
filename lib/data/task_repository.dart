import 'package:flutter/material.dart';
import 'package:task_master/models/enums/task_status.dart';
import 'package:task_master/models/task.dart';
import 'package:task_master/data/mock_items.dart';

class TaskRepository {
  
  static final TaskRepository _instance = TaskRepository._internal();

  factory TaskRepository() {
    return _instance;
  }

  TaskRepository._internal();

  final ValueNotifier<List<Task>> _tasks = ValueNotifier<List<Task>>(List.from(mockTasks));

  ValueNotifier<List<Task>> get tasksNotifier => _tasks;
  List<Task> get allTasks => _tasks.value;

  void addTask(Task newTask) {
    _tasks.value = [..._tasks.value, newTask];
  }

  void toggleTaskStatus(Task task) {
    final updatedTasks = _tasks.value.map((t) {
      if (t.id == task.id) {
        return task.copyWith(
            status: t.status == TaskStatus.completed
                ? TaskStatus.pending
                : TaskStatus.completed);
      }
      return t;
    }).toList();
    _tasks.value = updatedTasks;
  }

  void markTaskAsMissed(Task task) {
    final updatedTasks = _tasks.value.map((t) {
      if (t.id == task.id) {
        return task.copyWith(status: TaskStatus.missed);
      }
      return t;
    }).toList();
    _tasks.value = updatedTasks;
  }

  void removeTask(Task task) {
    _tasks.value = _tasks.value.where((t) => t.id != task.id).toList();
  }
}