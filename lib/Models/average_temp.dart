// Model class to represent a single temperature record
class HourlyTemperature {
  final int hour;
  final double averageTemperature;

  HourlyTemperature({required this.hour, required this.averageTemperature});

  factory HourlyTemperature.fromJson(Map<String, dynamic> json) {
    return HourlyTemperature(
      hour: json['hour'],
      averageTemperature: (json['average_temperature'] ?? 0.0).toDouble(),
    );
  }
}

// Model class to represent a list of temperature records
class TemperatureData {
  final List<HourlyTemperature> temperatures;

  TemperatureData({required this.temperatures});

  // Factory method to create an instance from JSON
  factory TemperatureData.fromJson(List<dynamic> json) {
    List<HourlyTemperature> temps =
        json.map((temp) => HourlyTemperature.fromJson(temp)).toList();
    return TemperatureData(temperatures: temps);
  }
}
