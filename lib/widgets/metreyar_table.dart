// lib/widgets/metreyar_table.dart
import 'package:flutter/material.dart';
import '../models/row_item.dart';

class MetreyarTable extends StatelessWidget {
  final List<RowItem> rows;

  const MetreyarTable({required this.rows, super.key});

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: const [
        DataColumn(label: Text('ردیف')),
        DataColumn(label: Text('شرح')),
        DataColumn(label: Text('مقدار')),
        DataColumn(label: Text('بهای واحد')),
        DataColumn(label: Text('جمع')),
      ],
      rows: rows.map((row) {
        return DataRow(
          cells: [
            DataCell(Text((rows.indexOf(row) + 1).toString())),
            DataCell(Text(row.description)),
            DataCell(Text(row.quantity.toString())),
            DataCell(Text(row.unitPrice.toString())),
            DataCell(Text(row.total.toString())),
          ],
        );
      }).toList(),
    );
  }
}
