import 'package:flutter/material.dart';
import '../widgets/metreyar_table.dart';
import '../widgets/row_item.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List<RowItem> rows = [
    RowItem(title: 'سیمان', value: 5000),
    RowItem(title: 'ماسه', value: 3000),
    RowItem(title: 'آهن', value: 7000),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('صفحه اصلی')),
      body: Center(
        child: MetreyarTable(rows: rows),
      ),
    );
  }
}
