// lib/data/models/estimation_model.dart
class EstimationItem {
  final MaterialModel? material;
  final double quantity;
  final double unitPrice;
  final String? description;

  EstimationItem({
    this.material,
    required this.quantity,
    required this.unitPrice,
    this.description,
  });

  double get total => quantity * unitPrice;

  factory EstimationItem.fromJson(Map<String, dynamic> json) {
    return EstimationItem(
      material: json['material'] != null 
          ? MaterialModel.fromJson(json['material']) 
          : null,
      quantity: (json['quantity'] ?? 0).toDouble(),
      unitPrice: (json['unitPrice'] ?? 0).toDouble(),
      description: json['description'],
    );
  }
}

class EstimationModel {
  final String id;
  final String projectName;
  final List<EstimationItem> items;
  final DateTime createdAt;
  final String? createdBy;

  EstimationModel({
    required this.id,
    required this.projectName,
    required this.items,
    required this.createdAt,
    this.createdBy,
  });

  double get grandTotal => EstimationCalculator.calculateGrandTotal(items);
  double get tax => EstimationCalculator.calculateTax(grandTotal);
  double get totalWithTax => EstimationCalculator.calculateTotalWithTax(grandTotal);
  Map<String, double> get categoryTotals => EstimationCalculator.calculateByCategory(items);

  factory EstimationModel.fromJson(Map<String, dynamic> json) {
    return EstimationModel(
      id: json['_id'] ?? json['id'],
      projectName: json['projectName'],
      items: (json['items'] as List<dynamic>?)
          ?.map((item) => EstimationItem.fromJson(item))
          .toList() ?? [],
      createdAt: DateTime.parse(json['createdAt']),
      createdBy: json['createdBy'],
    );
  }
}
