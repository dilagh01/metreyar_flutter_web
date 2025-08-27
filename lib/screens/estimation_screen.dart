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

  void _addItem() {
    setState(() {
      _items.add({
        "desc": "محصول جدید",
        "unit": "عدد",
        "qty": 1,
        "price": 1000,
      });
    });
  }

  void _removeItem(int index) {
    setState(() {
      _items.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: DataTable(
              border: TableBorder.all(color: Colors.grey.shade400),
              columns: const [
                DataColumn(label: Text("ردیف")),
                DataColumn(label: Text("شرح آیتم")),
                DataColumn(label: Text("واحد")),
                DataColumn(label: Text("مقدار")),
                DataColumn(label: Text("بهای واحد")),
                DataColumn(label: Text("بهای کل")),
                DataColumn(label: Text("حذف")),
              ],
              rows: List.generate(_items.length, (index) {
                final item = _items[index];
                final total = item["qty"] * item["price"];
                return DataRow(
                  cells: [
                    DataCell(Text("${index + 1}")),
                    DataCell(Text(item["desc"])),
                    DataCell(Text(item["unit"])),
                    DataCell(Text("${item["qty"]}")),
                    DataCell(Text("${item["price"]}")),
                    DataCell(Text("$total")),
                    DataCell(
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _removeItem(index),
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: _addItem,
          child: const Text("افزودن آیتم جدید"),
        ),
      ],
    );
  }
}
