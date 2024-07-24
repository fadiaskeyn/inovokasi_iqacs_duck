import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile_gmf/Models/gas_reading.dart';

class ApiService {
  static const String baseUrl = 'https://is4ac.research-ai.my.id/api/gas';

  Future<ApiResponse> fetchGasReadings() async {
    final response = await http.get(Uri.parse('$baseUrl/1'));

    if (response.statusCode == 200) {
      return ApiResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to fetch gas readings');
    }
  }
}
