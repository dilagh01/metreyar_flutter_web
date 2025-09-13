import '../../data/models/estimation_model.dart';

class EstimationCalculator {
  // محاسبه جمع کل
  static double calculateTotal(List<EstimationItem> items) {
    return items.fold(0.0, (sum, item) => sum + (item.quantity * item.unitPrice));
  }

  // محاسبه مالیات (9%)
  static double calculateTax(double amount, {double taxRate = 0.09}) {
    return amount * taxRate;
  }

  // محاسبه جمع نهایی با مالیات
  static double calculateTotalWithTax(double amount, {double taxRate = 0.09}) {
    return amount + calculateTax(amount, taxRate: taxRate);
  }

  // گروه‌بندی بر اساس دسته‌بندی
  static Map<String, double> calculateByCategory(List<EstimationItem> items) {
    final Map<String, double> categoryTotals = {};
    
    for (final item in items) {
      final category = item.material.category;
      final total = item.quantity * item.unitPrice;
      
      categoryTotals.update(
        category,
        (value) => value + total,
        ifAbsent: () => total,
      );
    }
    
    return categoryTotals;
  }

  // محاسبه درصد هر دسته‌بندی
  static Map<String, double> calculateCategoryPercentages(Map<String, double> categoryTotals, double grandTotal) {
    final Map<String, double> percentages = {};
    
    categoryTotals.forEach((category, total) {
      percentages[category] = (total / grandTotal) * 100;
    });
    
    return percentages;
  }
}
