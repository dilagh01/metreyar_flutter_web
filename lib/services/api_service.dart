// lib/services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class ApiService {
  static const String baseUrl = 'https://metreyar.onrender.com';
  static const int timeoutSeconds = 30;

  static const Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  // تابع عمومی برای درخواست‌های GET
  static Future<dynamic> get(String endpoint) async {
    final url = '$baseUrl$endpoint';
    
    if (kDebugMode) {
      print('🌐 GET: $url');
    }

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: headers,
      ).timeout(Duration(seconds: timeoutSeconds));

      return _handleResponse(response);
    } on http.ClientException catch (e) {
      throw Exception('خطا در اتصال به سرور: ${e.message}');
    } on Exception catch (e) {
      throw Exception('خطای ناشناخته: $e');
    }
  }

  // تابع عمومی برای درخواست‌های POST
  static Future<dynamic> post(String endpoint, dynamic data) async {
    final url = '$baseUrl$endpoint';
    
    if (kDebugMode) {
      print('🌐 POST: $url');
      print('📦 Data: $data');
    }

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: json.encode(data),
      ).timeout(Duration(seconds: timeoutSeconds));

      return _handleResponse(response);
    } on http.ClientException catch (e) {
      throw Exception('خطا در اتصال به سرور: ${e.message}');
    } on Exception catch (e) {
      throw Exception('خطای ناشناخته: $e');
    }
  }

  static dynamic _handleResponse(http.Response response) {
    if (kDebugMode) {
      print('📥 Response status: ${response.statusCode}');
      print('📦 Response body: ${response.body}');
    }

    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) {
        return {'success': true};
      }
      return json.decode(response.body);
    } else if (response.statusCode == 401) {
      throw Exception('احراز هویت ناموفق');
    } else if (response.statusCode == 404) {
      throw Exception('منبع یافت نشد (404)');
    } else if (response.statusCode >= 500) {
      throw Exception('خطای سرور داخلی (${response.statusCode})');
    } else {
      throw Exception('خطای HTTP: ${response.statusCode}');
    }
  }

  // ==================== متدهای برای endpointهای موجود ====================

  // دریافت مواد و مصالح (موجود است)
  static Future<List<dynamic>> getMaterials() async {
    try {
      final response = await get('/api/materials');
      return response is List ? response : [response];
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error in getMaterials: $e');
      }
      // داده‌های نمونه برای توسعه
      return [
        {
          'id': 1,
          'name': 'سیمان پرتلند',
          'unit': 'کیلوگرم',
          'price': 5000.0,
          'category': 'مصالح ساختمانی'
        },
        {
          'id': 2,
          'name': 'آجر فشاری',
          'unit': 'عدد', 
          'price': 1500.0,
          'category': 'مصالح ساختمانی'
        },
        {
          'id': 3,
          'name': 'تیرآهن ۱۴',
          'unit': 'متر',
          'price': 25000.0,
          'category': 'فلزی'
        }
      ];
    }
  }

  // محاسبه BOQ (موجود است)
  static Future<dynamic> calculateBOQ(Map<String, dynamic> data) async {
    try {
      return await post('/api/boq/calculate', data);
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error in calculateBOQ: $e');
      }
      throw Exception('خطا در محاسبه BOQ: $e');
    }
  }

  // محاسبه آنالیز (موجود است)
  static Future<dynamic> calculateAnalysis(Map<String, dynamic> data) async {
    try {
      return await post('/api/analysis/calculate', data);
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error in calculateAnalysis: $e');
      }
      throw Exception('خطا در محاسبه آنالیز: $e');
    }
  }

  // ==================== متدهای برای endpointهای آینده ====================

  // این متدها تا زمانی که endpointها ایجاد شوند، داده نمونه برمی‌گردانند
  static Future<List<dynamic>> getProjects() async {
    try {
      // اگر endpoint ایجاد شد، از این استفاده کنید:
      // return await get('/api/v1/projects/');
      
      // در حال حاضر داده نمونه
      return [
        {
          'id': 1,
          'name': 'پروژه ویلای مسکونی',
          'client': 'آقای محمدی',
          'status': 'فعال',
          'start_date': '2024-01-15',
          'budget': 250000000.0,
          'location': 'تهران، فرمانیه'
        },
        {
          'id': 2,
          'name': 'ساختمان تجاری',
          'client': 'شرکت نگین',
          'status': 'در حال انجام',
          'start_date': '2024-02-01',
          'budget': 180000000.0,
          'location': 'اصفهان، خیابان چهارباغ'
        }
      ];
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error in getProjects: $e');
      }
      rethrow;
    }
  }

  static Future<dynamic> createProject(Map<String, dynamic> projectData) async {
    // برای زمانی که endpoint ایجاد شود
    try {
      // return await post('/api/v1/projects/', projectData);
      
      // شبیه‌سازی ایجاد پروژه
      await Future.delayed(Duration(seconds: 1));
      return {
        'id': DateTime.now().millisecondsSinceEpoch,
        ...projectData,
        'created_at': DateTime.now().toIso8601String(),
        'status': 'فعال'
      };
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error in createProject: $e');
      }
      rethrow;
    }
  }

  static Future<List<dynamic>> getPriceBooks() async {
    try {
      // return await get('/api/v1/price-books/');
      
      // داده نمونه
      return [
        {
          'id': 1,
          'name': 'فهرست بها سال 1403',
          'year': 2024,
          'description': 'فهرست بهای پایه سال 1403'
        },
        {
          'id': 2,
          'name': 'فهرست بها استانی',
          'year': 2024,
          'description': 'فهرست بهای استانی تهران'
        }
      ];
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error in getPriceBooks: $e');
      }
      rethrow;
    }
  }

  // متد برای بررسی وضعیت اتصال
  static Future<bool> checkConnection() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/'),
        headers: headers,
      ).timeout(Duration(seconds: 5));
      
      return response.statusCode == 200;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Connection check failed: $e');
      }
      return false;
    }
  }

  // متد برای بررسی سلامت سرور
  static Future<Map<String, dynamic>?> checkHealth() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/health'),
        headers: headers,
      ).timeout(Duration(seconds: 5));
      
      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
      return null;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Health check failed: $e');
      }
      return null;
    }
  }
}
