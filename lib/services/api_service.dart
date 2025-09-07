import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "https://metreyar.onrender.com/api";

  static Future<Map<String, dynamic>> getMaterials() async {
    final url = Uri.parse("$baseUrl/materials");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load materials: ${response.statusCode}");
    }
  }
}
