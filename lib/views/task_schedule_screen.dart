import 'package:flutter/material.dart';
import 'package:task_master/models/enums/task_status.dart';
import 'package:task_master/models/task.dart';
import 'package:task_master/views/create_task_screen.dart';
import 'package:task_master/views/widgets/bottom_navigation_bar_custom.dart';
import 'package:intl/intl.dart';
import 'package:task_master/views/widgets/task_card.dart';
import 'package:task_master/data/task_repository.dart';

class TaskScheduleScreen extends StatefulWidget {
  const TaskScheduleScreen({super.key});

  @override
  State<TaskScheduleScreen> createState() => _TaskScheduleScreenState();
}

class _TaskScheduleScreenState extends State<TaskScheduleScreen> {

  int _selectedIndex = 0;
  bool _isCalendarExpanded = false;
  List<DateTime> _weekDates = [];

  DateTime _selectedDay = DateTime.now();

  final TaskRepository _taskRepository = TaskRepository();

  @override
  void initState() {
    super.initState();
    _setWeekDates(DateTime.now());
  }

  void _setWeekDates(DateTime referenceDate) {
    _weekDates.clear();
    int daysToSubtract = referenceDate.weekday == DateTime.sunday ? 6 : referenceDate.weekday - 1;
    DateTime startOfWeek = DateTime(referenceDate.year, referenceDate.month, referenceDate.day).subtract(Duration(days: daysToSubtract));

    for (int i = 0; i < 7; i++) {
      _weekDates.add(startOfWeek.add(Duration(days: i)));
    }
  }

  void _toggleCalendarExpansion() {
    setState(() {
      _isCalendarExpanded = !_isCalendarExpanded;
    });
  }

  TimeOfDay _parseTimeOfDay(String timeString) {
    final String cleanedString = timeString.replaceAll('h', '');
    final List<String> parts = cleanedString.split(':');
    if (parts.length != 2) {
      debugPrint('Erro: Formato de hora inválido para _parseTimeOfDay: $timeString');
      return TimeOfDay.now();
    }
    final int hour = int.parse(parts[0]);
    final int minute = int.parse(parts[1]);
    return TimeOfDay(hour: hour, minute: minute);
  }

  void _navigateAndCreateTask() async {
    final newTask = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CreateTaskScreen()),
    );

    if (newTask != null && newTask is Task) {
      _taskRepository.addTask(newTask);
    }
  }

  void _toggleTaskStatus(Task task) {
    _taskRepository.toggleTaskStatus(task);
  }

  void _markTaskAsMissed(Task task) {
    _taskRepository.markTaskAsMissed(task);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: GestureDetector(
          onTap: _toggleCalendarExpansion,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                DateFormat('dd \'de\' MMMM', 'pt_BR').format(_selectedDay),
                style: const TextStyle(color: Colors.black87, fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Icon(
                _isCalendarExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                color: Colors.black87,
              ),
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: ValueListenableBuilder<List<Task>>(
        valueListenable: _taskRepository.tasksNotifier,
        builder: (context, currentTasks, child) {
          final List<Task> tasksForSelectedDay = currentTasks.where((task) {
            return task.date.year == _selectedDay.year &&
                   task.date.month == _selectedDay.month &&
                   task.date.day == _selectedDay.day;
          }).toList();

          tasksForSelectedDay.sort((a, b) {
            final TimeOfDay startTimeA = _parseTimeOfDay(a.time.split(' - ')[0]);
            final TimeOfDay startTimeB = _parseTimeOfDay(b.time.split(' - ')[0]);

            final DateTime fullTimeA = DateTime(a.date.year, a.date.month, a.date.day, startTimeA.hour, startTimeA.minute);
            final DateTime fullTimeB = DateTime(b.date.year, b.date.month, b.date.day, startTimeB.hour, startTimeB.minute);

            return fullTimeA.compareTo(fullTimeB);
          });

          return Column(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: _isCalendarExpanded ? 100 : 0,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _weekDates.map((date) => _buildDayCard(date, currentTasks)).toList(),
                  ),
                ),
              ),
              Expanded(
                child: tasksForSelectedDay.isEmpty
                    ? const Center(
                        child: Text(
                          'Nenhuma tarefa para este dia.',
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(16.0),
                        itemCount: tasksForSelectedDay.length,
                        itemBuilder: (context, index) {
                          final task = tasksForSelectedDay[index];
                          return TaskCard(
                            task: task,
                            onToggleStatus: _toggleTaskStatus,
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: BottomNavigationBarCustom(
          onItemTap: (index, ctx) {
            if (index == 2) {
              _navigateAndCreateTask();
            } else {
              BottomNavigationBarCustom.navigate(index, ctx);
            }
          },
          selectedIndex: _selectedIndex,
        ),
      ),
    );
  }

  Widget _buildDayCard(DateTime date, List<Task> currentTasks) {
    final bool isSelected = date.year == _selectedDay.year &&
                            date.month == _selectedDay.month &&
                            date.day == _selectedDay.day;

    final String weekday = DateFormat('EEE', 'pt_BR').format(date);
    final String dayNumber = DateFormat('dd').format(date);

    final List<Task> tasksForDayDots = currentTasks.where((task) =>
        task.date.year == date.year &&
        task.date.month == date.month &&
        task.date.day == date.day
    ).toList();

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedDay = date;
        });
      },
      child: Container(
        width: 70,
        margin: const EdgeInsets.symmetric(horizontal: 4.0),
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF5F6F52) : const Color(0xFF6B8A9E),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              weekday,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.white70,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              dayNumber,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: tasksForDayDots.map((task) {
                Color dotColor;
                final DateTime now = DateTime.now();

                final List<String> timeRangeParts = task.time.split(' - ');
                final String startTimeString = timeRangeParts[0];
                final TimeOfDay startTime = _parseTimeOfDay(startTimeString);

                final DateTime fullTaskStartDateTime = DateTime(
                  task.date.year,
                  task.date.month,
                  task.date.day,
                  startTime.hour,
                  startTime.minute,
                );

                if (task.status == TaskStatus.completed) {
                  dotColor = const Color(0xFF5EAC24);
                } else if (task.status == TaskStatus.missed) {
                  dotColor = const Color(0xFF931621);
                } else {
                  if (fullTaskStartDateTime.isBefore(now)) {
                    dotColor = const Color(0xFF931621);
                  } else {
                    dotColor = const Color(0xFFB2B09B);
                  }
                }

                return Container(
                  width: 5,
                  height: 5,
                  margin: const EdgeInsets.symmetric(horizontal: 1.5),
                  decoration: BoxDecoration(
                    color: dotColor,
                    shape: BoxShape.circle,
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}