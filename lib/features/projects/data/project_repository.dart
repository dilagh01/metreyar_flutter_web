// lib/features/projects/data/project_repository.dart
import 'dart:convert';
import '../../../core/network/api_service.dart';
import '../domain/project.dart';

class ProjectRepository {
  static Future<List<Project>> getProjects() async {
    try {
      final response = await ApiService.get(ApiEndpoints.projects);
      return (response as List).map((json) => Project.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to fetch projects: $e');
    }
  }

  static Future<Project> createProject(Project project) async {
    try {
      final response = await ApiService.post(
        ApiEndpoints.projects, 
        project.toJson()
      );
      return Project.fromJson(response);
    } catch (e) {
      throw Exception('Failed to create project: $e');
    }
  }

  static Future<Project> updateProject(Project project) async {
    try {
      final response = await ApiService.put(
        ApiEndpoints.project(project.id), 
        project.toJson()
      );
      return Project.fromJson(response);
    } catch (e) {
      throw Exception('Failed to update project: $e');
    }
  }

  static Future<void> deleteProject(int id) async {
    try {
      await ApiService.delete(ApiEndpoints.project(id));
    } catch (e) {
      throw Exception('Failed to delete project: $e');
    }
  }
}
