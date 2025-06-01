import 'package:flutter/material.dart';
import 'package:task_master/views/task_schedule_screen.dart';
import 'package:task_master/views/calendar_screen.dart';
import 'package:task_master/views/notification_screen.dart';
import 'package:task_master/views/create_task_screen.dart';
import 'package:task_master/views/focus_mode_screen.dart';

class BottomNavigationBarCustom extends StatelessWidget {
  
  final void Function(int index, BuildContext context) onItemTap;
  final int selectedIndex;

  const BottomNavigationBarCustom({
    super.key,
    required this.onItemTap,
    this.selectedIndex = 0,
  });

  @override
  Widget build(BuildContext context) {

    final double screenWidth = MediaQuery.of(context).size.width;
    final double desiredWidth = screenWidth * 0.85;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: (screenWidth - desiredWidth) / 2),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(context, 0, Icons.calendar_today, 'Tarefa'),
          _buildNavItem(context, 1, Icons.calendar_month, 'Calendário'),
          _buildAddButton(context),
          _buildNavItem(context, 3, Icons.notifications, 'Notificações'),
          _buildNavItem(context, 4, Icons.power_settings_new, 'Foco'),
        ],
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, int index, IconData icon, String label) {
    final Color iconColor = selectedIndex == index ? Colors.blueAccent : Colors.grey;

    return IconButton(
      icon: Icon(icon, color: iconColor),
      onPressed: () => onItemTap(index, context),
    );
  }

  Widget _buildAddButton(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: const BoxDecoration(
        color: Color(0xff19647E),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: const Icon(Icons.add, color: Colors.white, size: 30),
        onPressed: () => onItemTap(2, context),
      ),
    );
  }

  static void navigate(int index, BuildContext context) async {
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => const TaskScheduleScreen(),
          transitionDuration: Duration.zero,
        ),
      );
    } else if (index == 1) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => const CalendarScreen(),
          transitionDuration: Duration.zero,
        ),
      );
    } else if (index == 2) {
      await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CreateTaskScreen()),
      );
    } else if (index == 3) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => const NotificationScreen(),
          transitionDuration: Duration.zero,
        ),
      );
    } else if (index == 4) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => const FocusModeScreen(),
          transitionDuration: Duration.zero,
        ),
      );
    }
  }
}