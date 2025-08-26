import 'package:flutter/material.dart';
import 'metreyar_table.dart';
import '../widgets/row_item.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List<RowItem> tableRows = [
    RowItem(index: 1, item: 'سیمان', unit: 'کیسه', quantity: 20, price: 2000000),
    RowItem(index: 2, item: 'میلگرد', unit: 'کیلوگرم', quantity: 150, price: 15000000),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: MetreyarTable(rows: tableRows),
        ),
      ),
    );
  }
}
