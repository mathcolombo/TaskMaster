import 'package:flutter/material.dart';
import 'package:task_master/models/calendar_day_summary.dart';
import 'package:task_master/views/widgets/bottom_navigation_bar_custom.dart';
import 'package:task_master/views/widgets/calendar_day_widget.dart';
import 'package:task_master/views/widgets/calendar_summary_card.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  // NOVO: Método estático para acessar o State da CalendarScreen
  static _CalendarScreenState? of(BuildContext context) {
    return context.findAncestorStateOfType<_CalendarScreenState>();
  }

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  String _currentMonth = 'Maio';
  List<CalendarDaySummary> _calendarDays = [];
  int _selectedIndex = 1; // MUDANÇA: Agora é uma variável de estado, pode ser atualizada

  // NOVO: Método para atualizar o índice selecionado
  void updateSelectedIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadCalendarData();
  }

  void _loadCalendarData() {
    setState(() {
      _calendarDays = [];

      int firstDayOfMonthWeekday = 3;
      int daysInMonth = 31;

      for (int i = 0; i < firstDayOfMonthWeekday; i++) {
        _calendarDays.add(CalendarDaySummary(day: 0, weekday: '', hasTasks: []));
      }

      for (int i = 1; i <= daysInMonth; i++) {
        List<bool> tasksForDay = [];
        if (i % 3 == 0) tasksForDay.add(true);
        if (i % 5 == 0) tasksForDay.add(true);
        if (i % 7 == 0) tasksForDay.add(true);
        if (i % 2 == 0) tasksForDay.add(true);

        _calendarDays.add(
          CalendarDaySummary(
            day: i,
            weekday: _getWeekdayShortName(i + firstDayOfMonthWeekday - 1),
            hasTasks: tasksForDay,
          ),
        );
      }
    });
  }

  String _getWeekdayShortName(int dayIndex) {
    final weekdays = ['Dom', 'Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb'];
    return weekdays[dayIndex % 7];
  }

  @override
  Widget build(BuildContext context) {
    // Estas variáveis de debug podem ser removidas no código final
    // final mediaQuery = MediaQuery.of(context);
    // final screenHeight = mediaQuery.size.height;
    // final appBarHeight = AppBar().preferredSize.height;
    // final bottomBarHeight = kBottomNavigationBarHeight + 20.0;
    // debugPrint('Screen Height: $screenHeight');
    // debugPrint('AppBar Height: $appBarHeight');
    // debugPrint('Bottom Bar Height: $bottomBarHeight');


    return Scaffold(
      backgroundColor: const Color(0xFF2E2E3E),
      extendBody: true,
      appBar: AppBar(
        title: const Text(
          'Calendário',
          style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
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
                  color: Colors.white,
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
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
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

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CalendarSummaryCard(
                    icon: Icons.close,
                    color: Colors.red[400]!,
                    value: 6,
                    isTotal: false,
                  ),
                  CalendarSummaryCard(
                    icon: Icons.check,
                    color: Colors.green[400]!,
                    value: 15,
                    isTotal: false,
                  ),
                  CalendarSummaryCard(
                    icon: Icons.circle,
                    color: Colors.orange[400]!,
                    value: 10,
                    isTotal: false,
                  ),
                  CalendarSummaryCard(
                    icon: Icons.numbers,
                    color: const Color(0xFF6B8A9E),
                    value: 31,
                    isTotal: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            // Adicione um padding inferior para evitar que o conteúdo fique atrás da barra de navegação
            SizedBox(height: kBottomNavigationBarHeight + 20.0), // Ajuste conforme o padding da sua bottom bar
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: BottomNavigationBarCustom(
          onItemTap: BottomNavigationBarCustom.navigate, // Passa a função estática de navegação
          selectedIndex: _selectedIndex,
        ),
      ),
    );
  }
}