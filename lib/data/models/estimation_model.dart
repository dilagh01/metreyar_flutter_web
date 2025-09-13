class EstimationItem {
  final MaterialModel material;
  final double quantity;
  final double unitPrice;
  final String? description;

  EstimationItem({
    required this.material,
    required this.quantity,
    required this.unitPrice,
    this.description,
  });

  double get total => quantity * unitPrice;

  factory EstimationItem.fromJson(Map<String, dynamic> json) {
    return EstimationItem(
      material: MaterialModel.fromJson(json['material']),
      quantity: (json['quantity'] ?? 0).toDouble(),
      unitPrice: (json['unitPrice'] ?? 0).toDouble(),
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'material': material.toJson(),
      'quantity': quantity,
      'unitPrice': unitPrice,
      'description': description,
    };
  }
}

class EstimationModel {
  final String id;
  final String projectName;
  final List<EstimationItem> items;
  final DateTime createdAt;

  EstimationModel({
    required this.id,
    required this.projectName,
    required this.items,
    required this.createdAt,
  });

  double get grandTotal => items.fold(0, (sum, item) => sum + item.total);

  factory EstimationModel.fromJson(Map<String, dynamic> json) {
    return EstimationModel(
      id: json['_id'] ?? json['id'],
      projectName: json['projectName'],
      items: (json['items'] as List<dynamic>)
          .map((item) => EstimationItem.fromJson(item))
          .toList(),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'projectName': projectName,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }
}
