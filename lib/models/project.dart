class Project {
  final int id;
  final String name;
  final String status;
  final String client;
  final double estimatedBudget;
  final DateTime startDate;
  final String lastUpdate;

  Project({
    required this.id,
    required this.name,
    required this.status,
    required this.client,
    required this.estimatedBudget,
    required this.startDate,
    required this.lastUpdate,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      client: json['client'],
      estimatedBudget: (json['estimatedBudget'] as num).toDouble(),
      startDate: DateTime.parse(json['startDate']),
      lastUpdate: json['lastUpdate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "status": status,
      "client": client,
      "estimatedBudget": estimatedBudget,
      "startDate": startDate.toIso8601String(),
      "lastUpdate": lastUpdate,
    };
  }
}
