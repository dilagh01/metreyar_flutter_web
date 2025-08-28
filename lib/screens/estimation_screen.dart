import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';

class EstimationScreen extends StatelessWidget {
  const EstimationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("برآورد"),
        backgroundColor: Colors.blue[700],
      ),
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
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("حذف آیتم"),
          content: const Text("آیا از حذف این آیتم اطمینان دارید؟"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("لغو"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _items.removeAt(index);
                });
                Navigator.of(context).pop();
              },
              child: const Text("حذف", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  void _editDescription(int index, String newDesc) {
    setState(() {
      _items[index]["desc"] = newDesc;
    });
  }

  void _editUnit(int index, String newUnit) {
    setState(() {
      _items[index]["unit"] = newUnit;
    });
  }

  int get _grandTotal {
    return _items.fold(
      0,
      (sum, item) =>
          sum + ((item["qty"] ?? 0) as int) * ((item["price"] ?? 0) as int),
    );
  }

  String _formatNumber(int number) {
    return number.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable2(
                columnSpacing: 12,
                horizontalMargin: 12,
                minWidth: 800,
                columns: const [
                  DataColumn(label: Text("ردیف", style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text("شرح آیتم", style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text("واحد", style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text("مقدار", style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text("بهای واحد (ریال)", style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text("بهای کل (ریال)", style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text("عملیات", style: TextStyle(fontWeight: FontWeight.bold))),
                ],
                rows: List.generate(_items.length, (index) {
                  final item = _items[index];
                  final total = (item["qty"] as int) * (item["price"] as int);
                  return DataRow(
                    cells: [
                      DataCell(Center(child: Text("${index + 1}"))),
                      DataCell(
                        TextFormField(
                          initialValue: item["desc"],
                          onChanged: (val) => _editDescription(index, val),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(horizontal: 8),
                          ),
                        ),
                      ),
                      DataCell(
                        TextFormField(
                          initialValue: item["unit"],
                          onChanged: (val) => _editUnit(index, val),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(horizontal: 8),
                          ),
                        ),
                      ),
                      DataCell(
                        TextFormField(
                          initialValue: item["qty"].toString(),
                          keyboardType: TextInputType.number,
                          onChanged: (val) {
                            setState(() {
                              item["qty"] = int.tryParse(val) ?? item["qty"];
                            });
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(horizontal: 8),
                          ),
                        ),
                      ),
                      DataCell(
                        TextFormField(
                          initialValue: _formatNumber(item["price"]),
                          keyboardType: TextInputType.number,
                          onChanged: (val) {
                            setState(() {
                              final cleanValue = val.replaceAll(',', '');
                              item["price"] = int.tryParse(cleanValue) ?? item["price"];
                            });
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(horizontal: 8),
                          ),
                        ),
                      ),
                      DataCell(
                        Center(
                          child: Text(
                            _formatNumber(total),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      DataCell(
                        Center(
                          child: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _removeItem(index),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton.icon(
                onPressed: _addItem,
                icon: const Icon(Icons.add),
                label: const Text("افزودن آیتم جدید"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
              ),
              Text(
                "جمع کل: ${_formatNumber(_grandTotal)} ریال",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
