// lib/models/row_item.dart
class RowItem {
  final String id;
  final String code;
  final String description;
  final String unit;
  final double quantity;
  final double unitPrice;
  final String category;

  RowItem({
    required this.id,
    required this.code,
    required this.description,
    required this.unit,
    required this.quantity,
    required this.unitPrice,
    required this.category,
  });

  double get totalPrice => quantity * unitPrice;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'code': code,
      'description': description,
      'unit': unit,
      'quantity': quantity,
      'unitPrice': unitPrice,
      'category': category,
    };
  }

  factory RowItem.fromMap(Map<String, dynamic> map) {
    return RowItem(
      id: map['id'],
      code: map['code'],
      description: map['description'],
      unit: map['unit'],
      quantity: map['quantity'],
      unitPrice: map['unitPrice'],
      category: map['category'],
    );
  }
}
