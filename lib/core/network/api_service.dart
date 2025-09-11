import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import '../config/api_endpoints.dart';
import '../error/error_handler.dart';

class ApiService {
  static const int maxRetries = 3;
  static const Duration timeoutDuration = Duration(seconds: 30);
  static const Duration retryDelay = Duration(seconds: 2);

  static final Map<String, String> _headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'User-Agent': 'Metreyar-Flutter-App/1.0',
  };

  // متد عمومی برای درخواست‌ها
  static Future<dynamic> request({
    required String method,
    required String endpoint,
    dynamic data,
    Map<String, String>? customHeaders,
  }) async {
    final url = ApiEndpoints.buildUrl(endpoint);
    final headers = {..._headers, ...?customHeaders};

    _logRequest(method, url, data);

    try {
      final response = await _retryRequest(() async {
        switch (method.toUpperCase()) {
          case 'GET':
            return await http.get(Uri.parse(url), headers: headers);
          case 'POST':
            return await http.post(
              Uri.parse(url),
              headers: headers,
              body: data != null ? json.encode(data) : null,
            );
          case 'PUT':
            return await http.put(
              Uri.parse(url),
              headers: headers,
              body: data != null ? json.encode(data) : null,
            );
          case 'DELETE':
            return await http.delete(Uri.parse(url), headers: headers);
          default:
            throw Exception('Method not supported');
        }
      }).timeout(timeoutDuration);

      _logResponse(response);
      return _handleResponse(response);
    } catch (e) {
      ErrorHandler.logError('ApiService.$method', e);
      throw Exception(ErrorHandler.handleException(e));
    }
  }

  // متدهای اختصاصی
  static Future<List<dynamic>> getList(String endpoint) async {
    final response = await request(method: 'GET', endpoint: endpoint);
    return response is List ? response : [response];
  }

  static Future<Map<String, dynamic>> getSingle(String endpoint) async {
    return await request(method: 'GET', endpoint: endpoint);
  }

  static Future<dynamic> postData(String endpoint, dynamic data) async {
    return await request(method: 'POST', endpoint: endpoint, data: data);
  }

  // ... متدهای کمکی قبلی (_retryRequest, _logRequest, _logResponse, _handleResponse)
}
