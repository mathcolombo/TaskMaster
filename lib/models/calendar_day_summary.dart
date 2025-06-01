class CalendarDaySummary {
  
  final int day;
  final String weekday;
  final List<bool> hasTasks;

  CalendarDaySummary({
    required this.day,
    required this.weekday,
    this.hasTasks = const [],
  });

  factory CalendarDaySummary.fromJson(Map<String, dynamic> json) {
    return CalendarDaySummary(
      day: json['day'] as int,
      weekday: json['weekday'] as String,
      hasTasks: (json['hasTasks'] as List?)?.map((e) => e as bool).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'day': day,
      'weekday': weekday,
      'hasTasks': hasTasks,
    };
  }
}