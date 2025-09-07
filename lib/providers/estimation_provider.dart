import 'package:flutter/material.dart';
import 'package:metreyar/services/api_service.dart';

class EstimationProvider extends ChangeNotifier {
  // --- State ---
  bool _loading = false;
  bool get loading => _loading;

  List<Map<String, dynamic>> _materials = [];
  List<Map<String, dynamic>> get materials => _materials;

  List<Map<String, dynamic>> _projects = [];
  List<Map<String, dynamic>> get projects => _projects;

  Map<String, dynamic>? _calculationResult;
  Map<String, dynamic>? get calculationResult => _calculationResult;

  // --- Methods ---
  Future<void> loadMaterials() async {
    try {
      _loading = true;
      notifyListeners();

      final data = await ApiService.getMaterials();
      _materials = List<Map<String, dynamic>>.from(data['materials'] ?? []);

      _loading = false;
      notifyListeners();
    } catch (e) {
      _loading = false;
      notifyListeners();
      debugPrint("❌ Error loading materials: $e");
    }
  }

  Future<void> loadProjects() async {
    try {
      _loading = true;
      notifyListeners();

      final data = await ApiService.getProjects();
      _projects = List<Map<String, dynamic>>.from(data ?? []);

      _loading = false;
      notifyListeners();
    } catch (e) {
      _loading = false;
      notifyListeners();
      debugPrint("❌ Error loading projects: $e");
    }
  }

  Future<void> createProject(Map<String, dynamic> projectData) async {
    try {
      final response = await ApiService.createProject(projectData);
      debugPrint("✅ Project created: $response");
      await loadProjects(); // refresh list
    } catch (e) {
      debugPrint("❌ Error creating project: $e");
    }
  }

  Future<void> calculateEstimation(Map<String, dynamic> calcData) async {
    try {
      _loading = true;
      notifyListeners();

      final result = await ApiService.calculateEstimation(calcData);
      _calculationResult = result['result'];

      _loading = false;
      notifyListeners();
    } catch (e) {
      _loading = false;
      notifyListeners();
      debugPrint("❌ Error calculating estimation: $e");
    }
  }
}
