import 'package:flutter/material.dart';
import '../models/project.dart';

class ProjectProvider with ChangeNotifier {
  List<Project> projects = [];

  bool _isConnected = false;
  bool _isLoading = false;
  String _error = '';

  bool get isConnected => _isConnected;
  bool get isLoading => _isLoading;
  String get error => _error;

  void retry() {
    // لاجیک برای اتصال دوباره به بک‌اند
    _isConnected = true; // مثال
    notifyListeners();
  }

  void addProject(Project project) {
    projects.add(project);
    notifyListeners();
  }
}
