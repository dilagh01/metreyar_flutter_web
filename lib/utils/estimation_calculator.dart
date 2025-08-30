import '../models/row_item.dart';

class EstimationCalculator {
  static double calculateTotal(List<RowItem> items) {
    return items.fold(0, (sum, item) => sum + item.totalPrice);
  }

  static Map<String, double> calculateCategoryTotals(List<RowItem> items) {
    Map<String, double> totals = {};
    for (var item in items) {
      totals[item.category] = (totals[item.category] ?? 0) + item.totalPrice;
    }
    return totals;
  }
}
