// lib/features/estimation/widgets/estimation_summary.dart
class EstimationSummary extends StatelessWidget {
  final EstimationModel estimation;

  const EstimationSummary({super.key, required this.estimation});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('خلاصه برآورد', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            _buildSummaryRow('جمع کل:', estimation.grandTotal),
            _buildSummaryRow('مالیات (۹٪):', estimation.tax),
            _buildSummaryRow('جمع نهایی:', estimation.totalWithTax),
            const SizedBox(height: 16),
            ..._buildCategoryTotals(),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, double value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text('${value.toStringAsFixed(2)} ریال'),
        ],
      ),
    );
  }

  List<Widget> _buildCategoryTotals() {
    return estimation.categoryTotals.entries.map((entry) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('${entry.key}:'),
            Text('${entry.value.toStringAsFixed(2)} ریال'),
          ],
        ),
      );
    }).toList();
  }
}
