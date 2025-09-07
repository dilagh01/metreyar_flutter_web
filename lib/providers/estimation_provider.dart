import 'package:flutter/material.dart';
import '../services/api_service.dart';

class EstimationProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _materials = [];
  bool _loading = false;

  List<Map<String, dynamic>> get materials => _materials;
  bool get loading => _loading;

  Future<void> loadMaterials() async {
    _loading = true;
    notifyListeners();

    try {
      final data = await ApiService.getMaterials();
      _materials = List<Map<String, dynamic>>.from(data['materials']);
    } catch (e) {
      debugPrint("Error loading materials: $e");
    }

    _loading = false;
    notifyListeners();
  }
}
