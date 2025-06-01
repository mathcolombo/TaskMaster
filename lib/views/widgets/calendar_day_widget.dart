import 'package:flutter/material.dart';
import 'package:task_master/models/calendar_day_summary.dart';

class CalendarDayWidget extends StatelessWidget {
  
  final CalendarDaySummary daySummary;

  const CalendarDayWidget({
    super.key,
    required this.daySummary,
  });

  String _getTodayWeekdayShortName() {
    final weekdays = ['Dom', 'Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb'];
    return weekdays[DateTime.now().weekday % 7];
  }

  @override
  Widget build(BuildContext context) {
    final DateTime today = DateTime.now();
    final bool isToday = daySummary.day == today.day &&
                         (daySummary.day > 0 && today.month == 5 && today.year == 2025);
    final Color cardBackgroundColor = Colors.grey.withOpacity(0.1);
    final Color textColor = Colors.black87;

    return Container(
      decoration: BoxDecoration(
        color: cardBackgroundColor,
        borderRadius: BorderRadius.circular(15.0),
        border: isToday ? Border.all(color: Colors.blue.shade300, width: 2) : null,
      ),
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 2.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            daySummary.weekday,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          Text(
            daySummary.day == 0 ? '' : daySummary.day.toString(),
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: daySummary.hasTasks.map((hasTask) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.5),
                child: Container(
                  width: 4,
                  height: 4,
                  decoration: BoxDecoration(
                    color: hasTask ? Colors.blue.shade600 : Colors.transparent,
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