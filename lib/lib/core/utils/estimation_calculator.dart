// lib/core/utils/estimation_calculator.dart
class EstimationCalculator {
  // محاسبه جمع کل هر آیتم
  static double calculateItemTotal(double quantity, double unitPrice) {
    return quantity * unitPrice;
  }

  // محاسبه جمع کل برآورد
  static double calculateGrandTotal(List<EstimationItem> items) {
    return items.fold(0.0, (sum, item) => sum + calculateItemTotal(item.quantity, item.unitPrice));
  }

  // محاسبه مالیات (۹٪)
  static double calculateTax(double amount, {double taxRate = 0.09}) {
    return amount * taxRate;
  }

  // محاسبه جمع نهایی با مالیات
  static double calculateTotalWithTax(double amount, {double taxRate = 0.09}) {
    return amount + calculateTax(amount, taxRate: taxRate);
  }

  // محاسبه بر اساس دسته‌بندی
  static Map<String, double> calculateByCategory(List<EstimationItem> items) {
    final Map<String, double> categoryTotals = {};
    
    for (final item in items) {
      final category = item.material?.category ?? 'دسته‌بندی نشده';
      final total = calculateItemTotal(item.quantity, item.unitPrice);
      
      categoryTotals.update(
        category,
        (value) => value + total,
        ifAbsent: () => total,
      );
    }
    
    return categoryTotals;
  }
}
