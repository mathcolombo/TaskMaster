import 'package:flutter/material.dart';
import 'package:task_master/models/category.dart';

class CategoryChip extends StatelessWidget {
  final Category category;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryChip({
    super.key,
    required this.category,
    this.isSelected = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          // CORRIGIDO: Usar category.color diretamente, sem o '??'
          color: isSelected
              ? category.color // A cor da categoria para o fundo do chip selecionado
              : Colors.white.withOpacity(0.1), // Cor padrão se não selecionado
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // CORRIGIDO: Usar category.icon diretamente, sem o 'if (category.icon != null)'
            Icon(category.icon, color: Colors.white, size: 18), // A cor do ícone é sempre branca aqui
            const SizedBox(width: 8),
            Text(
              category.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}