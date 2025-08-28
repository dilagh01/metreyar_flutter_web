// utils/estimation_calculator.dart
class EstimationCalculator {
  static double calculateTotal(List<Map<String, dynamic>> items) {
    double total = 0;
    for (var item in items) {
      total += (item['quantity'] ?? 0) * (item['unitPrice'] ?? 0);
    }
    return total;
  }

  static double calculateWithWaste(double quantity, double wastePercentage) {
    return quantity * (1 + wastePercentage / 100);
  }

  static Map<String, double> calculateCategoryTotals(List<Map<String, dynamic>> items) {
    Map<String, double> totals = {};
    for (var item in items) {
      String category = item['category'] ?? 'دسته‌بندی نشده';
      double amount = (item['quantity'] ?? 0) * (item['unitPrice'] ?? 0);
      totals[category] = (totals[category] ?? 0) + amount;
    }
    return totals;
  }
}
