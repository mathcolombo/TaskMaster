import 'package:flutter/material.dart';

enum TaskType {
  gym,       // Academia
  work,      // Trabalho / Estudo
  meeting,   // Reunião
  shopping,  // Compras
  social,    // Social / Lazer
  other,     // Outro
}

// Extension to easily get icon and color for a TaskType
extension TaskTypeExtension on TaskType {
  IconData get icon {
    switch (this) {
      case TaskType.gym:
        return Icons.fitness_center;
      case TaskType.work:
        return Icons.work;
      case TaskType.meeting:
        return Icons.people;
      case TaskType.shopping:
        return Icons.shopping_cart;
      case TaskType.social:
        return Icons.celebration;
      case TaskType.other:
        return Icons.assignment;
    }
  }

  Color get cardColor {
    switch (this) {
      case TaskType.gym:
        return Colors.green[400]!;
      case TaskType.work:
        return Colors.blue[400]!;
      case TaskType.meeting:
        return Colors.purple[400]!;
      case TaskType.shopping:
        return Colors.orange[400]!;
      case TaskType.social:
        return Colors.pink[400]!;
      case TaskType.other:
        return Colors.grey[400]!;
    }
  }

  Color get iconContainerColor {
    switch (this) {
      case TaskType.gym:
        return Colors.green[700]!;
      case TaskType.work:
        return Colors.blue[700]!;
      case TaskType.meeting:
        return Colors.purple[700]!;
      case TaskType.shopping:
        return Colors.orange[700]!;
      case TaskType.social:
        return Colors.pink[700]!;
      case TaskType.other:
        return Colors.grey[700]!;
    }
  }
}