class EstimationProvider with ChangeNotifier {
  List<dynamic> _materials = [];
  List<dynamic> _projects = [];
  Map<String, dynamic>? _calculationResult;
  bool _loading = false;

  List<dynamic> get materials => _materials;
  List<dynamic> get projects => _projects;
  Map<String, dynamic>? get calculationResult => _calculationResult;
  bool get loading => _loading;

  // دریافت مواد اولیه
  Future<void> loadMaterials() async {
    _setLoading(true);
    try {
      _materials = await ApiService.getMaterials();
      print('✅ Loaded ${_materials.length} materials');
    } catch (e) {
      print('❌ Error loading materials: $e');
    } finally {
      _setLoading(false);
    }
  }

  // دریافت پروژه‌ها
  Future<void> loadProjects() async {
    _setLoading(true);
    try {
      _projects = await ApiService.getProjects();
      print('✅ Loaded ${_projects.length} projects');
    } catch (e) {
      print('❌ Error loading projects: $e');
    } finally {
      _setLoading(false);
    }
  }

  // محاسبه برآورد
  Future<void> calculateEstimation(Map<String, dynamic> data) async {
    _setLoading(true);
    try {
      _calculationResult = await ApiService.calculateEstimation(data);
      print('✅ Calculation result: $_calculationResult');
    } catch (e) {
      print('❌ Error calculating estimation: $e');
      throw e;
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }
}
