// utils/advanced_calculations.dart
class AdvancedCalculations {
  // محاسبه با در نظر گرفتن درصد اتلاف
  static double calculateWithWaste(double quantity, double wastePercentage) {
    return quantity * (1 + wastePercentage / 100);
  }

  // محاسبه مالیات و عوارض
  static double calculateWithTax(double amount, double taxPercentage, double dutyPercentage) {
    return amount * (1 + (taxPercentage + dutyPercentage) / 100);
  }

  // محاسبه سود و overhead
  static double calculateWithProfit(double amount, double profitPercentage, double overheadPercentage) {
    return amount * (1 + (profitPercentage + overheadPercentage) / 100);
  }

  // تبدیل واحد
  static double convertUnit(double value, double conversionFactor) {
    return value * conversionFactor;
  }

  // محاسبه قیمت تمام شده با تمام عوامل
  static double calculateFinalPrice({
    required double quantity,
    required double unitPrice,
    double wastePercentage = 0,
    double taxPercentage = 0,
    double dutyPercentage = 0,
    double profitPercentage = 0,
    double overheadPercentage = 0,
    double conversionFactor = 1,
  }) {
    double convertedQuantity = convertUnit(quantity, conversionFactor);
    double quantityWithWaste = calculateWithWaste(convertedQuantity, wastePercentage);
    double baseAmount = quantityWithWaste * unitPrice;
    double amountWithTax = calculateWithTax(baseAmount, taxPercentage, dutyPercentage);
    double finalAmount = calculateWithProfit(amountWithTax, profitPercentage, overheadPercentage);
    
    return finalAmount;
  }
}
