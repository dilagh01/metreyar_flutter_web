// lib/models/project.dart
class Project {
  final int id;
  final String name;
  final String client;
  final DateTime startDate;
  final DateTime? endDate;
  final String status;
  final double estimatedBudget;
  final DateTime lastUpdate; // اضافه کردن lastUpdate

  Project({
    required this.id,
    required this.name,
    required this.client,
    required this.startDate,
    this.endDate,
    required this.status,
    required this.estimatedBudget,
    required this.lastUpdate, // اضافه کردن lastUpdate
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      client: json['client'] ?? '',
      startDate: DateTime.parse(json['start_date'] ?? DateTime.now().toString()),
      endDate: json['end_date'] != null ? DateTime.parse(json['end_date']) : null,
      status: json['status'] ?? 'فعال',
      estimatedBudget: (json['estimated_budget'] ?? 0).toDouble(),
      lastUpdate: DateTime.parse(json['last_update'] ?? DateTime.now().toString()), // اضافه کردن lastUpdate
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'client': client,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate?.toIso8601String(),
      'status': status,
      'estimated_budget': estimatedBudget,
      'last_update': lastUpdate.toIso8601String(), // اضافه کردن lastUpdate
    };
  }
}
