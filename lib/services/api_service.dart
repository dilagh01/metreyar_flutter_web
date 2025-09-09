// lib/providers/project_provider.dart
import 'package:flutter/foundation.dart';
import '../models/project.dart';
import '../services/api_service.dart';

class ProjectProvider with ChangeNotifier {
  List<Project> _projects = [];
  bool _isLoading = false;
  String _error = '';
  bool _isConnected = true;

  List<Project> get projects => _projects;
  bool get isLoading => _isLoading;
  String get error => _error;
  bool get isConnected => _isConnected;

  Future<void> loadProjects() async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      final data = await ApiService.getProjects();
      _projects = (data as List).map((json) => Project.fromJson(json)).toList();
      _isConnected = true;
    } catch (e) {
      _error = e.toString();
      _isConnected = false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addProject(Project project) async {
    try {
      final data = await ApiService.createProject(project.toJson());
      _projects.add(Project.fromJson(data));
      _isConnected = true;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isConnected = false;
      notifyListeners();
      throw e;
    }
  }

  void checkConnection() async {
    try {
      _isConnected = await ApiService.checkConnection();
      notifyListeners();
    } catch (e) {
      _isConnected = false;
      notifyListeners();
    }
  }
}
