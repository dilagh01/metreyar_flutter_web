class RowItem {
  String description;
  double quantity;
  double unitPrice;

  RowItem({
    required this.description,
    required this.quantity,
    required this.unitPrice,
  });

  double get total => quantity * unitPrice;
}
