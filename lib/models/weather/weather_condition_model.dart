class WeatherCondition {
  final String text;
  final String icon;

  WeatherCondition({
    required this.text,
    required this.icon,
  });

  factory WeatherCondition.fromJson(Map<String, dynamic> json) {
    return WeatherCondition(
      text: json['text'],
      icon: json['icon'],
    );
  }
}
