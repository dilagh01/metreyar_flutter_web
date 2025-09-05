import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/price_list.dart';

class PriceService {
  static const String baseUrl = 'https://metreyar.onrender.com/api/v1';

  static Future<List<PriceItem>> getPriceItems() async {
    final response = await http.get(Uri.parse('$baseUrl/price-items'));
    
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => PriceItem.fromJson(item)).toList();
    } else {
      throw Exception('خطا در دریافت فهرست بها');
    }
  }

  static Future<CalculationResult> calculatePrice(CalculationRequest request) async {
    final response = await http.post(
      Uri.parse('$baseUrl/calculate'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(request.toJson()),
    );

    if (response.statusCode == 200) {
      return CalculationResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('خطا در محاسبه');
    }
  }

  static Future<double> getCoefficient(String tableName, String key) async {
    final response = await http.get(
      Uri.parse('$baseUrl/coefficients/$tableName/$key'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['value'] ?? 1.0).toDouble();
    } else {
      return 1.0; // مقدار پیش‌فرض
    }
  }
}
