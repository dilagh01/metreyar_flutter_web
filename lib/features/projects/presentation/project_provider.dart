// lib/features/projects/presentation/project_provider.dart
import 'package:flutter/foundation.dart';
import '../domain/project.dart';
import '../data/project_repository.dart';

class ProjectProvider with ChangeNotifier {
  List<Project> _projects = [];
  bool _isLoading = false;
  String _error = '';
  DateTime? _lastUpdated;

  List<Project> get projects => _projects;
  bool get isLoading => _isLoading;
  String get error => _error;
  DateTime? get lastUpdated => _lastUpdated;
  bool get hasError => _error.isNotEmpty;

  Future<void> loadProjects({bool forceRefresh = false}) async {
    if (_isLoading && !forceRefresh) return;
    
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      final projects = await ProjectRepository.getProjects();
      _projects = projects;
      _lastUpdated = DateTime.now();
      _error = '';
    } catch (e) {
      _error = e.toString();
      if (kDebugMode) {
        print('Error loading projects: $e');
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addProject(Project project) async {
    _isLoading = true;
    notifyListeners();

    try {
      final newProject = await ProjectRepository.createProject(project);
      _projects.add(newProject);
      _error = '';
    } catch (e) {
      _error = e.toString();
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearError() {
    _error = '';
    notifyListeners();
  }

  void retry() {
    if (hasError) {
      loadProjects(forceRefresh: true);
    }
  }
}
