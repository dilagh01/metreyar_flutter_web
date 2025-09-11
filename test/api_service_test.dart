import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:metreyar/core/network/api_service.dart';

@GenerateMocks([http.Client])
void main() {
  group('ApiService Tests', () {
    test('handleResponse should handle 200 status correctly', () {
      final response = http.Response('{"success": true}', 200);
      expect(() => ApiService._handleResponse(response), returnsNormally);
    });

    test('handleResponse should throw on 404 status', () {
      final response = http.Response('Not Found', 404);
      expect(() => ApiService._handleResponse(response), throwsException);
    });

    // تست‌های بیشتر...
  });
}
