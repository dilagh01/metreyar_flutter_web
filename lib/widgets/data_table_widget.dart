import 'package:flutter/material.dart';

class DataTableWidget extends StatelessWidget {
  final List<Map<String, String>> data = List.generate(10, (index) {
    return {
      "ردیف": "${index + 1}",
      "شرح": "فعالیت نمونه ${index + 1}",
      "مقدار": "${(index + 1) * 10}",
      "واحد": "مترمربع",
      "قیمت": "${(index + 1) * 100000}"
    };
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: [
          DataColumn(label: Text("ردیف")),
          DataColumn(label: Text("شرح")),
          DataColumn(label: Text("مقدار")),
          DataColumn(label: Text("واحد")),
          DataColumn(label: Text("قیمت")),
        ],
        rows: data.map((item) {
          return DataRow(cells: [
            DataCell(Text(item["ردیف"]!)),
            DataCell(Text(item["شرح"]!)),
            DataCell(Text(item["مقدار"]!)),
            DataCell(Text(item["واحد"]!)),
            DataCell(Text(item["قیمت"]!)),
          ]);
        }).toList(),
      ),
    );
  }
}
