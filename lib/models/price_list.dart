class PriceItem {
  final String code;
  final String name;
  final String unit;
  final double unitPrice;
  final String? category;
  final String? formula;
  final Map<String, dynamic>? parameters;

  PriceItem({
    required this.code,
    required this.name,
    required this.unit,
    required this.unitPrice,
    this.category,
    this.formula,
    this.parameters,
  });

  factory PriceItem.fromJson(Map<String, dynamic> json) {
    return PriceItem(
      code: json['code'],
      name: json['name'],
      unit: json['unit'],
      unitPrice: (json['unit_price'] ?? 0).toDouble(),
      category: json['category'],
      formula: json['formula'],
      parameters: Map<String, dynamic>.from(json['parameters'] ?? {}),
    );
  }
}

class CalculationRequest {
  final String itemCode;
  final Map<String, double> quantities;

  CalculationRequest({
    required this.itemCode,
    required this.quantities,
  });

  Map<String, dynamic> toJson() => {
    'item_code': itemCode,
    'quantities': quantities,
  };
}

class CalculationResult {
  final bool success;
  final String itemCode;
  final Map<String, double> quantities;
  final double result;

  CalculationResult({
    required this.success,
    required this.itemCode,
    required this.quantities,
    required this.result,
  });

  factory CalculationResult.fromJson(Map<String, dynamic> json) {
    return CalculationResult(
      success: json['success'] ?? false,
      itemCode: json['item_code'] ?? '',
      quantities: Map<String, double>.from(json['quantities'] ?? {}),
      result: (json['result'] ?? 0).toDouble(),
    );
  }
}
