import 'package:flutter/foundation.dart';
import '../services/api_service.dart';

class EstimationProvider with ChangeNotifier {
  List<dynamic> _projects = [];
  bool _loading = false;
  String _error = '';

  List<dynamic> get projects => _projects;
  bool get loading => _loading;
  String get error => _error;

  Future<void> loadProjects() async {
    _loading = true;
    _error = '';
    notifyListeners();

    try {
      _projects = await ApiService.getProjects();
      _error = '';
    } catch (e) {
      _error = 'خطا در بارگذاری پروژه‌ها: $e';
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<Map<String, dynamic>> calculateEstimation(Map<String, dynamic> data) async {
    _loading = true;
    notifyListeners();

    try {
      final result = await ApiService.calculateEstimation(data);
      _error = '';
      return result;
    } catch (e) {
      _error = 'خطا در محاسبه: $e';
      return {'success': false, 'error': _error};
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
