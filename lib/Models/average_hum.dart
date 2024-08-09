// Model class to represent a single temperature record
class HourlyHumidity {
  final int hour;
  final double averageHumidity;

  HourlyHumidity({required this.hour, required this.averageHumidity});

  factory HourlyHumidity.fromJson(Map<String, dynamic> json) {
    return HourlyHumidity(
      hour: json['hour'],
      averageHumidity: (json['average_humidity'] ?? 0.0).toDouble(),
    );
  }
}

// Model class to represent a list of temperature records
class HumidityData {
  final List<HourlyHumidity> humidity;

  HumidityData({required this.humidity});

  // Factory method to create an instance from JSON
  factory HumidityData.fromJson(List<dynamic> json) {
    List<HourlyHumidity> hums =
        json.map((temp) => HourlyHumidity.fromJson(temp)).toList();
    return HumidityData(humidity: hums);
  }
}
