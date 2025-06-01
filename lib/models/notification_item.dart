class NotificationItem {
  
  final String title;
  final String message;
  bool isRead;

  NotificationItem({
    required this.title,
    required this.message,
    this.isRead = false,
  });

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