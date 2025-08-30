import '../models/row_item.dart';

class EstimationCalculator {
  static double calculateTotal(List<RowItem> items) {
    return items.fold(0, (sum, item) => sum + (item.quantity * item.unitPrice));
  }

  static Map<String, double> calculateCategoryTotals(List<RowItem> items) {
    Map<String, double> totals = {};
    for (var item in items) {
      totals[item.category] = (totals[item.category] ?? 0) + (item.quantity * item.unitPrice);
    }
    return totals;
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
