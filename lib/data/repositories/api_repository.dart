import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/material_model.dart';
import '../models/estimation_model.dart';
import '../../core/constants/api_constants.dart';

class ApiRepository {
  final String baseUrl = ApiConstants.baseUrl;

  Future<List<MaterialModel>> getMaterials() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl${ApiConstants.materials}'),
        headers: ApiConstants.headers,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => MaterialModel.fromJson(json)).toList();
      } else {
        throw Exception('خطا در دریافت مصالح: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('خطا در ارتباط با سرور: $e');
    }
  }

  Future<List<MaterialModel>> searchMaterials(String query) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl${ApiConstants.materialsSearch}?q=$query'),
        headers: ApiConstants.headers,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => MaterialModel.fromJson(json)).toList();
      } else {
        throw Exception('خطا در جستجوی مصالح: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('خطا در ارتباط با سرور: $e');
    }
  }

  Future<EstimationModel> createEstimation(EstimationModel estimation) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl${ApiConstants.estimations}'),
        headers: ApiConstants.headers,
        body: json.encode(estimation.toJson()),
      );

      if (response.statusCode == 201) {
        return EstimationModel.fromJson(json.decode(response.body));
      } else {
        throw Exception('خطا در ایجاد برآورد: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('خطا در ارتباط با سرور: $e');
    }
  }

  Future<List<EstimationModel>> getEstimations() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl${ApiConstants.estimations}'),
        headers: ApiConstants.headers,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => EstimationModel.fromJson(json)).toList();
      } else {
        throw Exception('خطا در دریافت برآوردها: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('خطا در ارتباط با سرور: $e');
    }
  }

  Future<bool> checkHealth() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl${ApiConstants.health}'),
        headers: ApiConstants.headers,
      );
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}
