import 'dart:convert';
import 'package:http/http.dart' as http;

import 'AdhanDataModel.dart';

class ApiService {
  final String baseUrl = 'http://api.aladhan.com/v1';

  Future<Adhan> getPrayerTimings(int year, int month, double latitude, double longitude) async {
    final response = await http.get(Uri.parse('$baseUrl/calendar/$year/$month?latitude=$latitude&longitude=$longitude&method=2'));
    if (response.statusCode == 200) {
      return Adhan.fromMap(json.decode(response.body));
    } else {
      throw Exception('Failed to load prayer timings');
    }
  }
}
