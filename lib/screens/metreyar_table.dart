import 'package:flutter/material.dart';
import 'row_item.dart';

class MetreyarTable extends StatelessWidget {
  final List<RowItem> rows;

  const MetreyarTable({super.key, required this.rows});

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(),
      columnWidths: const {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(1),
      },
      children: rows.map((row) => TableRow(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(row.title, style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(row.value.toString()),
          ),
        ],
      )).toList(),
    );
  }
}
