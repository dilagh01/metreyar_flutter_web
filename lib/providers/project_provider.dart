import 'package:flutter/material.dart';
import '../models/project.dart';

class ProjectProvider extends ChangeNotifier {
  List<Project> _projects = [];

  List<Project> get projects => _projects;

  void loadProjects() {
    // TODO: داده‌ها رو از دیتابیس یا API بخونید
    _projects = [
      Project(name: 'پروژه نمونه', status: 'فعال', lastUpdate: 'امروز'),
    ];
    notifyListeners();
  }

  void addProject(Project project) {
    _projects.add(project);
    notifyListeners();
  }
}
