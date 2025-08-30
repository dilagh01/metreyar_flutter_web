class Project {
  final String id;
  final String name;
  final String location;
  final DateTime startDate;
  final DateTime? endDate;
  final double budget;

  Project({
    required this.id,
    required this.name,
    required this.location,
    required this.startDate,
    this.endDate,
    required this.budget,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'budget': budget,
    };
  }

  factory Project.fromMap(Map<String, dynamic> map) {
    return Project(
      id: map['id'],
      name: map['name'],
      location: map['location'],
      startDate: DateTime.parse(map['startDate']),
      endDate: map['endDate'] != null ? DateTime.parse(map['endDate']) : null,
      budget: map['budget'],
    );
  }
}
