// lib/core/network/api_service.dart
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import '../config/api_endpoints.dart';

class ApiService {
  static const int maxRetries = 3;
  static const Duration timeoutDuration = Duration(seconds: 30);
  static const Duration retryDelay = Duration(seconds: 2);

  static final Map<String, String> _headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'User-Agent': 'Metreyar-Flutter-App/1.0',
  };

  // افزودن interceptor برای لاگ‌گیری
  static void _logRequest(String method, String url, [dynamic data]) {
    if (kDebugMode) {
      print('🌐 $method $url');
      if (data != null) {
        print('📦 Request Data: $data');
      }
    }
  }

  static void _logResponse(http.Response response) {
    if (kDebugMode) {
      print('📨 Response: ${response.statusCode}');
      print('📄 Body: ${response.body}');
    }
  }

  // تابع با قابلیت retry
  static Future<http.Response> _retryRequest(Future<http.Response> Function() request) async {
    for (int i = 0; i < maxRetries; i++) {
      try {
        final response = await request().timeout(timeoutDuration);
        if (response.statusCode < 500 || i == maxRetries - 1) {
          return response;
        }
      } catch (e) {
        if (i == maxRetries - 1) rethrow;
      }
      
      if (i < maxRetries - 1) {
        await Future.delayed(retryDelay * (i + 1));
      }
    }
    throw Exception('Request failed after $maxRetries attempts');
  }

  // GET
  static Future<dynamic> get(String endpoint) async {
    final url = ApiEndpoints.buildUrl(endpoint);
    _logRequest('GET', url);

    try {
      final response = await _retryRequest(() => http.get(Uri.parse(url), headers: _headers));
      _logResponse(response);
      return _handleResponse(response);
    } catch (e) {
      throw Exception('GET failed: $e');
    }
  }

  // POST
  static Future<dynamic> post(String endpoint, dynamic data) async {
    final url = ApiEndpoints.buildUrl(endpoint);
    _logRequest('POST', url, data);

    try {
      final response = await _retryRequest(() => http.post(
        Uri.parse(url),
        headers: _headers,
        body: json.encode(data),
      ));
      _logResponse(response);
      return _handleResponse(response);
    } catch (e) {
      throw Exception('POST failed: $e');
    }
  }

  // PUT
  static Future<dynamic> put(String endpoint, dynamic data) async {
    final url = ApiEndpoints.buildUrl(endpoint);
    _logRequest('PUT', url, data);

    try {
      final response = await _retryRequest(() => http.put(
        Uri.parse(url),
        headers: _headers,
        body: json.encode(data),
      ));
      _logResponse(response);
      return _handleResponse(response);
    } catch (e) {
      throw Exception('PUT failed: $e');
    }
  }

  // DELETE
  static Future<dynamic> delete(String endpoint) async {
    final url = ApiEndpoints.buildUrl(endpoint);
    _logRequest('DELETE', url);

    try {
      final response = await _retryRequest(() => http.delete(
        Uri.parse(url),
        headers: _headers,
      ));
      _logResponse(response);
      return _handleResponse(response);
    } catch (e) {
      throw Exception('DELETE failed: $e');
    }
  }

  static dynamic _handleResponse(http.Response response) {
    final statusCode = response.statusCode;
    
    switch (statusCode) {
      case 200:
      case 201:
        return response.body.isNotEmpty ? json.decode(response.body) : {'success': true};
      case 204:
        return {'success': true};
      case 400:
        throw Exception('درخواست نامعتبر');
      case 401:
        throw Exception('دسترسی غیرمجاز');
      case 403:
        throw Exception('ممنوع');
      case 404:
        throw Exception('پیدا نشد');
      case 500:
        throw Exception('خطای سرور');
      default:
        throw Exception('خطای ناشناخته: $statusCode');
    }
  }
}
