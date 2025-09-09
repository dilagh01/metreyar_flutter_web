import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/project.dart';

class ProjectProvider with ChangeNotifier {
  List<Project> projects = [];

  bool _isConnected = false;
  bool _isLoading = false;
  String _error = '';

  bool get isConnected => _isConnected;
  bool get isLoading => _isLoading;
  String get error => _error;

  final String baseUrl = "http://localhost:3000/api"; // آدرس بک‌اند (جایگزین کن)

  Future<void> loadProjects() async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      final response = await http.get(Uri.parse("$baseUrl/projects"));

      if (response.statusCode == 200) {
        final List data = json.decode(response.body);
        projects = data.map((e) => Project.fromJson(e)).toList();
        _isConnected = true;
      } else {
        _error = "خطا در بارگذاری پروژه‌ها (${response.statusCode})";
        _isConnected = false;
      }
    } catch (e) {
      _error = "عدم اتصال به سرور: $e";
      _isConnected = false;
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addProject(Project project) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/projects"),
        headers: {"Content-Type": "application/json"},
        body: json.encode(project.toJson()),
      );

      if (response.statusCode == 201) {
        final newProject = Project.fromJson(json.decode(response.body));
        projects.add(newProject);
        notifyListeners();
      } else {
        _error = "خطا در ایجاد پروژه (${response.statusCode})";
      }
    } catch (e) {
      _error = "عدم اتصال به سرور: $e";
    }
    notifyListeners();
  }

  void retry() {
    loadProjects();
  }
}
