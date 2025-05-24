class NotificationItem {
  final String title;
  final String message;
  bool isRead; // Para controlar o estado de lida/não lida

  NotificationItem({
    required this.title,
    required this.message,
    this.isRead = false,
  });

  // Método opcional para converter para/de JSON
  factory NotificationItem.fromJson(Map<String, dynamic> json) {
    return NotificationItem(
      title: json['title'] as String,
      message: json['message'] as String,
      isRead: json['isRead'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'message': message,
      'isRead': isRead,
    };
  }
}