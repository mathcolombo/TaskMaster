import 'package:flutter/material.dart';
import 'package:task_master/models/calendar_day_summary.dart';

class CalendarDayWidget extends StatelessWidget {
  final CalendarDaySummary daySummary;

  const CalendarDayWidget({
    super.key,
    required this.daySummary,
  });

  // Helper para obter o nome curto do dia da semana atual para destaque
  String _getTodayWeekdayShortName() {
    final weekdays = ['Dom', 'Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb'];
    return weekdays[DateTime.now().weekday % 7];
  }

  @override
  Widget build(BuildContext context) {
    final bool isToday = daySummary.day == DateTime.now().day &&
                         daySummary.weekday == _getTodayWeekdayShortName();
    final Color cardBackgroundColor = const Color(0xFF3F3F4D);
    final Color textColor = Colors.white;

    return Container(
      decoration: BoxDecoration(
        color: cardBackgroundColor,
        borderRadius: BorderRadius.circular(15.0),
        border: isToday ? Border.all(color: Colors.lightGreenAccent, width: 2) : null,
      ),
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 2.0), // REDUZIDO O PADDING AQUI
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            daySummary.weekday,
            style: TextStyle(
              fontSize: 10, // REDUZIDO TAMANHO DA FONTE DO DIA DA SEMANA
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          // const SizedBox(height: 2), // REDUZIDO ESPAÇAMENTO
          Text(
            daySummary.day == 0 ? '' : daySummary.day.toString(), // Removido .padLeft(2, '0') se não for estritamente necessário para números de um dígito
            style: TextStyle(
              fontSize: 16, // REDUZIDO TAMANHO DA FONTE DO DIA DO MÊS
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          const Spacer(), // Empurra os pontos para baixo
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: daySummary.hasTasks.map((hasTask) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.5), // REDUZIDO O PADDING HORIZONTAL DOS PONTOS
                child: Container(
                  width: 4, // REDUZIDO TAMANHO DOS PONTOS
                  height: 4, // REDUZIDO TAMANHO DOS PONTOS
                  decoration: BoxDecoration(
                    color: hasTask ? Colors.lightGreenAccent : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}