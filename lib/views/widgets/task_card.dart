import 'package:flutter/material.dart';
import 'package:task_master/models/task.dart';
import 'package:task_master/models/category.dart';
import 'package:task_master/models/enums/task_status.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final Function(Task) onToggleStatus;
  final Function(Task)? onRemove;

  const TaskCard({
    super.key,
    required this.task,
    required this.onToggleStatus,
    this.onRemove,
  });

  TimeOfDay _parseTimeOfDay(String timeString) {
    final String cleanedString = timeString.replaceAll('h', '');
    final List<String> parts = cleanedString.split(':');
    if (parts.length != 2) {
      debugPrint('Erro: Formato de hora inválido para _parseTimeOfDay: $timeString');
      return TimeOfDay.now();
    }
    final int hour = int.parse(parts[0]);
    final int minute = int.parse(parts[1]);
    return TimeOfDay(hour: hour, minute: minute);
  }

  Color _getCardColor(Task task) {
    final DateTime now = DateTime.now();
    final DateTime taskDateOnly = DateTime(task.date.year, task.date.month, task.date.day);

    final List<String> timeRangeParts = task.time.split(' - ');
    final String startTimeString = timeRangeParts[0];

    final TimeOfDay startTime = _parseTimeOfDay(startTimeString);

    final DateTime fullTaskStartDateTime = DateTime(
      taskDateOnly.year,
      taskDateOnly.month,
      taskDateOnly.day,
      startTime.hour,
      startTime.minute,
    );

    if (task.status == TaskStatus.completed) {
      return const Color(0xFF5EAC24); // Verde para cumpridas
    } else if (task.status == TaskStatus.missed) {
      return const Color(0xFF931621); // Vermelho se explicitamente marcada como missed
    } else { // task.status == TaskStatus.pending
      if (fullTaskStartDateTime.isBefore(now)) {
        return const Color(0xFF931621); // Vermelho para pendentes atrasadas
      } else {
        return const Color(0xFFB2B09B); // Cinza claro para pendentes futuras
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Category taskCategory = task.type;
    final Color cardColor = _getCardColor(task);

    return Card(
      color: cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: () => onToggleStatus(task),
        onLongPress: () {
          if (onRemove != null) {
            showDialog(
              context: context,
              builder: (BuildContext dialogContext) {
                return AlertDialog(
                  title: const Text('Remover Tarefa'),
                  content: Text('Tem certeza que deseja remover a tarefa "${task.title}"?'),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('Cancelar'),
                      onPressed: () {
                        Navigator.of(dialogContext).pop();
                      },
                    ),
                    TextButton(
                      child: const Text('Remover', style: TextStyle(color: Colors.red)),
                      onPressed: () {
                        onRemove!(task);
                        Navigator.of(dialogContext).pop();
                      },
                    ),
                  ],
                );
              },
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    if (task.description.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          task.description,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white70,
                          ),
                        ),
                      ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.location_on, size: 16, color: Colors.white70),
                        const SizedBox(width: 4),
                        Text(
                          task.location,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.access_time, size: 16, color: Colors.white70),
                        const SizedBox(width: 4),
                        Text(
                          task.time,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Column(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: taskCategory.color.withOpacity(0.3),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(taskCategory.icon, color: taskCategory.color, size: 30),
                  ),
                  if (task.status == TaskStatus.completed)
                    const Icon(Icons.check_circle, color: Colors.white, size: 24)
                  else if (task.status == TaskStatus.pending && !_getCardColor(task).value.toRadixString(16).contains('931621'))
                      const Icon(Icons.radio_button_unchecked, color: Colors.white, size: 24)
                  else if (task.status == TaskStatus.missed || _getCardColor(task).value.toRadixString(16).contains('931621'))
                      const Icon(Icons.cancel, color: Colors.white, size: 24)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}