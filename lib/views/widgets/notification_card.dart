import 'package:flutter/material.dart';
import 'package:task_master/models/notification_item.dart';

class NotificationCard extends StatelessWidget {
  final NotificationItem notification;
  final VoidCallback? onTap; // Opcional, para marcar como lida ao tocar

  const NotificationCard({
    super.key,
    required this.notification,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // A cor de fundo será um cinza claro ou branco para notificações não lidas.
    // Usamos Colors.white.withOpacity(0.1) para simular o card claro no fundo escuro.
    final Color backgroundColor = notification.isRead
        ? Colors.grey.withOpacity(0.2) // Mais transparente/escuro se lida
        : Colors.white.withOpacity(0.1); // Cor para não lida

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: backgroundColor, //
          borderRadius: BorderRadius.circular(15.0),
          // Borda sutil para separar os cards
          border: Border.all(
            color: Colors.white.withOpacity(0.05),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              notification.title, //
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              notification.message, //
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 14,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}