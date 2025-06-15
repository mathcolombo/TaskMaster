import 'package:flutter/material.dart';
import 'package:task_master/models/calendar_day_summary.dart';
import 'package:task_master/models/enums/task_status.dart'; // Import your TaskStatus enum

class CalendarDayWidget extends StatelessWidget {
  final CalendarDaySummary daySummary;

  const CalendarDayWidget({
    super.key,
    required this.daySummary,
  });

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();

    final bool isToday = daySummary.day == now.day &&
        now.month == DateTime.now().month && 
        now.year == DateTime.now().year;

    final Color cardBackgroundColor = Colors.grey.withOpacity(0.1);
    final Color textColor = Colors.black87;

    return Container(
      decoration: BoxDecoration(
        color: cardBackgroundColor,
        borderRadius: BorderRadius.circular(15.0),
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
            children: daySummary.tasks.map((task) {
              Color dotColor;
              final List<String> timeParts = task.time.split('h')[0].split(':');
              final int hour = int.tryParse(timeParts[0]) ?? 0;
              final int minute = int.tryParse(timeParts[1]) ?? 0;

              final DateTime fullTaskDateTime = DateTime(
                task.date.year,
                task.date.month,
                task.date.day,
                hour,
                minute,
              );

              if (task.status == TaskStatus.completed) {
                dotColor = const Color(0xFF5EAC24);
              } else if (task.status == TaskStatus.missed) {
                dotColor = const Color(0xFF931621);
              } else {
                if (fullTaskDateTime.isBefore(now)) {
                  dotColor = const Color(0xFF931621);
                } else {
                  dotColor = const Color(0xFFB2B09B);
                }
              }

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.5),
                child: Container(
                  width: 4,
                  height: 4,
                  decoration: BoxDecoration(
                    color: dotColor,
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