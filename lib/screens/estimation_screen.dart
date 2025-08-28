import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';

class EditableMetreTablePage extends StatefulWidget {
  const EditableMetreTablePage({super.key});

  @override
  State<EditableMetreTablePage> createState() => _EditableMetreTablePageState();
}

class _EditableMetreTablePageState extends State<EditableMetreTablePage> {
  List<Map<String, dynamic>> rows = [];

  int calcTotal(int qty, int unitPrice) => qty * unitPrice;

  void addRow() {
    setState(() {
      rows.add({
        "ردیف": rows.length + 1,
        "کد فهرست": "----",
        "شرح آیتم": "",
        "واحد": "عدد",
        "مقدار": 0,
        "بهای واحد": 0,
      });
    });
  }

  void deleteRow(int index) {
    setState(() {
      rows.removeAt(index);
      for (int i = 0; i < rows.length; i++) {
        rows[i]["ردیف"] = i + 1;
      }
    });
  }

  int get grandTotal {
    int sum = 0;
    for (var row in rows) {
      sum += calcTotal(row["مقدار"], row["بهای واحد"]);
    }
    return sum;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("جدول متره قابل ویرایش"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: "افزودن ردیف جدید",
            onPressed: addRow,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: DataTable2(
          border: TableBorder.all(color: Colors.grey),
          columnSpacing: 12,
          horizontalMargin: 12,
          minWidth: 900,
          headingRowColor: WidgetStateProperty.all(Colors.blueGrey[50]),
          columns: const [
            DataColumn(label: Text('ردیف')),
            DataColumn(label: Text('کد فهرست')),
            DataColumn(label: Text('شرح آیتم')),
            DataColumn(label: Text('واحد')),
            DataColumn(label: Text('مقدار')),
            DataColumn(label: Text('بهای واحد')),
            DataColumn(label: Text('بهای کل')),
            DataColumn(label: Text('عملیات')),
          ],
          rows: [
            ...List<DataRow>.generate(
              rows.length,
              (index) => DataRow(
                cells: [
                  DataCell(Text(rows[index]["ردیف"].toString())),
                  DataCell(
                    TextFormField(
                      initialValue: rows[index]["کد فهرست"],
                      onChanged: (val) {
                        setState(() => rows[index]["کد فهرست"] = val);
                      },
                    ),
                  ),
                  DataCell(
                    TextFormField(
                      initialValue: rows[index]["شرح آیتم"],
                      onChanged: (val) {
                        setState(() => rows[index]["شرح آیتم"] = val);
                      },
                    ),
                  ),
                  DataCell(
                    TextFormField(
                      initialValue: rows[index]["واحد"],
                      onChanged: (val) {
                        setState(() => rows[index]["واحد"] = val);
                      },
                    ),
                  ),
                  DataCell(
                    TextFormField(
                      initialValue: rows[index]["مقدار"].toString(),
                      keyboardType: TextInputType.number,
                      onChanged: (val) {
                        setState(() => rows[index]["مقدار"] = int.tryParse(val) ?? 0);
                      },
                    ),
                  ),
                  DataCell(
                    TextFormField(
                      initialValue: rows[index]["بهای واحد"].toString(),
                      keyboardType: TextInputType.number,
                      onChanged: (val) {
                        setState(() => rows[index]["بهای واحد"] = int.tryParse(val) ?? 0);
                      },
                    ),
                  ),
                  DataCell(
                    Text(calcTotal(rows[index]["مقدار"], rows[index]["بهای واحد"]).toString()),
                  ),
                  DataCell(
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      tooltip: "حذف ردیف",
                      onPressed: () => deleteRow(index),
                    ),
                  ),
                ],
              ),
            ),
            // 🔽 ردیف جمع کل
            DataRow(
              color: WidgetStateProperty.all(Colors.grey.shade300),
              cells: [
                const DataCell(Text("")),
                const DataCell(Text("")),
                const DataCell(Text("")),
                const DataCell(Text("جمع کل", style: TextStyle(fontWeight: FontWeight.bold))),
                const DataCell(Text("")),
                const DataCell(Text("")),
                DataCell(Text(
                  grandTotal.toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )),
                const DataCell(Text("")),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: addRow,
        icon: const Icon(Icons.add),
        label: const Text("افزودن ردیف جدید"),
      ),
    );
  }
}
