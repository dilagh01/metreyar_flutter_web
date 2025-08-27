import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';

class EstimationScreen extends StatelessWidget {
  const EstimationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("برآورد")),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: EstimationTable(),
      ),
    );
  }
}

class EstimationTable extends StatefulWidget {
  const EstimationTable({super.key});

  @override
  _EstimationTableState createState() => _EstimationTableState();
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

  int get _grandTotal {
    return _items.fold(
      0,
      (sum, item) =>
          sum + ((item["qty"] ?? 0) as int) * ((item["price"] ?? 0) as int),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable2(
              columnSpacing: 12,
              horizontalMargin: 12,
              minWidth: 800,
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
                final total = (item["qty"] as int) * (item["price"] as int);
                return DataRow(
                  cells: [
                    DataCell(Text("${index + 1}")),
                    DataCell(Text(item["desc"])),
                    DataCell(Text(item["unit"])),
                    DataCell(
                      TextFormField(
                        initialValue: item["qty"].toString(),
                        keyboardType: TextInputType.number,
                        onChanged: (val) {
                          setState(() {
                            item["qty"] = int.tryParse(val) ?? item["qty"];
                          });
                        },
                      ),
                    ),
                    DataCell(
                      TextFormField(
                        initialValue: item["price"].toString(),
                        keyboardType: TextInputType.number,
                        onChanged: (val) {
                          setState(() {
                            item["price"] = int.tryParse(val) ?? item["price"];
                          });
                        },
                      ),
                    ),
                    DataCell(Text("$total")),
                    DataCell(
                      IconButton(
                        icon: Icon(Icons.delete,
                            color: Colors.red.withAlpha(128)),
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
        const SizedBox(height: 10),
        Text(
          "جمع کل: $_grandTotal ریال",
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
