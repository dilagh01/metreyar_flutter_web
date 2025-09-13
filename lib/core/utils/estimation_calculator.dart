class EstimationCalculator {
  // محاسبه جمع کل
  static double calculateTotal(List<dynamic> items) {
    return items.fold(0.0, (sum, item) {
      final quantity = item.quantity ?? 0.0;
      final unitPrice = item.unitPrice ?? 0.0;
      return sum + (quantity * unitPrice);
    });
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
  static Map<String, double> calculateByCategory(List<dynamic> items) {
    final Map<String, double> categoryTotals = {};
    
    for (final item in items) {
      final category = item.material?.category ?? 'دسته‌بندی نشده';
      final quantity = item.quantity ?? 0.0;
      final unitPrice = item.unitPrice ?? 0.0;
      final total = quantity * unitPrice;
      
      categoryTotals.update(
        category,
        (value) => value + total,
        ifAbsent: () => total,
      );
    }
    
    return categoryTotals;
  }
}
