import 'package:flutter/material.dart';
import 'package:task_master/models/notification_item.dart';
import 'package:task_master/views/widgets/notification_card.dart';
import 'package:task_master/views/widgets/bottom_navigation_bar_custom.dart';
// REMOVIDOS: Imports de TaskScheduleScreen, CalendarScreen, CreateTaskScreen

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<NotificationItem> _notifications = [];
  bool _showUnreadNotifications = true;
  final int _selectedIndex = 3; // Índice da tela de Notificações na barra inferior

  @override
  void initState() {
    super.initState();
    _loadNotifications();
  }

  void _loadNotifications() {
    setState(() {
      _notifications = [
        NotificationItem(
          title: 'Tarefa em 15 minutos',
          message: 'A tarefa "Academia" começa em 15 minutos.\nSe prepare, termine o que está fazendo e toque.',
        ),
        NotificationItem(
          title: 'Tarefa em 15 minutos',
          message: 'A tarefa "Academia" começa em 15 minutos.\nSe prepare, termine o que está fazendo e toque.',
        ),
        NotificationItem(
          title: 'Tarefa em 15 minutos',
          message: 'A tarefa "Academia" começa em 15 minutos.\nSe prepare, termine o que está fazendo e toque.',
        ),
        NotificationItem(
          title: 'Tarefa em 15 minutos',
          message: 'A tarefa "Academia" começa em 15 minutos.\nSe prepare, termine o que está fazendo e toque.',
        ),
        NotificationItem(
          title: 'Tarefa em 15 minutos',
          message: 'A tarefa "Academia" começa em 15 minutos.\nSe prepare, termine o que está fazendo e toque.',
        ),
      ];
    });
  }

  void _markAllAsRead() {
    setState(() {
      if (_showUnreadNotifications) {
        for (var notif in _notifications) {
          notif.isRead = true;
        }
        _showUnreadNotifications = false;
      } else {
        _showUnreadNotifications = true;
        _loadNotifications();
      }
    });
  }

  // REMOVIDO: _handleBottomNavTap e _navigateToAddCreateTaskScreen
  // A lógica de navegação agora está em BottomNavigationBarCustom

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2E2E3E),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white, size: 30),
          onPressed: () {
            // Volta para a tela de tarefas como fallback.
            BottomNavigationBarCustom.navigate(0, context);
          },
        ),
        title: Text(
          _showUnreadNotifications ? 'Notificações' : 'Notificações-lidas',
          style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: _showUnreadNotifications
                ? (_notifications.where((n) => !n.isRead).isEmpty
                    ? _buildNoNotificationsContent()
                    : ListView.builder(
                        padding: const EdgeInsets.all(16.0),
                        itemCount: _notifications.where((n) => !n.isRead).length,
                        itemBuilder: (context, index) {
                          final unreadNotifications = _notifications.where((n) => !n.isRead).toList();
                          final notification = unreadNotifications[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: NotificationCard(
                              notification: notification,
                              onTap: () {
                                setState(() {
                                  notification.isRead = true;
                                });
                              },
                            ),
                          );
                        },
                      ))
                : _buildNoNotificationsContent(),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0, left: 16.0, right: 16.0),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _markAllAsRead,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6B8A9E),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Text(
                  _showUnreadNotifications ? 'Marcar tudo como lido' : 'Marcar tudo como não lido',
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _buildNoNotificationsContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.notifications_off_outlined,
            color: Colors.grey,
            size: 100,
          ),
          const SizedBox(height: 20),
          const Text(
            'Nenhuma notificação encontrada',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}