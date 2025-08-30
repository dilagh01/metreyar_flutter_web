import 'package:flutter/material.dart';

class RowItem {
  final String category;
  final double value;

  RowItem({required this.category, required this.value});
}

class EstimationCalculator {
  /// محاسبه جمع کل
  static double calculateTotal(List<RowItem> items) {
    return items.fold(0, (sum, item) => sum + item.value);
  }

  /// محاسبه جمع دسته‌بندی‌ها
  static Map<String, double> calculateCategoryTotals(List<RowItem> items) {
    final Map<String, double> totals = {};
    for (var item in items) {
      totals[item.category] = (totals[item.category] ?? 0) + item.value;
    }
    return totals;
  }
}

class EstimationScreen extends StatefulWidget {
  const EstimationScreen({super.key});

  @override
  State<EstimationScreen> createState() => _EstimationScreenState();
}

class _EstimationScreenState extends State<EstimationScreen> {
  final List<RowItem> items = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Estimation")),
      body: _buildSummarySection(context, items),
    );
  }

  /// اصلاح شده: همیشه یک ویجت برمی‌گردونه
  Widget _buildSummarySection(BuildContext context, List<RowItem> items) {
    if (items.isEmpty) {
      return const Center(child: Text("هیچ داده‌ای وجود ندارد"));
    }

    final grandTotal = EstimationCalculator.calculateTotal(items);
    final categoryTotals = EstimationCalculator.calculateCategoryTotals(items);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("جمع کل: $grandTotal"),
        const SizedBox(height: 8),
        ...categoryTotals.entries.map((e) => Text("${e.key}: ${e.value}")),
      ],
    );
  }
}
