// lib/services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class ApiService {
  static const String baseUrl = 'https://metreyar.onrender.com/api/v1';
  static const String apiVersion = '/api/v1';

  static const Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  // تابع عمومی برای درخواست‌های GET
  static Future<dynamic> get(String endpoint) async {
    if (kDebugMode) {
      print('GET: $baseUrl$apiVersion$endpoint');
    }
    
    try {
      final response = await http.get(
        Uri.parse('$baseUrl$apiVersion$endpoint'),
        headers: headers,
      );
      
      return _handleResponse(response);
    } catch (e) {
      throw Exception('خطا در اتصال به سرور: $e');
    }
  }

  // تابع عمومی برای درخواست‌های POST
  static Future<dynamic> post(String endpoint, dynamic data) async {
    if (kDebugMode) {
      print('POST: $baseUrl$apiVersion$endpoint');
      print('Data: $data');
    }
    
    try {
      final response = await http.post(
        Uri.parse('$baseUrl$apiVersion$endpoint'),
        headers: headers,
        body: json.encode(data),
      );
      
      return _handleResponse(response);
    } catch (e) {
      throw Exception('خطا در اتصال به سرور: $e');
    }
  }

  static dynamic _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) {
        return {'success': true};
      }
      return json.decode(response.body);
    } else if (response.statusCode == 401) {
      throw Exception('احراز هویت ناموفق');
    } else if (response.statusCode == 404) {
      throw Exception('منبع یافت نشد');
    } else if (response.statusCode >= 500) {
      throw Exception('خطای سرور');
    } else {
      throw Exception('خطای ناشناخته: ${response.statusCode}');
    }
  }

  // متدهای خاص برای endpointهای مختلف
  static Future<List<dynamic>> getProjects() async {
    return await get('/projects/');
  }

  static Future<dynamic> createProject(Map<String, dynamic> projectData) async {
    return await post('/projects/', projectData);
  }

  static Future<List<dynamic>> getPriceBooks() async {
    return await get('/price-books/');
  }

  static Future<List<dynamic>> getProjectBoq(int projectId) async {
    return await get('/projects/$projectId/boq/');
  }

  static Future<dynamic> addBoqItem(int projectId, Map<String, dynamic> boqData) async {
    return await post('/projects/$projectId/boq/', boqData);
  }

  // متد برای بررسی وضعیت اتصال
  static Future<bool> checkConnection() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/health'),
        headers: headers,
      ).timeout(Duration(seconds: 5));
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}
