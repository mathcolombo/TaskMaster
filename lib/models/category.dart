import 'package:flutter/material.dart';

class Category {
  final String id; // Adicione um ID único para cada categoria
  final String name;
  final IconData icon;
  final Color color;

  Category({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
  });

  // Método para obter uma categoria pelo ID (útil para os dados mock)
  static Category? getCategoryById(String id) {
    try {
      return defaultCategories.firstWhere((category) => category.id == id);
    } catch (e) {
      return null; // Retorna null se a categoria não for encontrada
    }
  }

  // Lista de categorias padrão
  static List<Category> defaultCategories = [
    Category(
      id: 'exercise',
      name: 'Exercícios',
      icon: Icons.directions_run,
      color: const Color(0xFF5EAC24), // Verde
    ),
    Category(
      id: 'work',
      name: 'Trabalho',
      icon: Icons.work,
      color: const Color(0xFFE48D00), // Laranja
    ),
    Category(
      id: 'study',
      name: 'Estudo',
      icon: Icons.book,
      color: const Color(0xFF2196F3), // Azul
    ),
    Category(
      id: 'home',
      name: 'Casa',
      icon: Icons.home,
      color: const Color(0xFF795548), // Marrom
    ),
    Category(
      id: 'girlfriend',
      name: 'Namorada',
      icon: Icons.favorite,
      color: const Color(0xFFE91E63), // Rosa
    ),
    Category(
      id: 'other',
      name: 'Outros',
      icon: Icons.more_horiz,
      color: const Color(0xFF607D8B), // Cinza Azulado
    ),
  ];

  // NOVO MÉTODO: toJson para serializar a categoria
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'icon_code_point': icon.codePoint, // Salva o codePoint do ícone
      'color_value': color.value, // Salva o valor inteiro da cor
    };
  }

  // NOVO MÉTODO: fromJson para desserializar a categoria
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      icon: IconData(json['icon_code_point'], fontFamily: 'MaterialIcons'), // Reconstrói o ícone
      color: Color(json['color_value']), // Reconstrói a cor
    );
  }
}