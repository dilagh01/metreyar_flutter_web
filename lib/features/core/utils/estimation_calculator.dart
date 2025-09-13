class EstimationCalculator {
  static double calculateTotal(List<dynamic> items) {
    return items.fold(0.0, (sum, item) {
      final quantity = item.quantity ?? 0.0;
      final unitPrice = item.unitPrice ?? 0.0;
      return sum + (quantity * unitPrice);
    });
  }
}
