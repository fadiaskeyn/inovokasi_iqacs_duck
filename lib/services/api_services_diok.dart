import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile_gmf/Models/average_diok.dart';

class ApiServiceDiok {
  Future<DioksidaData> fetchDailyDioksidaSummary(String location) async {
    final url =
        'https://is4ac.research-ai.my.id/api/averagediok/$location'; // replace with your actual URL

    try {
      final response = await http.get(Uri.parse(url));

      // Debugging: Print response status and body
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // Debugging: Print parsed data
        print('Parsed data: $data');

        // Assuming data is parsed into TemperatureData object
        return DioksidaData.fromJson(data);
      } else {
        throw Exception('Failed to load dioksida data');
      }
    } catch (e) {
      print('Error fetching dioksida data: $e');
      rethrow;
    }
  }
}
