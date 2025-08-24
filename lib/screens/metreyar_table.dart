import 'package:flutter/material.dart';
import '../models/row_item.dart';

class MetreyarTable extends StatelessWidget {
  final List<RowItem> rows;

  const MetreyarTable({super.key, required this.rows});

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: const [
        DataColumn(label: Text('عنوان')),
        DataColumn(label: Text('مقدار')),
      ],
      rows: rows
          .map(
            (row) => DataRow(
              cells: [
                DataCell(Text(row.title)),
                DataCell(Text(row.value.toString())),
              ],
            ),
          )
          .toList(),
    );
  }
}
