import 'package:flutter/material.dart';

class DataTableWidget extends StatelessWidget {
  const DataTableWidget({super.key});

  final List<Map<String, String>> data = const [
    {"ردیف": "1", "شرح": "فعالیت نمونه 1", "مقدار": "10", "واحد": "مترمربع", "قیمت": "100000"},
    {"ردیف": "2", "شرح": "فعالیت نمونه 2", "مقدار": "20", "واحد": "مترمربع", "قیمت": "200000"},
    {"ردیف": "3", "شرح": "فعالیت نمونه 3", "مقدار": "30", "واحد": "مترمربع", "قیمت": "300000"},
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const [
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
