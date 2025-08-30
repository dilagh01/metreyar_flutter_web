// lib/widgets/data_table_widget.dart
import 'package:flutter/material.dart';
import '../models/row_item.dart';

class DataTableWidget extends StatelessWidget {
  final List<RowItem> items;

  const DataTableWidget({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        columns: const [
          DataColumn(label: Text('ردیف')),
          DataColumn(label: Text('شرح آیتم')),
          DataColumn(label: Text('مقدار')),
          DataColumn(label: Text('بهای واحد')),
          DataColumn(label: Text('جمع')),
        ],
        rows: items.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          return DataRow(cells: [
            DataCell(Text('${index + 1}')),
            DataCell(Text(item.description)),
            DataCell(Text('${item.quantity} ${item.unit}')),
            DataCell(Text('${item.unitPrice.toStringAsFixed(2)}')),
            DataCell(Text('${item.totalPrice.toStringAsFixed(2)}')),
          ]);
        }).toList(),
      ),
    );
  }
}
