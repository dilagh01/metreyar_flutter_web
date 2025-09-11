class Project {
  final int id;
  final String name;
  final String client;
  final String location;
  final DateTime startDate;
  final String status;
  final double estimatedBudget;
  final String? lastUpdate;

  Project({
    required this.id,
    required this.name,
    required this.client,
    required this.location,
    required this.startDate,
    required this.status,
    required this.estimatedBudget,
    this.lastUpdate,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      client: json['client'] ?? '',
      location: json['location'] ?? '',
      startDate: DateTime.parse(json['start_date'] ?? DateTime.now().toIso8601String()),
      status: json['status'] ?? 'فعال',
      estimatedBudget: (json['budget'] ?? json['estimatedBudget'] ?? 0).toDouble(),
      lastUpdate: json['last_update'] ?? json['lastUpdate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'client': client,
      'location': location,
      'start_date': startDate.toIso8601String(),
      'status': status,
      'budget': estimatedBudget,
      'last_update': lastUpdate ?? DateTime.now().toIso8601String(),
    };
  }

  Project copyWith({
    int? id,
    String? name,
    String? client,
    String? location,
    DateTime? startDate,
    String? status,
    double? estimatedBudget,
    String? lastUpdate,
  }) {
    return Project(
      id: id ?? this.id,
      name: name ?? this.name,
      client: client ?? this.client,
      location: location ?? this.location,
      startDate: startDate ?? this.startDate,
      status: status ?? this.status,
      estimatedBudget: estimatedBudget ?? this.estimatedBudget,
      lastUpdate: lastUpdate ?? this.lastUpdate,
    );
  }
}
