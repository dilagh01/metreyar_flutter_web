// lib/widgets/estimation_table.dart
import 'package:flutter/material.dart';

class EstimationTable extends StatefulWidget {
  const EstimationTable({super.key});

  @override
  State<EstimationTable> createState() => _EstimationTableState();
}

class _EstimationTableState extends State<EstimationTable> {
  final List<Map<String, dynamic>> _items = [
    {"desc": "آجر فشاری", "unit": "متر مکعب", "qty": 10, "price": 500000},
    {"desc": "سیمان", "unit": "کیلوگرم", "qty": 200, "price": 3000},
  ];

  @override
  Widget build(BuildContext context) {
    return DataTable(
      border: TableBorder.all(color: Colors.grey.shade400),
      columns: const [
        DataColumn(label: Text("ردیف")),
        DataColumn(label: Text("شرح آیتم")),
        DataColumn(label: Text("واحد")),
        DataColumn(label: Text("مقدار")),
        DataColumn(label: Text("بهای واحد")),
        DataColumn(label: Text("بهای کل")),
      ],
      rows: List.generate(_items.length, (index) {
        final item = _items[index];
        final total = item["qty"] * item["price"];
        return DataRow(cells: [
          DataCell(Text("${index + 1}")),
          DataCell(Text(item["desc"])),
          DataCell(Text(item["unit"])),
          DataCell(Text("${item["qty"]}")),
          DataCell(Text("${item["price"]}")),
          DataCell(Text("$total")),
        ]);
      }),
    );
  }
}
