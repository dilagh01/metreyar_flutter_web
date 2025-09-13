class MaterialModel {
  final String id;
  final String name;
  final String unit;
  final String category;
  final double unitPrice;
  final String? description;

  MaterialModel({
    required this.id,
    required this.name,
    required this.unit,
    required this.category,
    required this.unitPrice,
    this.description,
  });

  factory MaterialModel.fromJson(Map<String, dynamic> json) {
    return MaterialModel(
      id: json['_id'] ?? json['id'],
      name: json['name'],
      unit: json['unit'],
      category: json['category'],
      unitPrice: (json['unitPrice'] ?? 0).toDouble(),
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'unit': unit,
      'category': category,
      'unitPrice': unitPrice,
      'description': description,
    };
  }
}
