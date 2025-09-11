import 'package:flutter/foundation.dart';
import '../models/project.dart';
import '../core/network/api_service.dart';
import '../core/config/api_endpoints.dart';

class ProjectProvider with ChangeNotifier {
  List<Project> _projects = [];
  bool _isLoading = false;
  String _error = '';

  List<Project> get projects => _projects;
  bool get isLoading => _isLoading;
  String get error => _error;

  Future<void> loadProjects() async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      final response = await ApiService.getList(ApiEndpoints.projects);
      _projects = response.map((json) => Project.fromJson(json)).toList();
      _error = '';
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addProject(Project project) async {
    try {
      final response = await ApiService.postData(
        ApiEndpoints.projects,
        project.toJson(),
      );
      final newProject = Project.fromJson(response);
      _projects.add(newProject);
      notifyListeners();
    } catch (e) {
      throw Exception('خطا در ایجاد پروژه: $e');
    }
  }
}
