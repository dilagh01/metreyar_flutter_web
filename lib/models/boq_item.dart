  int id;
  String description;
  String unit;
  double quantity;
  double unitPrice;
  double totalPrice;

  BOQItem({
    required this.id,
    required this.description,
    required this.unit,
    required this.quantity,
    required this.unitPrice,
  }) : totalPrice = quantity * unitPrice;

  void recalc() {
    totalPrice = quantity * unitPrice;
  }
}
