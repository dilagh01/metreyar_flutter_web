import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/project.dart';
import '../models/row_item.dart';
import '../widgets/metreyar_table.dart';
import '../utils/formula_evaluator.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key}); // ✅ const اضافه شد

  @override
  Widget build(BuildContext context) {
    // نمونه داده برای تست
    final project = Project(
      name: 'پروژه نمونه',
      createdAt: DateTime.now(),
      rows: [
        RowItem(description: 'سیمان', quantity: 100, unitPrice: 5000),
        RowItem(description: 'ماسه', quantity: 50, unitPrice: 3000),
      ],
    );

    final total = FormulaEvaluator.calculateTotal(project.rows);

    return Scaffold(
      appBar: AppBar(title: Text(project.name)),
      body: Column(
        children: [
          MetreyarTable(rows: project.rows),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('جمع کل: $total'),
          ),
        ],
      ),
    );
  }
}
