import 'package:flutter/material.dart';
import '../models/project.dart';
import '../models/row_item.dart';
import '../widgets/metreyar_table.dart';
import '../utils/formula_evaluator.dart';

class HomeScreen extends StatelessWidget {
  final Project project = Project(
    name: 'پروژه نمونه متره‌یار',
    rows: [
      RowItem(description: 'سیمان', quantity: 100, unitPrice: 5000),
      RowItem(description: 'ماسه', quantity: 50, unitPrice: 3000),
    ],
  );

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final total = FormulaEvaluator.calculateTotal(project.rows);

    return Scaffold(
      appBar: AppBar(title: Text(project.name)),
      body: Column(
        children: [
          MetreyarTable(rows: project.rows),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text('جمع کل پروژه: $total'),
          ),
        ],
      ),
    );
  }
}
