class CalendarDaySummary {
  final int day;
  final String weekday;
  // Representar os pontos de status. Poderíamos usar uma lista de cores
  // ou um mapa de TaskType para contagem, mas para este visual simples,
  // uma lista de booleans (indicando se tem task) ou int (para n° de tasks) é o suficiente.
  final List<bool> hasTasks; // true para ter um ponto, false para não.

  CalendarDaySummary({
    required this.day,
    required this.weekday,
    this.hasTasks = const [], // Default para vazio
  });

  // Métodos fromJson/toJson seriam implementados aqui se viesse de uma API
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