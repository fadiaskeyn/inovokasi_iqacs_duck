class GasReading {
  final int id;
  final int idAlat;
  final double nilai;
  final DateTime createdAt;
  final DateTime updatedAt;

  GasReading(
      {required this.id,
      required this.idAlat,
      required this.nilai,
      required this.createdAt,
      required this.updatedAt});

  factory GasReading.fromJson(Map<String, dynamic> json) {
    return GasReading(
      id: json['id_dioksida'] ??
          json['id_humidity'] ??
          json['id_temperature'] ??
          json['id_metana'] ??
          json['id_amonia'],
      idAlat: json['id_alat'],
      nilai: (json['nilai_dioksida'] ??
              json['nilai_humidity'] ??
              json['nilai_temperature'] ??
              json['nilai_metana'] ??
              json['nilai_amonia'])
          .toDouble(),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}

class ApiResponse {
  final List<GasReading> dioksida;
  final List<GasReading> humidity;
  final List<GasReading> temperature;
  final List<GasReading> metana;
  final List<GasReading> amonia;

  ApiResponse({
    required this.dioksida,
    required this.humidity,
    required this.temperature,
    required this.metana,
    required this.amonia,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      dioksida: (json['dioksida'] as List)
          .map((i) => GasReading.fromJson(i))
          .toList(),
      humidity: (json['humidity'] as List)
          .map((i) => GasReading.fromJson(i))
          .toList(),
      temperature: (json['Temperature'] as List)
          .map((i) => GasReading.fromJson(i))
          .toList(),
      metana:
          (json['metana'] as List).map((i) => GasReading.fromJson(i)).toList(),
      amonia:
          (json['amonia'] as List).map((i) => GasReading.fromJson(i)).toList(),
    );
  }
}
