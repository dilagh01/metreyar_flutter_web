import 'package:flutter/foundation.dart';
import '../services/price_service.dart';
import '../models/price_list.dart';

class PriceProvider with ChangeNotifier {
  List<PriceItem> _priceItems = [];
  bool _loading = false;
  Map<String, double> _coefficients = {};

  List<PriceItem> get priceItems => _priceItems;
  bool get loading => _loading;

  Future<void> loadPriceItems() async {
    _loading = true;
    notifyListeners();

    try {
      _priceItems = await PriceService.getPriceItems();
    } catch (e) {
      throw Exception('خطا در بارگذاری فهرست بها: $e');
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<double> calculateItem(String itemCode, Map<String, double> quantities) async {
    try {
      final request = CalculationRequest(
        itemCode: itemCode,
        quantities: quantities,
      );
      
      final result = await PriceService.calculatePrice(request);
      return result.result;
    } catch (e) {
      throw Exception('خطا در محاسبه: $e');
    }
  }

  Future<void> loadCoefficient(String tableName, String key) async {
    final coefficient = await PriceService.getCoefficient(tableName, key);
    _coefficients['$tableName.$key'] = coefficient;
    notifyListeners();
  }

  double getCoefficient(String tableName, String key) {
    return _coefficients['$tableName.$key'] ?? 1.0;
  }
}
