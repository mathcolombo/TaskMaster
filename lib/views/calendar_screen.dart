import 'package:flutter/material.dart';
import 'package:task_master/models/calendar_day_summary.dart';
import 'package:task_master/views/widgets/bottom_navigation_bar_custom.dart';
import 'package:task_master/views/widgets/calendar_day_widget.dart';
import 'package:task_master/views/widgets/calendar_summary_card.dart';
import 'package:task_master/models/task.dart';
import 'package:task_master/models/enums/task_status.dart';
import 'package:task_master/data/task_repository.dart';
import 'package:intl/intl.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  static _CalendarScreenState? of(BuildContext context) {
    return context.findAncestorStateOfType<_CalendarScreenState>();
  }

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  String _currentMonth = '';
  List<CalendarDaySummary> _calendarDays = [];
  int _selectedIndex = 1;

  int _redTasksCount = 0;
  int _greenTasksCount = 0;
  int _greyTasksCount = 0;
  int _totalTasksCount = 0;

  final TaskRepository _taskRepository = TaskRepository();

  @override
  void initState() {
    super.initState();
    _taskRepository.tasksNotifier.addListener(_onTasksChanged);
    _loadCalendarData();
  }

  @override
  void dispose() {
    _taskRepository.tasksNotifier.removeListener(_onTasksChanged);
    super.dispose();
  }

  void _onTasksChanged() {
    _loadCalendarData();
  }

  void _loadCalendarData() {
    final DateTime now = DateTime.now();
    final DateTime firstDayOfMonth = DateTime(now.year, now.month, 1);
    final int daysInMonth = DateTime(now.year, now.month + 1, 0).day;
    final int firstDayOfMonthWeekday = firstDayOfMonth.weekday % 7;

    final List<Task> allTasks = _taskRepository.allTasks;
    final List<Task> tasksForCurrentMonth = allTasks.where((task) {
      return task.date.year == now.year && task.date.month == now.month;
    }).toList();

    setState(() {
      _currentMonth = DateFormat('MMMM y', 'pt_BR').format(now);
      _calendarDays = [];
      _redTasksCount = 0;
      _greenTasksCount = 0;
      _greyTasksCount = 0;
      _totalTasksCount = 0;

      for (int i = 0; i < firstDayOfMonthWeekday; i++) {
        _calendarDays.add(CalendarDaySummary(day: 0, weekday: '', tasks: []));
      }

      for (int i = 1; i <= daysInMonth; i++) {
        final DateTime dayDate = DateTime(now.year, now.month, i);
        final List<Task> tasksForDay = tasksForCurrentMonth.where((task) {
          return task.date.day == i;
        }).toList();

        _calendarDays.add(
          CalendarDaySummary(
            day: i,
            weekday: _getWeekdayShortName(dayDate.weekday),
            tasks: tasksForDay,
          ),
        );
        _updateTaskCounts(tasksForDay, now);
      }
    });
  }

  String _getWeekdayShortName(int weekday) {
    final weekdays = ['Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb', 'Dom'];
    return weekdays[weekday - 1];
  }

  void _updateTaskCounts(List<Task> tasks, DateTime currentTime) {
    for (var task in tasks) {
      _totalTasksCount++;

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
        _greenTasksCount++;
      } else if (task.status == TaskStatus.missed) {
        _redTasksCount++;
      } else {
        if (fullTaskDateTime.isBefore(currentTime)) {
          _redTasksCount++;
        } else {
          _greyTasksCount++;
        }
      }
    }
  }

  void updateSelectedIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      appBar: AppBar(
        title: const Text(
          'Calendário',
          style: TextStyle(color: Colors.black87, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black54),
            onPressed: () {
              // More options
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                _currentMonth,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: ['Dom', 'Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb']
                    .map((day) => Expanded(
                          child: Text(
                            day,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  crossAxisSpacing: 2.0,
                  mainAxisSpacing: 2.0,
                  childAspectRatio: 1.1,
                ),
                itemCount: _calendarDays.length,
                itemBuilder: (context, index) {
                  final daySummary = _calendarDays[index];
                  if (daySummary.day == 0) {
                    return Container();
                  }
                  return CalendarDayWidget(daySummary: daySummary);
                },
              ),
            ),
            const SizedBox(height: 15),

            // Task Summary Cards
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CalendarSummaryCard(
                    icon: Icons.close,
                    color: Colors.red[400]!,
                    value: _redTasksCount,
                    isTotal: false,
                  ),
                  CalendarSummaryCard(
                    icon: Icons.check,
                    color: Colors.green[400]!,
                    value: _greenTasksCount,
                    isTotal: false,
                  ),
                  CalendarSummaryCard(
                    icon: Icons.circle,
                    color: Colors.grey[600]!,
                    value: _greyTasksCount,
                    isTotal: false,
                  ),
                  CalendarSummaryCard(
                    icon: Icons.numbers,
                    color: const Color(0xFF6B8A9E),
                    value: _totalTasksCount,
                    isTotal: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(height: kBottomNavigationBarHeight + 20.0),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: BottomNavigationBarCustom(
          onItemTap: BottomNavigationBarCustom.navigate,
          selectedIndex: _selectedIndex,
        ),
      ),
    );
  }
}