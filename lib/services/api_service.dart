import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://metreyar.onrender.com';
  static const String apiVersion = '/api/v1';

  static Future<Map<String, dynamic>> get(String endpoint) async {
    final response = await http.get(Uri.parse('$baseUrl$apiVersion$endpoint'));
    return _handleResponse(response);
  }

  static Future<Map<String, dynamic>> post(String endpoint, dynamic data) async {
    final response = await http.post(
      Uri.parse('$baseUrl$apiVersion$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );
    return _handleResponse(response);
  }

  static Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('API Error: ${response.statusCode}');
    }
  }

  // متدهای خاص برای متریار
  static Future<List<dynamic>> getProjects() async {
    final response = await get('/projects');
    return response['projects'] ?? [];
  }

  static Future<Map<String, dynamic>> calculateEstimation(Map<String, dynamic> data) async {
    return await post('/calculations/estimate', data);
  }

  static Future<bool> checkHealth() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/health'));
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}
