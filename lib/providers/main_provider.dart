import 'package:flutter/foundation.dart';
import 'project_provider.dart';
import 'price_provider.dart';
import 'boq_provider.dart';
import 'estimation_provider.dart';

class MainProvider with ChangeNotifier {
  final ProjectProvider _projectProvider = ProjectProvider();
  final PriceProvider _priceProvider = PriceProvider();
  final BOQProvider _boqProvider = BOQProvider();
  final EstimationProvider _estimationProvider = EstimationProvider();

  // دسترسی به Providerها
  ProjectProvider get projectProvider => _projectProvider;
  PriceProvider get priceProvider => _priceProvider;
  BOQProvider get boqProvider => _boqProvider;
  EstimationProvider get estimationProvider => _estimationProvider;

  // وضعیت کلی برنامه
  bool _isLoading = false;
  String _globalError = '';

  bool get isLoading => _isLoading;
  String get globalError => _globalError;

  // متدهای هماهنگ‌سازی برای بارگذاری اولیه
  Future<void> initializeApp() async {
    _isLoading = true;
    _globalError = '';
    notifyListeners();

    try {
      await Future.wait([
        _projectProvider.loadProjects(),
        _priceProvider.loadPriceItems(),
        _estimationProvider.loadMaterials(),
      ]);
      
      _globalError = '';
    } catch (e) {
      _globalError = 'خطا در راه‌اندازی برنامه: $e';
      if (kDebugMode) {
        print('Initialization error: $e');
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // پاک کردن خطاهای全局
  void clearGlobalError() {
    _globalError = '';
    notifyListeners();
  }

  // رفرش کلی داده‌ها
  Future<void> refreshAllData() async {
    await initializeApp();
  }
}
