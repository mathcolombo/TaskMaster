import 'package:flutter/material.dart';

class CalendarSummaryCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final int value;
  final bool isTotal; // Para o card "Total" que tem um estilo ligeiramente diferente

  const CalendarSummaryCard({
    super.key,
    required this.icon,
    required this.color,
    required this.value,
    this.isTotal = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 4 - 20, // Divide a tela em 4 colunas com margem
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
      decoration: BoxDecoration(
        color: isTotal ? const Color(0xFF6B8A9E) : Colors.white12, // Cor de fundo (Total vs Outros)
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: isTotal ? 24 : 28), // Ícone
          if (isTotal) // Para o ícone "Total" que tem texto "Total" acima
            const Padding(
              padding: EdgeInsets.only(top: 4.0),
              child: Text(
                'Total',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          Text(
            value.toString().padLeft(2, '0'), // Formata para '06', '15'
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}