import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile_gmf/Models/average_amon.dart';

class ApiServiceAmon {
  Future<AmoniaData> fetchDailyAmoniaSummary(String location) async {
    final url =
        'https://is4ac.research-ai.my.id/api/averageamon/$location'; // replace with your actual URL

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
        return AmoniaData.fromJson(data);
      } else {
        throw Exception('Failed to load temperature data');
      }
    } catch (e) {
      print('Error fetching temperature data: $e');
      rethrow;
    }
  }
}
