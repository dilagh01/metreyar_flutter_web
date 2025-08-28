import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';

class EstimationScreen extends StatelessWidget {
  const EstimationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("متره و برآورد"),
        backgroundColor: Colors.blue[700],
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: EstimationTable(),
      ),
    );
  }
}

class EstimationGroup {
  String title;
  List<EstimationItem> items;
  bool isExpanded;

  EstimationGroup({
    required this.title,
    required this.items,
    this.isExpanded = true,
  });
}

class EstimationItem {
  String description;
  String unit;
  double quantity;
  double unitPrice;
  String? code; // کد فهرست بها

  EstimationItem({
    required this.description,
    required this.unit,
    required this.quantity,
    required this.unitPrice,
    this.code,
  });

  double get totalPrice => quantity * unitPrice;
}

class EstimationTable extends StatefulWidget {
  const EstimationTable({super.key});

  @override
  _EstimationTableState createState() => _EstimationTableState();
}

class _EstimationTableState extends State<EstimationTable> {
  final List<EstimationGroup> _groups = [
    EstimationGroup(
      title: "فونداسیون و زمین",
      items: [
        EstimationItem(
          description: "خاکبرداری با ماشین",
          unit: "متر مکعب",
          quantity: 100,
          unitPrice: 15000,
          code: "010101",
        ),
        EstimationItem(
          description: "خاکریزی و تراکم",
          unit: "متر مکعب",
          quantity: 80,
          unitPrice: 25000,
          code: "010102",
        ),
      ],
    ),
    EstimationGroup(
      title: "اسکلت فلزی",
      items: [
        EstimationItem(
          description: "تیرآهن IPE 18",
          unit: "کیلوگرم",
          quantity: 500,
          unitPrice: 45000,
          code: "020101",
        ),
        EstimationItem(
          description: "ورق سیاه 10mm",
          unit: "کیلوگرم",
          quantity: 200,
          unitPrice: 55000,
          code: "020102",
        ),
      ],
    ),
    EstimationGroup(
      title: "نازک کاری",
      items: [
        EstimationItem(
          description: "آجرکاری 20cm",
          unit: "متر مربع",
          quantity: 150,
          unitPrice: 120000,
          code: "030101",
        ),
        EstimationItem(
          description: "سیمان کاری دیوار",
          unit: "متر مربع",
          quantity: 200,
          unitPrice: 80000,
          code: "030102",
        ),
      ],
    ),
  ];

  void _addGroup() {
    setState(() {
      _groups.add(EstimationGroup(
        title: "گروه جدید",
        items: [
          EstimationItem(
            description: "آیتم جدید",
            unit: "عدد",
            quantity: 1,
            unitPrice: 1000,
          )
        ],
      ));
    });
  }

  void _addItemToGroup(int groupIndex) {
    setState(() {
      _groups[groupIndex].items.add(EstimationItem(
            description: "آیتم جدید",
            unit: "عدد",
            quantity: 1,
            unitPrice: 1000,
          ));
    });
  }

  void _removeGroup(int groupIndex) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("حذف گروه"),
          content: const Text("آیا از حذف این گروه و تمامی آیتم‌های آن اطمینان دارید؟"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("لغو"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _groups.removeAt(groupIndex);
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

  void _removeItem(int groupIndex, int itemIndex) {
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
                  _groups[groupIndex].items.removeAt(itemIndex);
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

  double get _grandTotal {
    return _groups.fold(0.0, (sum, group) {
      return sum + group.items.fold(0.0, (groupSum, item) => groupSum + item.totalPrice);
    });
  }

  String _formatNumber(double number) {
    return number.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );
  }

  Widget _buildGroupTable(EstimationGroup group, int groupIndex) {
    final double groupTotal = group.items.fold(0.0, (sum, item) => sum + item.totalPrice);

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ExpansionTile(
        initiallyExpanded: group.isExpanded,
        onExpansionChanged: (expanded) {
          setState(() {
            group.isExpanded = expanded;
          });
        },
        leading: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () => _removeGroup(groupIndex),
        ),
        title: Row(
          children: [
            Text(
              group.title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const Spacer(),
            Text(
              "جمع گروه: ${_formatNumber(groupTotal)} ریال",
              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
            ),
          ],
        ),
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable2(
              columnSpacing: 12,
              horizontalMargin: 12,
              minWidth: 1000,
              columns: const [
                DataColumn(label: Text("ردیف", style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(label: Text("کد فهرست", style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(label: Text("شرح آیتم", style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(label: Text("واحد", style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(label: Text("مقدار", style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(label: Text("بهای واحد (ریال)", style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(label: Text("بهای کل (ریال)", style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(label: Text("عملیات", style: TextStyle(fontWeight: FontWeight.bold))),
              ],
              rows: List.generate(group.items.length, (itemIndex) {
                final item = group.items[itemIndex];
                return DataRow(
                  cells: [
                    DataCell(Center(child: Text("${itemIndex + 1}"))),
                    DataCell(
                      TextFormField(
                        initialValue: item.code ?? "",
                        onChanged: (val) {
                          setState(() {
                            item.code = val;
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
                        initialValue: item.description,
                        onChanged: (val) {
                          setState(() {
                            item.description = val;
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
                        initialValue: item.unit,
                        onChanged: (val) {
                          setState(() {
                            item.unit = val;
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
                        initialValue: item.quantity.toString(),
                        keyboardType: TextInputType.number,
                        onChanged: (val) {
                          setState(() {
                            item.quantity = double.tryParse(val) ?? item.quantity;
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
                        initialValue: _formatNumber(item.unitPrice),
                        keyboardType: TextInputType.number,
                        onChanged: (val) {
                          setState(() {
                            final cleanValue = val.replaceAll(',', '');
                            item.unitPrice = double.tryParse(cleanValue) ?? item.unitPrice;
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
                          _formatNumber(item.totalPrice),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    DataCell(
                      Center(
                        child: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _removeItem(groupIndex, itemIndex),
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () => _addItemToGroup(groupIndex),
              child: const Text("افزودن آیتم به این گروه"),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: _groups.length,
            itemBuilder: (context, index) {
              return _buildGroupTable(_groups[index], index);
            },
          ),
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.blue),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ElevatedButton.icon(
                    onPressed: _addGroup,
                    icon: const Icon(Icons.add),
                    label: const Text("افزودن گروه جدید"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "تعداد گروه‌ها: ${_groups.length}",
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "جمع کل پروژه: ${_formatNumber(_grandTotal)} ریال",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  Text(
                    "معادل: ${(_grandTotal / 1000000).toStringAsFixed(2)} میلیون ریال",
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
