import 'package:flutter/material.dart'; // ✅ این خط را اضافه کنید
import '../models/row_item.dart';
import '../utils/estimation_calculator.dart';

class ChartWidget extends StatelessWidget {
  final List<RowItem> items;

  const ChartWidget({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    final grandTotal = EstimationCalculator.calculateTotal(items);
    final categoryTotals = EstimationCalculator.calculateCategoryTotals(items);

    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('خلاصه مالی', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('جمع کل: ${grandTotal.toStringAsFixed(2)} ریال', 
                 style: TextStyle(fontSize: 18, color: Colors.blue)),
            SizedBox(height: 10),
            ...categoryTotals.entries.map((entry) => 
              Row(
                children: [
                  Expanded(child: Text(entry.key)),
                  Text('${entry.value.toStringAsFixed(2)} ریال'),
                ],
              )
            ).toList(),
          ],
        ),
      ),
    );
  }
}
