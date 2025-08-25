class Project {
  final String name;
  final List<RowItem> rows;

  Project({required this.name, required this.rows});
}

// lib/models/row_item.dart
class RowItem {
  final String description;
  final double quantity;
  final double unitPrice;
  double get total => quantity * unitPrice; // فرمول ساده

  RowItem({required this.description, required this.quantity, required this.unitPrice});
}
