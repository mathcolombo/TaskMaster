import 'package:flutter/material.dart'; // Import para usar Color e IconData, mas o modelo é puro

class Category {
  final String name;
  final IconData? icon; // Ícone opcional para a categoria
  final Color? color; // Cor opcional para a categoria

  Category({
    required this.name,
    this.icon,
    this.color,
  });

  // Exemplo de como criar a partir de um JSON (se você fosse carregar categorias dinamicamente)
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      name: json['name'] as String,
      // IconData e Color precisariam de uma lógica de serialização/deserialização mais complexa
      // ou seriam mapeados para strings/hex codes. Para este exemplo, manteremos simples.
    );
  }

  // Exemplo de como converter para JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      // 'icon': icon?.codePoint, // Exemplo de serialização de IconData
      // 'color': color?.value,   // Exemplo de serialização de Color
    };
  }
}