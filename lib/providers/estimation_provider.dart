import 'package:flutter/material.dart';
import '../core/network/api_service.dart'; // import صحیح

class EstimationProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _materials = [];
  bool _loading = false;
  
  List<Map<String, dynamic>> get materials => _materials;
  bool get loading => _loading;

  Future<void> loadMaterials() async {
    _loading = true;
    notifyListeners();

    try {
      // استفاده از متد جدید
      final data = await ApiService.getList('/materials');
      _materials = List<Map<String, dynamic>>.from(data);
    } catch (e) {
      debugPrint("Error loading materials: $e");
      // داده‌های نمونه برای توسعه
      _materials = [
        {
          'id': 1,
          'name': 'سیمان پرتلند',
          'unit': 'کیلوگرم',
          'price': 5000.0,
          'category': 'مصالح ساختمانی'
        },
      ];
    }

    _loading = false;
    notifyListeners();
  }
}
