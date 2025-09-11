// lib/data/repositories/estimation_repository.dart
class EstimationRepository {
  final ApiService apiService;

  EstimationRepository({required this.apiService});

  // دریافت لیست مصالح از بک‌اند
  Future<List<MaterialModel>> getMaterials() async {
    try {
      final response = await apiService.get('/materials');
      final List<dynamic> data = response.data;
      return data.map((json) => MaterialModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('خطا در دریافت لیست مصالح: $e');
    }
  }

  // جستجوی مصالح
  Future<List<MaterialModel>> searchMaterials(String query) async {
    try {
      final response = await apiService.get('/materials/search?q=$query');
      final List<dynamic> data = response.data;
      return data.map((json) => MaterialModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('خطا در جستجوی مصالح: $e');
    }
  }

  // ذخیره برآورد در بک‌اند
  Future<EstimationModel> saveEstimation(EstimationModel estimation) async {
    try {
      final response = await apiService.post('/estimations', estimation.toJson());
      return EstimationModel.fromJson(response.data);
    } catch (e) {
      throw Exception('خطا در ذخیره برآورد: $e');
    }
  }

  // دریافت برآورد از بک‌اند
  Future<EstimationModel> getEstimation(String id) async {
    try {
      final response = await apiService.get('/estimations/$id');
      return EstimationModel.fromJson(response.data);
    } catch (e) {
      throw Exception('خطا در دریافت برآورد: $e');
    }
  }
}
