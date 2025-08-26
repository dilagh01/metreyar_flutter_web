// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import '../widgets/metreyar_table.dart';
import '../widgets/row_item.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List<RowItem> tableRows = [
    RowItem(col1: 'ردیف 1', col2: 'مقدار 1'),
    RowItem(col1: 'ردیف 2', col2: 'مقدار 2'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MetreyarTable(rows: tableRows),
      ),
    );
  }
}
