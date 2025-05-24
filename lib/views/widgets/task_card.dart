import 'package:flutter/material.dart';
import 'package:task_master/models/task.dart';
import 'package:task_master/models/category.dart';
import 'package:task_master/models/enums/task_status.dart'; // NOVO IMPORT

class TaskCard extends StatelessWidget {
  final Task task;

  const TaskCard({
    super.key,
    required this.task,
  });

  Color _getCardColor(TaskStatus status) {
    switch (status) {
      case TaskStatus.completed:
        return const Color(0xFF5EAC24); // Verde para cumpridas
      case TaskStatus.missed:
        return const Color(0xFF931621); // Vermelho para não cumpridas
      case TaskStatus.pending:
      default:
        return const Color(0xFFB2B09B); // Cinza claro para pendentes (não aconteceram)
    }
  }

  @override
  Widget build(BuildContext context) {
    final Category taskCategory = task.type;
    final Color cardColor = _getCardColor(task.status); // Usa a função para definir a cor

    return Card(
      color: cardColor, // Usa a cor baseada no status
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8.0), // Adicione um margin para espaçamento entre os cards
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
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                // Ícone com a cor da categoria (suave)
                color: taskCategory.color.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              // Ícone com a cor da categoria
              child: Icon(taskCategory.icon, color: taskCategory.color, size: 30),
            ),
          ],
        ),
      ),
    );
  }
}