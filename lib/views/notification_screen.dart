import 'package:flutter/material.dart';
import 'package:task_master/models/notification_item.dart';
import 'package:task_master/views/widgets/notification_card.dart';
import 'package:task_master/views/widgets/bottom_navigation_bar_custom.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  
  List<NotificationItem> _notifications = [];
  bool _showUnreadNotifications = true;
  final int _selectedIndex = 3;

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
          isRead: true,
        ),
        NotificationItem(
          title: 'Lembrete de Reunião',
          message: 'Reunião com a equipe de marketing às 10h na sala 3.',
        ),
        NotificationItem(
          title: 'Prazo de Entrega',
          message: 'O projeto "App TaskMaster" deve ser finalizado hoje.',
          isRead: true,
        ),
        NotificationItem(
          title: 'Nova Atribuição',
          message: 'Você foi atribuído à tarefa "Revisar Documentação".',
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

  @override
  Widget build(BuildContext context) {
    final List<NotificationItem> displayedNotifications = _showUnreadNotifications
        ? _notifications.where((n) => !n.isRead).toList()
        : _notifications.where((n) => n.isRead).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black87, size: 30),
          onPressed: () {
            BottomNavigationBarCustom.navigate(0, context);
          },
        ),
        title: Text(
          _showUnreadNotifications ? 'Notificações' : 'Notificações Lidas',
          style: const TextStyle(color: Colors.black87, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: displayedNotifications.isEmpty
                ? _buildNoNotificationsContent()
                : ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: displayedNotifications.length,
                    itemBuilder: (context, index) {
                      final notification = displayedNotifications[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: NotificationCard(
                          notification: notification,
                          onTap: () {
                            if (_showUnreadNotifications) {
                              setState(() {
                                notification.isRead = true;
                              });
                            }
                          },
                        ),
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0, left: 16.0, right: 16.0),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _markAllAsRead,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff19647E),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Text(
                  _showUnreadNotifications ? 'Marcar tudo como lido' : 'Mostrar não lidas',
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
          Icon(
            Icons.notifications_off_outlined,
            color: Colors.grey.shade400,
            size: 100,
          ),
          const SizedBox(height: 20),
          Text(
            'Nenhuma notificação ${_showUnreadNotifications ? 'não lida' : 'lida'} encontrada',
            style: const TextStyle(
              color: Colors.black54,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}