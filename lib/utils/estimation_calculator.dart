// lib/utils/estimation_calculator.dart
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

  static double calculateWithTax(double amount, double taxPercentage) {
    return amount * (1 + taxPercentage / 100);
  }
}
