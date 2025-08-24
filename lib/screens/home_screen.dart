import 'package:flutter/material.dart';
import '../models/row_item.dart';
import '../models/project.dart';
import '../widgets/metreyar_table.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List<RowItem> rows = [
    RowItem(title: 'سیمان', value: 5000),
    RowItem(title: 'ماسه', value: 3000),
  ];

  final Project project = Project(
    name: 'پروژه نمونه',
    createdAt: DateTime.now(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('خانه')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('پروژه: ${project.name}'),
            const SizedBox(height: 20),
            MetreyarTable(rows: rows), // جدول با title و value
          ],
        ),
      ),
    );
  }
}
