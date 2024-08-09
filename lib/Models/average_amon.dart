// Model class to represent a single temperature record
class HourlyAmonia {
  final int hour;
  final double averageAmonia;

  HourlyAmonia({required this.hour, required this.averageAmonia});

  factory HourlyAmonia.fromJson(Map<String, dynamic> json) {
    return HourlyAmonia(
      hour: json['hour'],
      averageAmonia: (json['average_amonia'] ?? 0.0).toDouble(),
    );
  }
}

// Model class to represent a list of temperature records
class AmoniaData {
  final List<HourlyAmonia> amonia;

  AmoniaData({required this.amonia});

  // Factory method to create an instance from JSON
  factory AmoniaData.fromJson(List<dynamic> json) {
    List<HourlyAmonia> amon =
        json.map((amon) => HourlyAmonia.fromJson(amon)).toList();
    return AmoniaData(amonia: amon);
  }
}
