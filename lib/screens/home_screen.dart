import 'package:flutter/material.dart';
import '../widgets/metreyar_table.dart'; // ← مسیر اصلاح شد

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<DataRow> tableRows = [
      DataRow(cells: [
        DataCell(Text('1')),
        DataCell(Text('سیمان')),
        DataCell(Text('کیسه')),
        DataCell(Text('20')),
        DataCell(Text('2,000,000')),
      ]),
      DataRow(cells: [
        DataCell(Text('2')),
        DataCell(Text('میلگرد')),
        DataCell(Text('کیلوگرم')),
        DataCell(Text('150')),
        DataCell(Text('15,000,000')),
      ]),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('صفحه اصلی')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: MetreyarTable(rows: tableRows),
        ),
      ),
    );
  }
}
