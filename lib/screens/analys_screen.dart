// lib/screens/analysis_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/estimation_provider.dart';
import '../utils/estimation_calculator.dart';
import '../widgets/chart_widget.dart';

class AnalysisScreen extends StatelessWidget {
  AnalysisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EstimationProvider>(context);
    final categoryTotals = EstimationCalculator.calculateCategoryTotals(provider.items);

    return Scaffold(
      appBar: AppBar(title: Text('آنالیز پروژه')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('آنالیز مالی پروژه', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            
            // کارت‌های آماری
            Row(
              children: [
                _buildStatCard('جمع کل', '${provider.grandTotal.toStringAsFixed(2)} ریال', Colors.blue),
                SizedBox(width: 10),
                _buildStatCard('تعداد آیتم‌ها', '${provider.items.length} عدد', Colors.green),
              ],
            ),
            SizedBox(height: 20),
            
            // نمودار
            ChartWidget(items: provider.items),
            SizedBox(height: 20),
            
            // breakdown دسته‌بندی
            Text('Breakdown بر اساس دسته‌بندی:', style: TextStyle(fontWeight: FontWeight.bold)),
            ...categoryTotals.entries.map((entry) => 
              ListTile(
                title: Text(entry.key),
                trailing: Text('${entry.value.toStringAsFixed(2)} ریال'),
              )
            ).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, Color color) {
    return Expanded(
      child: Card(
        color: color,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Text(title, style: TextStyle(color: Colors.white)),
              Text(value, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}
