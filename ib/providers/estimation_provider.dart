import 'package:flutter/material.dart';
import 'package:metreyar/services/api_service.dart';

class EstimationProvider extends ChangeNotifier {
  List<dynamic> _materials = [];
  List<dynamic> get materials => _materials;

  List<dynamic> _projects = [];
  List<dynamic> get projects => _projects;

  Map<String, dynamic>? _calculationResult;
  Map<String, dynamic>? get calculationResult => _calculationResult;

  Future<void> loadMaterials() async {
    _materials = await ApiService.getMaterials();
    notifyListeners();
  }

  Future<void> loadProjects() async {
    _projects = await ApiService.getProjects();
    notifyListeners();
  }

  Future<void> calculateEstimation(Map<String, dynamic> data) async {
    _calculationResult = await ApiService.calculateEstimation(data);
    notifyListeners();
  }
}
